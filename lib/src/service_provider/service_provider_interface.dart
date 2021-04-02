import 'package:get_it/get_it.dart';
import 'package:pigeonholelive_sdk/src/service_provider/service_provider_manager.dart';

abstract class ServiceProviderInterface {
  GetIt get getIt => ServiceProviderManager.instance.getIt;

  void setup();
}
