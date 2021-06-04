import 'package:flutter_app_photo/core/LocalizeText.dart';
import 'package:flutter_app_photo/core/viewmodel/BaseViewModel.dart';
import 'package:flutter_app_photo/di/ApplicationComponent.dart';
import 'package:flutter_app_photo/domain/Photo.dart';
import 'package:flutter_app_photo/domain/PhotoRepository.dart';
import 'package:rxdart/rxdart.dart';

class MakePhotoViewModel implements BaseViewModel {
  PublishSubject<LocalizeText?> _errorSubject = PublishSubject<LocalizeText?>();
  Stream<LocalizeText?> get errorObservable => _errorSubject.stream;

  ReplaySubject<String> _imagePathSubject = ReplaySubject(maxSize: 1);
  Stream<String> get imagePathObservable => _imagePathSubject.stream;

  final _repository = ApplicationComponent.injector.get<PhotoRepository>();

  MakePhotoViewModel() {
    _imagePathSubject.add("");
  }

  void clearError() {
    _errorSubject.add(null);
  }

  void setImagePath(String imagePath) {
    _imagePathSubject.add(imagePath);
  }

  Future<bool> savePhoto(String name) async {
    LocalizeText? errorMessage;
    final imagePath = await imagePathObservable.first;
    if (imagePath.isEmpty) {
      errorMessage = LocalizeText(block: (s) => s.makePhotoErrorPhotoEmpty);
    } else if (name.isEmpty) {
      errorMessage = LocalizeText(block: (s) => s.makePhotoErrorNameEmpty);
      ;
    } else {
      errorMessage = null;
    }

    _errorSubject.add(errorMessage);
    if (name.isNotEmpty && imagePath.isNotEmpty) {
      return _repository
          .savePhoto(Photo(null, name, imagePath))
          .then((value) => true);
    } else {
      return Future.value(false);
    }
  }

  @override
  void dispose() {
    _errorSubject.close();
    _imagePathSubject.close();
  }
}
