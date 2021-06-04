import 'package:flutter/material.dart';
import 'package:flutter_app_photo/core/viewmodel/ViewModelProvider.dart';
import 'package:flutter_app_photo/di/ApplicationComponent.dart';
import 'package:flutter_app_photo/di/ApplicationModule.dart';
import 'package:flutter_app_photo/ui/gallery/GalleryPage.dart';
import 'package:flutter_app_photo/ui/gallery/GalleryViewModel.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'localization/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ApplicationComponent.addModule(ApplicationModule());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: ViewModelProvider(
        viewModel: GalleryViewModel(),
        child: GalleryPage(),
      ),
    );
  }
}
