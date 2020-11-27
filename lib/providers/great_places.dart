import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:great_places_app/database/db_file.dart';
import 'package:great_places_app/models/places.dart';

class GreatPlaces with ChangeNotifier {
  List<Places> _items = [];

  List<Places> get items {
    return [..._items];
  }

  void addPlace(String pickedTitle, File pickedImage) {
    final newPlace = Places(
        id: DateTime.now().toString(),
        title: pickedTitle,
        location: null,
        image: pickedImage);

    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.read('user_places');

    _items = dataList
        .map((item) => Places(
            id: item['id'],
            image: File(item['image']),
            title: item['title'],
            location: null))
        .toList();
    notifyListeners();
  }

  Future<void> deletePlace(String id) async {
    _items.removeWhere((element) => id == element.id);

    DBHelper.deleteBook('user_places', id);
    notifyListeners();
  }
}
