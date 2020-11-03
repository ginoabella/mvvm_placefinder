import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_launcher/map_launcher.dart' as launcher;
import 'package:place_finder/viewmodels/place_list_view_model.dart';
import 'package:place_finder/viewmodels/place_view_model.dart';
import 'package:place_finder/widgets/place_list.dart';
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

  Future<void> _openMapsFor(PlaceViewModel vm) async {
    if (await launcher.MapLauncher.isMapAvailable(launcher.MapType.google)) {
      await launcher.MapLauncher.showMarker(
        mapType: launcher.MapType.google,
        coords: launcher.Coords(vm.latitude, vm.longitude),
        title: vm.name,
        description: vm.name,
      );
    } else if (await launcher.MapLauncher.isMapAvailable(
        launcher.MapType.apple)) {
      await launcher.MapLauncher.showMarker(
        mapType: launcher.MapType.apple,
        coords: launcher.Coords(vm.latitude, vm.longitude),
        title: vm.name,
        description: vm.name,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<PlaceListViewModel>(context);

    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: vm.mapType,
            markers: _getPlaceMarkers(vm.places),
            onMapCreated: _onMapCreated,
            initialCameraPosition: const CameraPosition(
              target: LatLng(14.406867, 120.904886),
              zoom: 14,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
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
          ),
          Visibility(
            visible: vm.places.isNotEmpty ? true : false,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: FlatButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => PlaceList(
                          places: vm.places,
                          onSelected: _openMapsFor,
                        ),
                      );
                    },
                    color: Colors.grey,
                    child: const Text(
                      'Show List',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 150,
            right: 10,
            child: FloatingActionButton(
              onPressed: () => vm.toggleMapType(),
              child: const Icon(Icons.map),
            ),
          )
        ],
      ),
    );
  }
}
