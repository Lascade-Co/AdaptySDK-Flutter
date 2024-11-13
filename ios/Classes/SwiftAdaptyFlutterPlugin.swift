import Adapty
import AdaptyPlugin
import Flutter

public final class SwiftAdaptyFlutterPlugin: NSObject, FlutterPlugin {
    private static let channelName = "flutter.adapty.com/adapty"
    private static var channel: FlutterMethodChannel?
    private static let pluginInstance = SwiftAdaptyFlutterPlugin()
    private static var delegate: SwiftAdaptyFlutterPluginDelegate?

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(
            name: channelName,
            binaryMessenger: registrar.messenger()
        )

        registrar.addMethodCallDelegate(Self.pluginInstance, channel: channel)
        registrar.addApplicationDelegate(Self.pluginInstance)

        Self.channel = channel

        let delegate = SwiftAdaptyFlutterPluginDelegate { method, args in
            Self.channel?.invokeMethod(method, arguments: args)
        }

        Adapty.delegate = Self.pluginInstance

        if #available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *) {
            AdaptyPlugin.registerCrossplatformDelegate(delegate)
        }

        let fallbackFileKey = FlutterDartProject.lookupKey(forAsset: "assets/fallback_ios.json")
        if let url = Bundle.main.url(forResource: fallbackFileKey, withExtension: nil) {
            Task {
                try await Adapty.setFallbackPaywalls(fileURL: url)
            }
        }
    }

    public func handle(
        _ call: FlutterMethodCall,
        result: @escaping FlutterResult
    ) {
        Task {
            let response = await AdaptyPlugin.execute(
                method: call.method,
                withJson: call.arguments as? [String: Any] ?? [:]
            )
            result(response.asAdaptyJsonString)
        }
    }
}

extension SwiftAdaptyFlutterPlugin: AdaptyDelegate {
    public nonisolated func didLoadLatestProfile(_ profile: AdaptyProfile) {
        do {
            try Self.channel?.invokeMethod(
                Method.didLoadLatestProfile.rawValue,
                arguments: [Argument.profile.rawValue: profile.asAdaptyJsonData.asAdaptyJsonString]
            )
        } catch {
            AdaptyPlugin.logError("Plugin encoding error: \(error.localizedDescription)")
        }
    }
}
