import Foundation

class RunningViewController: UIViewController {
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var gifImageView: FLAnimatedImageView!
    @IBOutlet weak var stepCountLabel: UILabel!

    let healthManager:HealthManager = HealthManager()
    let defaults = UserDefaults.standard
    var isAuthorized = Bool()

    var steps = Int()
    var hasReached10000 = false

    var randomIndex = Int()

    let waitingImageTitles = [
        "waiting1",
        "waiting2",
        "waiting3",
        "waiting4",
        "waiting5",
        "waiting6",
        "waiting7",
        "waiting8",
        "waiting9",
        "waiting10"
    ]

    let celebratingImageTitles = [
        "celebrating1",
        "celebrating2",
        "celebrating3",
        "celebrating4",
        "celebrating5",
        "celebrating6",
        "celebrating7",
        "celebrating8",
        "celebrating9",
        "celebrating10"
    ]

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        isAuthorized = self.defaults.bool(forKey: "isAuthorized")
        if !isAuthorized {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

            guard let permissionVC = storyBoard.instantiateViewController(withIdentifier: "PermissionVC") as? PermissionViewController else { return }
            self.present(permissionVC, animated:true, completion:nil)

            return
        }

        randomIndex = Int(arc4random_uniform(UInt32(10)))
        getStepData()
    }

    func getStepData() {
        healthManager.getCurrentNumberOfSteps(completion: { (steps, error) -> Void in
            if error != nil {
                print("Error fetching steps: \(error?.localizedDescription ?? "Didn't work")")
                return
            }

            DispatchQueue.main.async(execute: { () -> Void in
                self.steps = Int(steps)
                if self.steps >= 10000 { self.hasReached10000 = true }
                else { self.hasReached10000 = false }

                self.setSteps()

                var headerText = ""
                if self.hasReached10000 { headerText = "YOU DID IT!" }
                else { headerText = "Try to Reach 10,000!" }
                self.headerLabel.text = headerText

                self.getGifImage()
            })
        })
    }

    func setSteps() {
        let formattedSteps = formatNumber(of: steps)
        stepCountLabel.text = "\(formattedSteps) Steps"
    }

    func getGifImage() {
        let gifTitle = hasReached10000 ? celebratingImageTitles[randomIndex] : waitingImageTitles[randomIndex]
        if let path =  Bundle.main.path(forResource: gifTitle, ofType: "gif") {
            if let data = NSData(contentsOfFile: path) {
                let gif = FLAnimatedImage(animatedGIFData: data as Data!)
                gifImageView.animatedImage = gif
            }
        }
    }

    func formatNumber(of steps: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal

        guard let formattedNumber = numberFormatter.string(from: NSNumber(value: steps)) else { return String() }

        return formattedNumber
    }
}
