import 'package:ann_shop_flutter/core/core.dart';
import 'package:ann_shop_flutter/core/router.dart';
import 'package:ann_shop_flutter/core/utility.dart';
import 'package:ann_shop_flutter/model/product/product.dart';
import 'package:ann_shop_flutter/ui/product_ui/badge_tag_product_ui.dart';
import 'package:ann_shop_flutter/ui/utility/app_image.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  ProductItem(this.product, {this.width = 150, this.imageHeight = 200});

  final Product product;
  final double width;
  final double imageHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width + 15,
      padding: EdgeInsets.only(left: 15),
      child: InkWell(
        onTap: () {
          Router.showProductDetail(context, product:product);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: imageHeight,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  AppImage(product.getCover),
                  Positioned(
                    left: 0,
                    top: 0,
                    child: BadgeTagProductUI(product.badge),
                  ),
                  //Provider.value(value: product, child: AddFavoriteButton(),)
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              child: Text(
                product.name,
                style: Theme.of(context).textTheme.body1,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 8),
              child: Text(
                'Mã: ' + product.sku,
                style: Theme.of(context)
                    .textTheme
                    .subhead
                    .merge(TextStyle(color: Colors.grey)),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 8),
              child: Text(
                'Giá sỉ: ' + Utility.formatPrice(product.regularPrice),
                style: Theme.of(context)
                    .textTheme
                    .body2
                    .merge(TextStyle(color: Colors.red)),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 8),
              child: Text(
                'Giá lẻ: ' + Utility.formatPrice(product.retailPrice),
                style: Theme.of(context).textTheme.body2,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
