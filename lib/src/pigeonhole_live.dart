import 'package:pigeonholelive_sdk/src/auth/auth_interface.dart';
import 'package:pigeonholelive_sdk/src/config.dart';
import 'package:pigeonholelive_sdk/src/modules/attendee_module.dart';
import 'package:pigeonholelive_sdk/src/modules/custom_branding_module.dart';
import 'package:pigeonholelive_sdk/src/modules/pigeonhole_module.dart';
import 'package:pigeonholelive_sdk/src/modules/registrant_module.dart';
import 'package:pigeonholelive_sdk/src/modules/session_module.dart';
import 'package:pigeonholelive_sdk/src/modules/speaker_module.dart';
import 'package:pigeonholelive_sdk/src/modules/subscription_module.dart';
import 'package:pigeonholelive_sdk/src/modules/workspace_module.dart';
import 'package:pigeonholelive_sdk/src/service_provider/internal_service_provider.dart';
import 'package:pigeonholelive_sdk/src/service_provider/service_provider_interface.dart';
import 'package:pigeonholelive_sdk/src/service_provider/service_provider_manager.dart';

class PigeonholeLive {
  PigeonholeLive({
    required AuthInterface auth,
    Config? config,
    List<ServiceProviderInterface>? serviceProviders,
  }) {
    ServiceProviderManager.instance.reset();
    ServiceProviderManager.instance.add(
      InternalServiceProvider(auth: auth, config: config),
    );
    if (serviceProviders != null) {
      ServiceProviderManager.instance.addAll(serviceProviders);
    }
    ServiceProviderManager.instance.load();
  }

  void updateAuth({required AuthInterface auth}) {
    ServiceProviderManager.instance.getIt.registerSingleton<AuthInterface>(
      auth,
    );
  }

  // proxies
  AttendeeModuleInterface get attendee => AttendeeImpl();

  CustomBrandingModuleInterface get customBranding => CustomBrandingImpl();

  PigeonholeModuleInterface get pigeonhole => PigeonholeImpl();

  RegistrantModuleInterface get registrant => RegistrantImpl();

  SessionModuleInterface get session => SessionImpl();

  SpeakerModuleInterface get speaker => SpeakerImpl();

  SubscriptionModuleInterface get subscription => SubscriptionImpl();

  WorkspaceModuleInterface get workspace => WorkspaceImpl();
}
