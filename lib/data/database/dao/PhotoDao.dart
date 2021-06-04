import 'package:floor/floor.dart';
import 'package:flutter_app_photo/data/database/dbo/PhotoDbo.dart';

@dao
abstract class PhotoDao {
  @Query("SELECT * FROM Photo WHERE path = :path")
  Future<PhotoDbo?> getPhoto(String path);

  @Query("SELECT * FROM Photo")
  Future<List<PhotoDbo>?> getPhotos();

  @insert
  Future<void> savePhoto(PhotoDbo photo);
}
