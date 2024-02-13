import 'dart:io';

import 'package:uuid/uuid.dart';

const uuid = Uuid();

class FavoritePlace {
  FavoritePlace({required this.name, required this.image, String? id})
      : id = id ?? uuid.v4();

  final String name;
  final String id;
  final File image;
}
