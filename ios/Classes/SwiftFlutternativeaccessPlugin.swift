import Flutter
import UIKit

let PLUGIN_NAME = "flutter_native_access";
let KEEP_SCREEN_ON = "keep_screen_on"
let GET_PLATFORM_VERSION = "getPlatformVersion"
let IS_KEEP_SCREEN_ON = "is_keep_screen_on"
public class SwiftFlutternativeaccessPlugin: NSObject, FlutterPlugin {
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: PLUGIN_NAME, binaryMessenger: registrar.messenger())
        let instance = SwiftFlutternativeaccessPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
        
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case KEEP_SCREEN_ON:
            let arguments = call.arguments as! NSDictionary
            let isKeepScreenOn = arguments[IS_KEEP_SCREEN_ON] as! Bool
            keepScreenOn(isKeepScreenOn:isKeepScreenOn,result: result)
        case GET_PLATFORM_VERSION:
            result("iOS " + UIDevice.current.systemVersion)
        default:
            result("no implement")
        }
    }
    
    private func keepScreenOn(isKeepScreenOn:Bool,result: @escaping FlutterResult){
        UIApplication.shared.isIdleTimerDisabled = isKeepScreenOn
        result(true)
//        if(isKeepScreenOn){
//
//        }else{
//            result("err:param isScreenOn is null")
//        }
    }
}
