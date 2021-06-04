import 'package:floor/floor.dart';
import 'package:flutter_app_photo/data/database/dao/PhotoDao.dart';
import 'package:flutter_app_photo/data/database/dbo/PhotoDbo.dart';

import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'MakePhotoDatabase.g.dart'; // the generated code will be there

@Database(version: 1, entities: [PhotoDbo])
abstract class MakePhotoDatabase extends FloorDatabase {
  PhotoDao get photoDao;
}
