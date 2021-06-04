import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_photo/core/viewmodel/ViewModelProvider.dart';
import 'package:flutter_app_photo/domain/Photo.dart';
import 'package:flutter_app_photo/localization/l10n.dart';
import 'package:flutter_app_photo/ui/gallery/GalleryViewModel.dart';
import 'package:flutter_app_photo/ui/make_photo/MakePhotoPage.dart';
import 'package:flutter_app_photo/ui/make_photo/MakePhotoViewModel.dart';
import 'package:flutter_app_photo/ui/view_photo/ViewPhotoPage.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = ViewModelProvider.of<GalleryViewModel>(context);
    var localization = S.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(localization.galleryTitle),
      ),
      body: StreamBuilder(
        stream: viewModel.photosObservable,
        initialData: <Photo>[],
        builder: (context, AsyncSnapshot<List<Photo>> snapshot) {
          final photos = snapshot.data!;
          return Column(
            children: [
              _createGrid(photos),
              ElevatedButton(
                  onPressed: () => _navigateToMakePhoto(context, viewModel),
                  child: Text(localization.buttonMakePhoto))
            ],
          );
        },
      ),
    );
  }

  Widget _createGrid(List<Photo> photos) {
    return Expanded(
        child: GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemCount: photos.length,
            itemBuilder: (BuildContext context, int i) {
              return GridTile(
                child: GestureDetector(
                  onTap: () => _navigateToViewPhoto(context, photos[i]),
                  child: Image.file(File(photos[i].path),
                      height: 64, width: 64, fit: BoxFit.fitWidth),
                ),
              );
            }));
  }

  void _navigateToViewPhoto(BuildContext context, Photo photo) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => ViewPhotoPage.navigate(photo.path)));
  }

  void _navigateToMakePhoto(BuildContext context, GalleryViewModel viewModel) {
    Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (_) => ViewModelProvider(
                child: MakePhotoPage(), viewModel: MakePhotoViewModel())))
        .then((value) => viewModel.fetchPhotos());
  }
}
