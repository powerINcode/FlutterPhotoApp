import 'package:floor/floor.dart';

@Entity(tableName: "Photo")
class PhotoDbo {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String name;
  final String path;

  PhotoDbo(this.id, this.name, this.path);
}
