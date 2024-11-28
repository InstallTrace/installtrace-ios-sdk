import UIKit
import InstalltraceSDK

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func getParamsAction(_ sender: Any) {
        Installtrace.getInstallTrace ({[weak self] (appData: AppInfo?) in
            guard let self = self else {
                return
            }
            
            if let appData = appData {
                _showResult(title: "getInstallTrace", msg:"successed, param: \(appData.paramsData ?? "")")
            } else {
                _showResult(title: "getInstallTrace", msg: "failed, app data is nil")
            }
        }) {[weak self] (code, message: String?) in
            guard let self = self else {
                return
            }
            print("code: \(code), message: \(message ?? ""))")
            
            _showResult(title: "getInstallTrace failed", msg: "code: \(code), message: \(message ?? "")");
        }
        
    }
    
    func _showResult(title: String, msg: String) {
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
}

