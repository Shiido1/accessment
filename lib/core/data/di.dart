import 'package:get_it/get_it.dart';
import 'package:glades/core/data/session_manager.dart';
import 'package:glades/view/provider/provider.dart';
import 'package:glades/view/provider/repo.dart';

import '../network/app_config.dart';
import '../network/network_service.dart';

final inject = GetIt.instance;
final sessionManager = SessionManager();

Future<void> initializeCore({required Environment environment}) async {
  AppConfig.environment = environment;
  await _initializeCore();
  _initServices();
  _initProviders();
}

/// Initialize the core functions here
Future<void> _initializeCore() async {
  await sessionManager.initializeSession();
  inject.registerLazySingleton<SessionManager>(() => sessionManager);
}

/// Initialize providers here
void _initProviders() {
  inject.registerLazySingleton<ProviderMainClass>(
      () => ProviderMainClass(inject()));
  // inject.registerLazySingleton<GoogleSignInProvider>(
  //     () => GoogleSignInProvider());
}

/// Initialize services's here
void _initServices() {
  inject.registerLazySingleton<NetworkService>(
      () => NetworkService(baseUrl: AppConfig.coreBaseUrl));
  inject.registerLazySingleton<Repository>(
      () => Repository(networkService: inject()));
}
