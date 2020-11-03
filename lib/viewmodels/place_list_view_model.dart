import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:place_finder/models/place.dart';
import 'package:place_finder/services/error_service.dart';
import 'package:place_finder/services/web_service.dart';
import 'package:place_finder/viewmodels/place_view_model.dart';

enum LoadingStatus { error, empty, searching, success }

class PlaceListViewModel extends ChangeNotifier {
  List<PlaceViewModel> _places = <PlaceViewModel>[];
  LoadingStatus _state;
  MapType _mapType = MapType.normal;

  LoadingStatus get state => _state;
  List<PlaceViewModel> get places => _places;
  MapType get mapType => _mapType;

  void toggleMapType() {
    _mapType = _mapType == MapType.normal ? MapType.satellite : MapType.normal;
    notifyListeners();
  }

  Future<void> fetchPlaceByKeywordAndPosition(
    String keyword,
    double latitude,
    double longitude,
  ) async {
    _state = LoadingStatus.searching;
    //notifyListeners();

    final List<Place> results = await WebService()
        .fetchPlacesByKeywordAndPosition(
          keyword,
          latitude,
          longitude,
        )
        .catchError(
          (_) => ErrorService.setError(description: 'Failed retrieving Data'),
        );
    if (ErrorService.hasError(reset: true)) {
      _state = LoadingStatus.error;
    } else {
      _places = results.map((place) => PlaceViewModel(place)).toList();
      _state = _places.isEmpty ? LoadingStatus.empty : LoadingStatus.success;
    }

    notifyListeners();
  }
}
