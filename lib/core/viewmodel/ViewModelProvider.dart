import 'package:flutter/cupertino.dart';
import 'package:flutter_app_photo/core/viewmodel/BaseViewModel.dart';

class ViewModelProvider<T extends BaseViewModel> extends StatefulWidget {

  const ViewModelProvider({Key? key, required this.child, required this.viewModel}) : super(key: key);

  final Widget child;
  final T viewModel;

  @override
  _ViewModelProviderState createState() => _ViewModelProviderState();

  static T of<T extends BaseViewModel>(BuildContext context) {
    return context.findAncestorWidgetOfExactType<ViewModelProvider<T>>()!.viewModel;
  }
}

class _ViewModelProviderState extends State<ViewModelProvider> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    widget.viewModel.dispose();
    super.dispose();
  }
}
