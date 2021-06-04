import 'package:flutter_app_photo/data/PhotoRepositoryImpl.dart';
import 'package:flutter_app_photo/data/database/MakePhotoDatabase.dart';
import 'package:flutter_app_photo/di/ApplicationComponent.dart';
import 'package:flutter_app_photo/domain/PhotoRepository.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

class ApplicationModule implements Module {
  @override
  void addDependencies(Injector injector) {
    injector.map<PhotoRepository>((injector) => PhotoRepositoryImpl(),
        isSingleton: true);
  }

  @override
  Future<void> addAsyncDependencies(Injector injector) async {
    final db = await $FloorMakePhotoDatabase
        .databaseBuilder('make_photo_database.db')
        .build();

    injector.map((injector) => db, isSingleton: true);
    injector.map((injector) => db.photoDao, isSingleton: true);
  }
}
