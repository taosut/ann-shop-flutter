import 'package:ann_shop_flutter/core/core.dart';
import 'package:ann_shop_flutter/core/router.dart';
import 'package:ann_shop_flutter/core/utility.dart';
import 'package:ann_shop_flutter/model/product/product_favorite.dart';
import 'package:ann_shop_flutter/provider/favorite/favorite_provider.dart';
import 'package:ann_shop_flutter/theme/app_styles.dart';
import 'package:ann_shop_flutter/ui/product_ui/badge_tag_product_ui.dart';
import 'package:ann_shop_flutter/ui/utility/app_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductFavoriteItem extends StatelessWidget {
  ProductFavoriteItem(this.data);

  final ProductFavorite data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      child: InkWell(
        onTap: () {
          Router.showProductDetail(context, product: data.product);
        },
        child: Stack(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 90,
                  height: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(0),
                    child: AppImage(
                      Core.domain + data.product.getCover,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  flex: 1,
                  child: IntrinsicWidth(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(right: 30),
                          child: Text(
                            data.product.name,
                            textAlign: TextAlign.left,
                            style: Theme.of(context).textTheme.body2,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Mã: ' + data.product.sku,
                          textAlign: TextAlign.left,
                          style: Theme.of(context)
                              .textTheme
                              .subhead
                              .merge(TextStyle(color: Colors.grey)),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Wrap(
                            children: <Widget>[
                              Text(
                                'Giá sỉ: ' +
                                    Utility.formatPrice(
                                        data.product.regularPrice),
                                style: Theme.of(context)
                                    .textTheme
                                    .body2
                                    .merge(TextStyle(color: Colors.red)),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                '  Giá lẻ: ' +
                                    Utility.formatPrice(data.product.retailPrice),
                                style: Theme.of(context).textTheme.body2,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Container(),
                            ],
                          ),
                        ),
                        BadgeTagProductUI(data.product.badge),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Positioned(
              top: -10,
              right: -10,
              child: IconButton(
                icon: Icon(Icons.close, color: AppStyles.dartIcon,),
                onPressed: () {
                  Provider.of<FavoriteProvider>(context)
                      .removeProduct(data.product.productID);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildAmong(context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.remove_circle_outline),
          onPressed: () {
            Provider.of<FavoriteProvider>(context)
                .changeCount(data, data.count - 1);
          },
        ),
        Container(
          alignment: Alignment.center,
          child: Text(
            data.count.toString(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subhead,
          ),
        ),
        IconButton(
          icon: Icon(Icons.add_circle_outline),
          onPressed: () {
            Provider.of<FavoriteProvider>(context)
                .changeCount(data, data.count + 1);
          },
        ),
      ],
    );
  }
}
