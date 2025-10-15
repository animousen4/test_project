enum Flavor {
  dev,
}

class AppConfig {
  AppConfig({
    required this.flavor,
    required this.baseUrl,
    required this.webSocketUrl,
  });

  factory AppConfig.fromFlavor(Flavor flavor) {
    String baseUrl;
    String webSocketUrl;
    switch (flavor) {
      case Flavor.dev:
        baseUrl = 'https://jsonplaceholder.typicode.com';
        webSocketUrl = '';
        break;
    }

    return AppConfig(
      flavor: flavor,
      baseUrl: baseUrl,
      webSocketUrl: webSocketUrl,
    );
  }
  final Flavor flavor;
  final String baseUrl;
  final String webSocketUrl;

  bool get showDebugStackTrace => flavor == Flavor.dev;
}
