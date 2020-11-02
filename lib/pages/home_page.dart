import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:place_finder/viewmodels/place_list_view_model.dart';
import 'package:place_finder/viewmodels/place_view_model.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Completer<GoogleMapController> _controller = Completer();

  Position _currentPosition;

  @override
  void initState() {
    super.initState();
  }

  Set<Marker> _getPlaceMarkers(List<PlaceViewModel> places) {
    return places
        .map(
          (place) => Marker(
            markerId: MarkerId(place.placeId),
            //icon: BitmapDescriptor.defaultMarker,
            infoWindow: InfoWindow(title: place.name),
            position: LatLng(place.latitude, place.longitude),
          ),
        )
        .toSet();
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    _controller.complete(controller);
    _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium);
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            _currentPosition.latitude,
            _currentPosition.longitude,
          ),
          zoom: 14,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<PlaceListViewModel>(context);

    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            markers: _getPlaceMarkers(vm.places),
            onMapCreated: _onMapCreated,
            initialCameraPosition: const CameraPosition(
              target: LatLng(14.406867, 120.904886),
              zoom: 14,
            ),
          ),
          SafeArea(
            child: TextField(
              onSubmitted: (value) => vm.fetchPlaceByKeywordAndPosition(
                value,
                _currentPosition.latitude,
                _currentPosition.longitude,
              ),
              decoration: const InputDecoration(
                labelText: 'Search Here',
                fillColor: Colors.white,
                filled: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
