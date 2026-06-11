import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:homestay2u/models/homestay.dart';

// Service class to connect Flutter app with API
class ApiService {
  static Future<List<Homestay>> fetchHomestays({
    String keyword = '',
  }) async {
    // Feature: Load all homestays when no search keyword is entered
    String url = 'http://slum78.myddns.me/homestay2u/api/homestays';

    // Feature: Search homestays using API search endpoint
    if (keyword.trim().isNotEmpty) {
      url =
          'http://slum78.myddns.me/homestay2u/api/homestays?search=${keyword.trim()}&limit=20';
    }

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);

      List data = [];

      // Handles different possible API response structures
      if (jsonData is List) {
        data = jsonData;
      } else if (jsonData['data'] is List) {
        data = jsonData['data'];
      } else if (jsonData['data'] != null &&
          jsonData['data']['results'] is List) {
        data = jsonData['data']['results'];
      } else if (jsonData['homestays'] is List) {
        data = jsonData['homestays'];
      } else if (jsonData['results'] is List) {
        data = jsonData['results'];
      }

      List<Homestay> homestayList = [];

      for (var item in data) {
        homestayList.add(Homestay.fromJson(item));
      }

      return homestayList;
    } else {
      throw Exception('Unable to load homestays');
    }
  }
}