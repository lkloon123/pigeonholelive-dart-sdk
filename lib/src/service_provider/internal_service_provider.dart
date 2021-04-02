import 'package:dio/dio.dart';
import 'package:pigeonholelive_sdk/src/auth/auth_interface.dart';
import 'package:pigeonholelive_sdk/src/config.dart';
import 'package:pigeonholelive_sdk/src/http/internal_interceptor.dart';
import 'package:pigeonholelive_sdk/src/service_provider/service_provider_interface.dart';
import 'package:pigeonholelive_sdk/src/http/transmitter.dart';

class InternalServiceProvider extends ServiceProviderInterface {
  AuthInterface auth;
  Config? config;

  InternalServiceProvider({required this.auth, this.config});

  @override
  void setup() {
    getIt.registerSingleton<Config>(config ?? Config());
    getIt.registerSingleton<AuthInterface>(auth);
    getIt.registerLazySingleton<InternalInterceptor>(
      () => InternalInterceptor(),
    );
    getIt.registerFactory<Dio>(() {
      var dio = Dio()
        ..options.baseUrl = getIt.get<Config>().baseUrl
        ..interceptors.add(getIt.get<InternalInterceptor>());

      // custom adapter
      if (getIt.isRegistered<HttpClientAdapter>(
        instanceName: 'customHttpClientAdapter',
      )) {
        dio.httpClientAdapter = getIt.get<HttpClientAdapter>(
          instanceName: 'customHttpClientAdapter',
        );
      }

      // add additional interceptors if there's any
      if (getIt.isRegistered<List<Interceptor>>(
        instanceName: 'additionalInterceptors',
      )) {
        dio.interceptors.addAll(
          getIt.get<List<Interceptor>>(instanceName: 'additionalInterceptors'),
        );
      }

      return dio;
    });
    getIt.registerSingleton<Transmitter>(Transmitter());
  }
}
