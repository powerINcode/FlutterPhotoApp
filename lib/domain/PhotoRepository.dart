import 'package:flutter_app_photo/domain/Photo.dart';

abstract class PhotoRepository {
  Future<List<Photo>> getPhotos();
  Future<Photo?> getPhoto(String path);
  Future<void> savePhoto(Photo photo);
}
