enum Environment { development, staging, qa, production }

class AppConfig {
  static Environment environment = Environment.staging;
  static const String stagingURL = "https://api-sandbox.glade.ng/";
  static const String productionURL = "";
  static const String countrycode = "+1";

  static final coreBaseUrl =
      environment == Environment.production ? productionURL : stagingURL;
}
