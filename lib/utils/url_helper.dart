class UrlHelper {
  static String urlForPlaceKeywordAndLocation(
    String keyword,
    double latitude,
    double longitude,
  ) {
    return 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$latitude,$longitude&radius=1500&type=restaurant&keyword=$keyword&key=AIzaSyDGNc4ediJiwcxLB1Yh__QPW5JmZjBd-Bo';
  }
}

// https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=14.406867,120.904886&radius=1500&type=restaurant&keyword=store&key=AIzaSyDGNc4ediJiwcxLB1Yh__QPW5JmZjBd-Bo
// https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=37.4219527,-122.084048&radius=1500&type=restaurant&keyword=coffee&key=AIzaSyDGNc4ediJiwcxLB1Yh__QPW5JmZjBd-Bo
