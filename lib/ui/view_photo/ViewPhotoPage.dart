import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_photo/core/viewmodel/ViewModelProvider.dart';
import 'package:flutter_app_photo/domain/Photo.dart';

import 'ViewPhotoViewModel.dart';

class ViewPhotoPage extends StatelessWidget {
  const ViewPhotoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = ViewModelProvider.of<ViewPhotoViewModel>(context);
    return StreamBuilder(
        stream: viewModel.photoObservable,
        builder: (_, AsyncSnapshot<Photo> snapshot) {
          final photo = snapshot.data;
          return Scaffold(
              appBar: AppBar(title: Text(photo?.name ?? "")),
              body: Center(
                  child: (photo == null || photo.path.isEmpty)
                      ? Container()
                      : Image.file(File(photo.path))));
        });
  }

  static Widget navigate(String path) {
    return ViewModelProvider(
        child: ViewPhotoPage(), viewModel: ViewPhotoViewModel(path: path));
  }
}
