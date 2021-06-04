import 'package:flutter_app_photo/core/viewmodel/BaseViewModel.dart';
import 'package:flutter_app_photo/data/PhotoRepositoryImpl.dart';
import 'package:flutter_app_photo/di/ApplicationComponent.dart';
import 'package:flutter_app_photo/domain/Photo.dart';
import 'package:flutter_app_photo/domain/PhotoRepository.dart';
import 'package:rxdart/rxdart.dart';

class GalleryViewModel implements BaseViewModel {
  final _repository = ApplicationComponent.injector.get<PhotoRepository>();

  ReplaySubject<List<Photo>> _photosSubject = ReplaySubject<List<Photo>>();
  Stream<List<Photo>> get photosObservable => _photosSubject.stream;

  GalleryViewModel() {
    fetchPhotos();
  }

  void fetchPhotos() async {
    _photosSubject.add(await _repository.getPhotos());
  }

  @override
  void dispose() {
    _photosSubject.close();
  }
}
