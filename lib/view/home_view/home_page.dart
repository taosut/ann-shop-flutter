import 'dart:async';

import 'package:ann_shop_flutter/provider/category/category_provider.dart';
import 'package:ann_shop_flutter/core/core.dart';
import 'package:ann_shop_flutter/provider/product/category_product_provider.dart';
import 'package:ann_shop_flutter/provider/utility/cover_provider.dart';
import 'package:ann_shop_flutter/provider/utility/navigation_provider.dart';
import 'package:ann_shop_flutter/ui/home_page/home_banner.dart';
import 'package:ann_shop_flutter/ui/home_page/home_category.dart';
import 'package:ann_shop_flutter/ui/home_page/home_list_notification.dart';
import 'package:ann_shop_flutter/ui/home_page/home_navigation.dart';
import 'package:ann_shop_flutter/ui/home_page/home_product_slide.dart';
import 'package:ann_shop_flutter/ui/favorite/favorite_button.dart';
import 'package:ann_shop_flutter/ui/home_page/home_list_post.dart';
import 'package:ann_shop_flutter/ui/home_page/seen_block.dart';
import 'package:ann_shop_flutter/ui/utility/ann-icon.dart';
import 'package:ann_shop_flutter/view/search/search_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  ScrollController scrollController;
  StreamSubscription reTapBottom;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((callback) async {
      reTapBottom = Provider.of<NavigationProvider>(context)
          .reTap
          .stream
          .listen(onReTapBottom);
      Provider.of<CoverProvider>(context).checkLoadCoverHomePage();
    });
  }

  @override
  dispose() {
    if (reTapBottom != null) {
      reTapBottom.cancel();
    }
    super.dispose();
  }

  onReTapBottom(index) {
    if (index == 0) {
      scrollController.animateTo(0,
          duration: Duration(milliseconds: 250), curve: ElasticOutCurve(0.25));
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          if (scrollController.position.pixels != 0) {
            scrollController.animateTo(0,
                duration: Duration(milliseconds: 250),
                curve: ElasticOutCurve(0.25));
            return false;
          }
          return true;
        },
        child: RefreshIndicator(
          onRefresh: _refreshHomepage,
          child: CustomScrollView(
            controller: scrollController,
            physics: ClampingScrollPhysics(),
            slivers: <Widget>[
              SliverAppBar(
                pinned: true,
                backgroundColor: Colors.orange,
                title: Padding(
                    padding: EdgeInsets.only(left: defaultPadding),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 80,
                          padding: EdgeInsets.only(right: 15),
                          child: AnnIcon(),
                        ),
                        Expanded(
                          flex: 1,
                          child: SearchTitle('Bạn tìm gì hôm nay?'),
                        )
                      ],
                    )),
                titleSpacing: 0,
                actions: <Widget>[
                  FavoriteButton(
                    color: Colors.white,
                  ),
                ],
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  // banner
                  HomeBanner(),
                  // category
                  HomeCategory(),
                  HomeNavigation(),
                ]),
              ),
              HomeListNotification(),
              SeenBlock(),
              HomeProductSlide(),
              HomeListPost(),
              SliverToBoxAdapter(
                child: Container(
                  height: 20,
                ),
              )
            ],
          ),
        ));
  }

  Future<void> _refreshHomepage() async {
    Provider.of<CoverProvider>(context).loadNotificationHome();
    Provider.of<CoverProvider>(context).loadPostHome();
    Provider.of<CoverProvider>(context).loadCoverHome();
    Provider.of<CategoryProvider>(context).loadCDataHome();
    Provider.of<CategoryProductProvider>(context).forceRefresh();
    await Provider.of<CategoryProvider>(context).loadCategoryHome();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
