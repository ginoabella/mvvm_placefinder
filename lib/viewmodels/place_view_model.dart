import 'package:place_finder/models/place.dart';

class PlaceViewModel {
  Place _place;

  //PlaceViewModel(Place place) : _place = place;

  PlaceViewModel(Place place) {
    _place = place;
  }

  String get placeId => _place.placeId;

  String get photoURL => _place.photoURL;

  String get name => _place.name;

  double get latitude => _place.latitude;

  double get longitude => _place.longitude;
}
