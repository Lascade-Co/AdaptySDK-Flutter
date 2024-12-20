//
//  adapty_access_level_json_builder.dart
//  Adapty
//
//  Created by Alexey Goncharov on 10.11.2024.
//

import 'adapty_log_level.dart';
import '../adapty_version.dart';

part 'private/adapty_configuration_json_builder.dart';

enum AdaptyServerCluster {
  us,
  eu,
}

class AdaptyConfiguration {
  final String _apiKey;
  String? _customerUserId = null;
  bool _observerMode = false;
  bool _idfaCollectionDisabled = false;
  bool _ipAddressCollectionDisabled = false;
  String? _backendBaseUrl;
  String? _backendFallbackBaseUrl;
  String? _backendConfigsBaseUrl;
  String? _backendProxyHost;
  int? _backendProxyPort;
  String? _serverCluster;

  AdaptyLogLevel? _logLevel = AdaptyLogLevel.info;
  String _crossPlatformSDKName = 'flutter';
  String _crossPlatformSDKVersion = adaptySDKVersion;

  /// Initializes the configuration with the given API key.
  ///
  /// **Parameters:**
  /// - [apiKey]: You can find it in your app settings in [Adapty Dashboard](https://app.adapty.io/) *App settings* > *General*.
  AdaptyConfiguration({
    required String apiKey,
  }) : _apiKey = apiKey;

  /// **Parameters:**
  /// - [customerUserId]: User identifier in your system
  void withCustomerUserId(String? customerUserId) {
    _customerUserId = customerUserId;
  }

  /// **Parameters:**
  /// - [observerMode]: A boolean value controlling [Observer mode](https://docs.adapty.io/docs/observer-vs-full-mode/). Turn it on if you handle purchases and subscription status yourself and use Adapty for sending subscription events and analytics
  void withObserverMode(bool observerMode) {
    _observerMode = observerMode;
  }

  /// **Parameters:**
  /// - [idfaCollectionDisabled]: A boolean value controlling IDFA collection logic
  void withIdfaCollectionDisabled(bool idfaCollectionDisabled) {
    _idfaCollectionDisabled = idfaCollectionDisabled;
  }

  /// **Parameters:**
  /// - [ipAddressCollectionDisabled]: A boolean value controlling IP address collection logic
  void withIpAddressCollectionDisabled(bool ipAddressCollectionDisabled) {
    _ipAddressCollectionDisabled = ipAddressCollectionDisabled;
  }

  /// **Parameters:**
  /// - [logLevel]: A log level for the SDK
  void withLogLevel(AdaptyLogLevel logLevel) {
    _logLevel = logLevel;
  }

  void withBackendBaseUrl(String backendBaseUrl) {
    _backendBaseUrl = backendBaseUrl;
  }

  void withBackendFallbackBaseUrl(String backendFallbackBaseUrl) {
    _backendFallbackBaseUrl = backendFallbackBaseUrl;
  }

  void withBackendConfigsBaseUrl(String backendConfigsBaseUrl) {
    _backendConfigsBaseUrl = backendConfigsBaseUrl;
  }

  void withBackendProxyHost(String backendProxyHost) {
    _backendProxyHost = backendProxyHost;
  }

  void withBackendProxyPort(int backendProxyPort) {
    _backendProxyPort = backendProxyPort;
  }

  void withCrossPlatformSDKName(String crossPlatformSDKName) {
    _crossPlatformSDKName = crossPlatformSDKName;
  }

  void withCrossPlatformSDKVersion(String crossPlatformSDKVersion) {
    _crossPlatformSDKVersion = crossPlatformSDKVersion;
  }

  void withServerCluster(AdaptyServerCluster serverCluster) {
    switch (serverCluster) {
      case AdaptyServerCluster.eu:
        _serverCluster = 'eu';
        break;
      default:
        _serverCluster = 'default';
    }
  }
}
