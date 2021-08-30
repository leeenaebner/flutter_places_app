import 'package:flutter/material.dart';
import '../models/place.dart';
import 'dart:io';
import '../helpers/db_helper.dart';

class GreatPlaces with ChangeNotifier {
  static const tableName = "user_places";
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String title, File image) {
    final newPlace = Place(
      id: DateTime.now().toIso8601String(),
      image: image,
      title: title,
      location: null,
    );
    _items.add(newPlace);
    notifyListeners();

    DBHelper.insert(tableName, {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final data = await DBHelper.getData(tableName);
    _items = data
        .map((item) => Place(
            id: item['id'] as String,
            title: item['title'] as String,
            location: null,
            image: File(item['image'] as String)))
        .toList();
    notifyListeners();
  }
}
