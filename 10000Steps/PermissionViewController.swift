import Foundation

class PermissionViewController: UIViewController {
    let healthManager:HealthManager = HealthManager()
    
    @IBAction func didTapAuthorize(_ sender: Any) {

        let completion: (Bool) -> Void = { result in
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            guard let runningVC = storyBoard.instantiateViewController(withIdentifier: "RunningVC") as? RunningViewController else { return }

            runningVC.defaults.set(true, forKey: "isAuthorized")
            self.dismiss(animated: true, completion: nil)
            //self.present(runningVC, animated:true, completion:nil)
        }

        healthManager.authorizeHealthKit(completion: completion)


    }
}
