import 'package:pigeonholelive_sdk/src/http/transmitter.dart';
import 'package:pigeonholelive_sdk/src/service_provider/service_provider_manager.dart';

abstract class Module {
  Transmitter get transmitter =>
      ServiceProviderManager.instance.getIt.get<Transmitter>();
}
