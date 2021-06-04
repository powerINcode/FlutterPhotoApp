import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_photo/core/LocalizeText.dart';
import 'package:flutter_app_photo/core/viewmodel/ViewModelProvider.dart';
import 'package:flutter_app_photo/localization/l10n.dart';
import 'package:flutter_app_photo/ui/make_photo/MakePhotoViewModel.dart';
import 'package:flutter_app_photo/ui/make_photo/TakePicturePage.dart';

class MakePhotoPage extends StatefulWidget {
  const MakePhotoPage({Key? key}) : super(key: key);

  @override
  _MakePhotoPageState createState() => _MakePhotoPageState();
}

class _MakePhotoPageState extends State<MakePhotoPage> {
  final TextEditingController nameTextController = TextEditingController();

  MakePhotoViewModel get _viewModel => ViewModelProvider.of(context);
  S get _localization => S.of(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_localization.makePhotoTitle),
      ),
      body: Stack(
        children: [
          Container(
              margin: EdgeInsets.all(16),
              child: Column(
                children: _buildScreen(),
              )),
          _createErrorWidget()
        ],
      ),
    );
  }

  @override
  void dispose() {
    nameTextController.dispose();
    super.dispose();
  }

  List<Widget> _buildScreen() {
    final children = <Widget>[];
    children.addAll(_createImageGroup());
    children.add(_createButtonGroup());

    return children;
  }

  List<Widget> _createImageGroup() {
    return [
      StreamBuilder(
          stream: _viewModel.imagePathObservable,
          builder: (context, AsyncSnapshot<String?> snapshot) {
            return Expanded(child: _buildImageView(snapshot.data));
          }),
      TextField(
        controller: nameTextController,
        decoration: InputDecoration(hintText: _localization.makePhotoHint),
      )
    ];
  }

  Widget _createButtonGroup() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
            child: Padding(
          padding: EdgeInsets.only(right: 8.0),
          child: ElevatedButton(
              onPressed: _makePhoto,
              child: Text(_localization.buttonMakePhoto)),
        )),
        Expanded(
            child: Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: ElevatedButton(
              onPressed: _savePhoto,
              child: Text(_localization.buttonSavePhoto)),
        ))
      ],
    );
  }

  Widget _createErrorWidget() {
    return StreamBuilder(
        stream: _viewModel.errorObservable,
        builder: (_, AsyncSnapshot<LocalizeText?> snapshot) {
          final errorMessage = snapshot.data;

          return (errorMessage != null
              ? Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  color: Colors.red,
                  child: Text(errorMessage.getText(context)),
                )
              : Container());
        });
  }

  Widget _buildImageView(String? imagePath) {
    if (imagePath != null) {
      return Image.file(File(imagePath));
    } else {
      return Container(
        color: Colors.grey[300],
      );
    }
  }

  void _makePhoto() async {
    _viewModel.clearError();

    final camera = await _getCamera();
    final result = await _navigateToTakePicture(camera);
    print("result: ${result[TakePicturePage.RESULT_IMAGE_PATH]}");
    if (result != null && result[TakePicturePage.RESULT_IMAGE_PATH] != null) {
      var imagePath = result[TakePicturePage.RESULT_IMAGE_PATH] as String;
      _viewModel.setImagePath(imagePath);
    }
  }

  void _savePhoto() async {
    _viewModel.savePhoto(nameTextController.text).then((success) {
      if (success) {
        Navigator.of(context).pop();
      }
    });
  }

  Future<CameraDescription> _getCamera() async {
    // Ensure that plugin services are initialized so that `availableCameras()`
    // can be called before `runApp()`
    WidgetsFlutterBinding.ensureInitialized();

    // Obtain a list of the available cameras on the device.
    final cameras = await availableCameras();

    // Get a specific camera from the list of available cameras.
    return cameras.first;
  }

  Future<dynamic> _navigateToTakePicture(CameraDescription camera) async {
    return await Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => TakePicturePage(camera: camera)));
  }
}
