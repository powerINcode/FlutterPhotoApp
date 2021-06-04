import 'package:flutter_simple_dependency_injection/injector.dart';

class ApplicationComponent {
  static final Injector injector = Injector();

  static addModule(Module module) async {
    module.addDependencies(injector);
    await module.addAsyncDependencies(injector);
  }
}

abstract class Module {
  void addDependencies(Injector injector);
  Future<void> addAsyncDependencies(Injector injector);
}
