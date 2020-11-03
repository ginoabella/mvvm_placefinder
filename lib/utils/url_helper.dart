import 'package:place_finder/utils/constant_key.dart';

class UrlHelper {
  static String urlForReferenceImage(String photoReferenceId) {
    return 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=$photoReferenceId&key=$kApiKey';
  }

  static String urlForPlaceKeywordAndLocation(
    String keyword,
    double latitude,
    double longitude,
  ) {
    return 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$latitude,$longitude&radius=1500&type=restaurant&keyword=$keyword&key=$kApiKey';
  }
}
