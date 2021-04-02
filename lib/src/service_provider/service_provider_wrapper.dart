import 'package:get_it/get_it.dart';
import 'package:pigeonholelive_sdk/src/service_provider/service_provider_interface.dart';

class ServiceProviderWrapper extends ServiceProviderInterface {
  Function(GetIt) setupFunc;

  ServiceProviderWrapper({required this.setupFunc});

  @override
  void setup() {
    setupFunc(getIt);
  }
}
