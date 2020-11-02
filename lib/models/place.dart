class Place {
  final String name;
  final double latitude;
  final double longitude;
  final String placeId;
  final String photoURL;

  Place({
    this.name,
    this.latitude,
    this.longitude,
    this.placeId,
    this.photoURL,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    final location = json['geometry']['location'];

    final Iterable photos = json['photos'] as List;

    return Place(
      placeId: json['place_id'] as String,
      name: json['name'] as String,
      latitude: location['lat'] as double,
      longitude: location['lng'] as double,
      photoURL: photos == null
          ? 'images/place-holder.png'
          : photos.first['photo_reference'].toString(),
      //photoURL: (json['photos'][0])['photo_reference'],
    );
  }
}
