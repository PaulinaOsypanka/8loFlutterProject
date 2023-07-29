import 'dart:developer';

import 'package:http/http.dart' as http;
import '../article.dart';

class ApiService {
  Future<List<Article>?> getArticles() async {
    try {
      var uri = Uri.https('8lo.azurewebsites.net', 'article');
      var response = await http.get(uri);
      if (response.statusCode == 200) {
        List<Article> model = articlesFromJson(response.body);
        return model;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
