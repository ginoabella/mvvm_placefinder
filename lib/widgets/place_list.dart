import 'package:flutter/material.dart';

import 'package:place_finder/utils/url_helper.dart';
import 'package:place_finder/viewmodels/place_view_model.dart';

class PlaceList extends StatelessWidget {
  final List<PlaceViewModel> places;
  final Function(PlaceViewModel) onSelected;

  const PlaceList({
    Key key,
    @required this.places,
    this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: places.length,
      itemBuilder: (context, index) {
        final place = places[index];
        return ListTile(
          onTap: () => onSelected(place),
          leading: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Container(
              width: 100,
              height: 100,
              child: Image.network(
                UrlHelper.urlForReferenceImage(place.photoURL),
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(place.name),
        );
      },
    );
  }
}
