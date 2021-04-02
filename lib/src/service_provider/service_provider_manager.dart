import 'package:get_it/get_it.dart';
import 'package:pigeonholelive_sdk/src/service_provider/service_provider_interface.dart';

class ServiceProviderManager {
  final List<ServiceProviderInterface> _serviceProviderList =
      <ServiceProviderInterface>[];
  final GetIt getIt;

  static final ServiceProviderManager _instance =
      ServiceProviderManager._constructor();

  ServiceProviderManager._constructor() : getIt = GetIt.asNewInstance() {
    getIt.allowReassignment = true;
  }

  static ServiceProviderManager get instance => _instance;

  void add(ServiceProviderInterface serviceProvider) {
    _serviceProviderList.add(serviceProvider);
  }

  void addAll(List<ServiceProviderInterface> serviceProviders) {
    _serviceProviderList.addAll(serviceProviders);
  }

  void reset() {
    _serviceProviderList.clear();
  }

  void load() {
    _serviceProviderList.forEach((serviceProvider) {
      serviceProvider.setup();
    });
  }
}
