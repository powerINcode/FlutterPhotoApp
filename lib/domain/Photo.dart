class Photo {
  final int? id;
  final String name;
  final String path;

  Photo(this.id, this.name, this.path);

  static Photo empty = Photo(0, "", "");
}
