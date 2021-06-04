import 'package:flutter_app_photo/data/database/dao/PhotoDao.dart';
import 'package:flutter_app_photo/di/ApplicationComponent.dart';
import 'package:flutter_app_photo/domain/Photo.dart';
import 'package:flutter_app_photo/domain/PhotoRepository.dart';

import 'database/dbo/PhotoDbo.dart';

class PhotoRepositoryImpl implements PhotoRepository {
  final photoDao = ApplicationComponent.injector.get<PhotoDao>();

  @override
  Future<Photo?> getPhoto(String path) async {
    return photoDao.getPhoto(path).then((dbo) {
      if (dbo != null) {
        return _mapToDomain(dbo);
      } else {
        return null;
      }
    });
  }

  @override
  Future<List<Photo>> getPhotos() async {
    return photoDao.getPhotos().then((dbos) {
      if (dbos != null) {
        var photos = dbos.map(_mapToDomain).toList();
        return photos;
      } else {
        return [];
      }
    });
  }

  @override
  Future<void> savePhoto(Photo photo) async {
    var dbo = _mapToDbo(photo);
    photoDao.savePhoto(dbo);
  }

  Photo _mapToDomain(PhotoDbo dbo) {
    return Photo(dbo.id, dbo.name, dbo.path);
  }

  PhotoDbo _mapToDbo(Photo domain) {
    return PhotoDbo(domain.id, domain.name, domain.path);
  }
}
