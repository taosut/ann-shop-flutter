import 'dart:io';
import 'package:ann_shop_flutter/core/app_icons.dart';
import 'package:ann_shop_flutter/core/router.dart';
import 'package:ann_shop_flutter/provider/utility/navigation_provider.dart';
import 'package:ann_shop_flutter/ui/utility/search_input.dart';
import 'package:ann_shop_flutter/view/search/search_intro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon:
              Icon(Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back),
          onPressed: () {
            if (MediaQuery.of(context).viewInsets.bottom > 100 || true) {
              FocusScope.of(context).requestFocus(FocusNode());
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              } else {
                Provider.of<NavigationProvider>(context)
                    .switchTo(PageName.home.index);
              }
            }
          },
        ),
        titleSpacing: 0,
        title: SearchInput(),
        actions: <Widget>[
          IconButton(
            icon: Icon(AppIcons.qrcode),
            onPressed: () {
              Router.scanBarCode(context);
            },
            padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
          )
        ],
      ),
      body: SearchIntro(),
    );
  }
}
