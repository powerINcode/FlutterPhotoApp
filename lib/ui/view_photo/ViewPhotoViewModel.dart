import 'package:flutter_app_photo/core/viewmodel/BaseViewModel.dart';
import 'package:flutter_app_photo/di/ApplicationComponent.dart';
import 'package:flutter_app_photo/domain/Photo.dart';
import 'package:flutter_app_photo/domain/PhotoRepository.dart';
import 'package:rxdart/subjects.dart';

class ViewPhotoViewModel implements BaseViewModel {
  final String path;
  final _repository = ApplicationComponent.injector.get<PhotoRepository>();
  final ReplaySubject<Photo> _photoSubject = ReplaySubject(maxSize: 1);

  ViewPhotoViewModel({required this.path}) {
    fetchPhoto();
  }

  Stream<Photo> get photoObservable => _photoSubject;

  void fetchPhoto() async {
    final photo = await _repository.getPhoto(path);
    _photoSubject.add(photo!);
  }

  @override
  void dispose() {
    _photoSubject.close();
  }
}
