import 'package:ann_shop_flutter/model/product/category.dart';
import 'package:ann_shop_flutter/model/product/product.dart';
import 'package:ann_shop_flutter/provider/response_provider.dart';
import 'package:ann_shop_flutter/repository/product_repository.dart';
import 'package:flutter/material.dart';

class CategoryProductProvider extends ChangeNotifier {

  CategoryProductProvider() {
    // instructor
  }

  Map<String, ResponseProvider<List<Product>>> categories = new Map();

  forceRefresh(){
    categories = new Map();
    notifyListeners();
  }

  ResponseProvider<List<Product>> getByCategory(Category category){
    String code = category.slug + category.name;
    if(categories[code] == null){
      categories[code] = ResponseProvider<List<Product>>();
      loadCategory(category);
    }
    return categories[code];
  }

  loadCategory(Category category, {refresh = false}) async {
    String code = category.slug + category.name;
    try {
      categories[code].loading = 'Loading';
      if(refresh)notifyListeners();
      var list = await ProductRepository.instance.loadByCategoryFilter(category, cache: true,);
      if (list == null) {
        categories[code].error = 'Load fail';
      } else {
        categories[code].completed = list;
      }
      notifyListeners();
    } catch (e) {
      categories[code].error = 'Exception: ' + e.toString();
      notifyListeners();
    }
  }
}
