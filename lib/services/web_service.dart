import 'dart:convert';

import 'package:place_finder/models/place.dart';
import 'package:place_finder/utils/url_helper.dart';
import 'package:http/http.dart' show Client;

class WebService {
  Client client = Client();

  Future<List<Place>> fetchPlacesByKeywordAndPosition(
    String keyword,
    double latitude,
    double longitude,
  ) async {
    final url =
        UrlHelper.urlForPlaceKeywordAndLocation(keyword, latitude, longitude);

    try {
      final response = await client.get(url);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final Iterable result = jsonResponse['results'] as List;
        return result
            .map((place) => Place.fromJson(place as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Unble to get the request');
      }
    } catch (e) {
      throw Exception('Failed get');
    }
  }
}
