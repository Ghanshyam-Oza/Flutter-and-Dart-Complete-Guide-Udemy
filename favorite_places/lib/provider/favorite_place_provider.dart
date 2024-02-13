import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

import 'package:favorite_places/models/favorite_place.dart';

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'places.db'),
    onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE user_places (id TEXT PRIMARY KEY, title TEXT, image TEXT)");
    },
    version: 1,
  );
  return db;
}

class FavoritePlaceNotifier extends StateNotifier<List<FavoritePlace>> {
  FavoritePlaceNotifier() : super([]);

  Future<void> loadPlaces() async {
    final db = await _getDatabase();
    final data = await db.query('user_places');
    final places = data
        .map((place) => FavoritePlace(
            id: place['id'] as String,
            name: place['title'] as String,
            image: File(place['image'] as String)))
        .toList();
    state = places;
  }

  void addFavoritePlace(FavoritePlace place) async {
    final name = place.name;
    // saving image on local directory of device
    final dirPath = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename(place.image.path);
    final copiedImage = await place.image.copy('${dirPath.path}/$fileName');

    place = FavoritePlace(name: name, image: copiedImage);

    state = [place, ...state];

    // storing data on local storage using sqflite package
    final db = await _getDatabase();
    db.insert('user_places', {
      "id": place.id,
      "title": place.name,
      "image": place.image.path,
    });
  }
}

var favoritePlaceProvider =
    StateNotifierProvider<FavoritePlaceNotifier, List<FavoritePlace>>(
        (ref) => FavoritePlaceNotifier());
