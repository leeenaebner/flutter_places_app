import 'package:flutter/material.dart';
import 'package:places_app/helpers/location_helper.dart';
import '../models/place.dart';
import 'dart:io';
import '../helpers/db_helper.dart';

class GreatPlaces with ChangeNotifier {
  static const tableName = "user_places";
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Future<void> addPlace(
      String title, File image, PlaceLocation location) async {
    final address = await LocationHelper.getPlaceAddress(
        location.latitude, location.longitude);

    final updatedLocation = PlaceLocation(
        latitude: location.latitude,
        longitude: location.longitude,
        address: address);

    final newPlace = Place(
      id: DateTime.now().toIso8601String(),
      image: image,
      title: title,
      location: updatedLocation,
    );
    _items.add(newPlace);
    notifyListeners();

    DBHelper.insert(tableName, {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location!.latitude,
      'loc_lng': newPlace.location!.longitude,
      'address': newPlace.location!.address!,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final data = await DBHelper.getData(tableName);
    _items = data
        .map((item) => Place(
              id: item['id'] as String,
              title: item['title'] as String,
              location: PlaceLocation(
                  latitude: item['loc_lat'] as double,
                  longitude: item['loc_lng'] as double,
                  address: item['address'] as String),
              image: File(item['image'] as String),
            ))
        .toList();
    notifyListeners();
  }

  Place findById(String id) {
    return _items.firstWhere((place) => place.id == id);
  }
}
