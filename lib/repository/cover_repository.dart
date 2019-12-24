import 'dart:convert';
import 'dart:io';

import 'package:ann_shop_flutter/core/core.dart';
import 'package:ann_shop_flutter/model/utility/cover.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class CoverRepository {
  static final CoverRepository instance = CoverRepository._internal();

  factory CoverRepository() => instance;

  CoverRepository._internal() {
    /// init
  }

  /// http://xuongann.com/api/flutter/home/banners
  Future<List<Cover>> loadCoverHome() async {
    try {
      final url = Core.domain + 'api/flutter/home/banners';
      final response = await http.get(url).timeout(Duration(seconds: 5));
      log(url);
      log(response.body);
      if (response.statusCode == HttpStatus.ok) {
        var message = jsonDecode(response.body);
        List<Cover> _data = new List();
        message.forEach((v) {
          _data.add(new Cover.fromJson(v));
        });
        return _data;
      }
    } catch (e) {
      log(e);
    }
    return null;
  }

  Future<List<Cover>> loadCoverHomeOffline() async {
    try {
      final url = 'assets/offline/banner_home.json';
      final response = await rootBundle.loadString(url);
      var message = jsonDecode(response);
      List<Cover> _data = new List();
      message.forEach((v) {
        _data.add(new Cover.fromJson(v));
      });
      return _data;
    } catch (e) {
      log(e);
    }
    return null;
  }

  log(object) {
    print('cover_repository: ' + object.toString());
  }
}
