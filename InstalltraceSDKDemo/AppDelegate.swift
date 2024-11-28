import UIKit
import InstalltraceSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // 禁用InstalltraceSDK访问系统剪贴板，若禁用会影响匹配成功率
//        Installtrace.disableClipboard()
        
        Installtrace.initWith(self)
        
        setUpWindow()
        
        return true
    }
    
    func setUpWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ViewController")
        window?.rootViewController = vc
    }
    
    // UniversalLink
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        if (Installtrace.handleUniversalLink(userActivity)) {
            return true;
        }
        
        return true
    }
}

extension AppDelegate: InstalltraceDelegate {
    
    func handleWakeUpTrace(_ appData: AppInfo?) {
        if let appData = appData {
            _showWakeResult(title: "getWakeUpTrace", msg:"success, param: \(appData.paramsData ?? "")")
        } else {
            _showWakeResult(title: "getWakeUpTrace", msg: "failed to getWakeUpTrace!")
        }
    }
    
    func _showWakeResult(title: String, msg: String) {
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(action)
        self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
}


