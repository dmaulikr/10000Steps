import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var welcomeTextView: UITextView!
    @IBOutlet weak var authorizeButton: UIButton!

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var numberOfStepsLabel: UILabel!
    @IBOutlet weak var andCountingLabel: UILabel!
    @IBOutlet weak var gifImageView: FLAnimatedImageView!

    @IBOutlet weak var redBackgroundView: UIView!
    @IBOutlet weak var darkGrayBackgroundView: UIView!

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

    var randomIndex = Int()
    let defaults = UserDefaults.standard
    let healthManager:HealthManager = HealthManager()
    var isAuthorized = Bool()

    var steps = Int()
    var hasReached10000 = false

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        randomIndex = Int(arc4random_uniform(UInt32(10)))
        getStepData()
    }

    func getStepData() {
        healthManager.getCurrentNumberOfSteps(completion: { (steps, error) -> Void in
            if error != nil {
                print("Error fetching steps: \(error?.localizedDescription)")
                return
            }

            DispatchQueue.main.async(execute: { () -> Void in
                self.steps = Int(steps)
                if self.steps >= 10000 { self.hasReached10000 = true }
                else { self.hasReached10000 = false }

                self.isAuthorized = self.defaults.bool(forKey: "isAuthorized")
                if !self.isAuthorized { self.setUpAuthorizationView() }

                if self.isAuthorized {
                    self.hasReached10000 ? self.setUpCelebratingView() : self.setUpWaitingView()
                    self.getGifImage()
                }
            })
        })
    }

    func setUpAuthorizationView() {
        welcomeTextView.isHidden = false
        authorizeButton.isHidden = false

        headerLabel.isHidden = true
        numberOfStepsLabel.isHidden = true
        andCountingLabel.isHidden = true
        redBackgroundView.isHidden = true
        darkGrayBackgroundView.isHidden = true
    }

    func setUpWaitingView() {
        welcomeTextView.isHidden = true
        authorizeButton.isHidden = true

        headerLabel.isHidden = false
        numberOfStepsLabel.isHidden = false
        andCountingLabel.isHidden = false

        headerLabel.text = "Try to Reach 10,000!"
        let formattedSteps = formatNumber(of: steps)
        numberOfStepsLabel.text = "\(formattedSteps) Steps"
        andCountingLabel.text = "Keep Steppin!"
    }

    func setUpCelebratingView() {
        welcomeTextView.isHidden = true
        authorizeButton.isHidden = true

        headerLabel.isHidden = false
        numberOfStepsLabel.isHidden = false
        andCountingLabel.isHidden = false

        headerLabel.text = "YOU DID IT!"
        let formattedSteps = formatNumber(of: steps)
        numberOfStepsLabel.text = "\(formattedSteps) Steps"
        andCountingLabel.text = "and Counting!"
    }

    func formatNumber(of steps: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal

        guard let formattedNumber = numberFormatter.string(from: NSNumber(value: steps)) else { return String() }

        return formattedNumber
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

    @IBAction func didTapAuthorizeButton(_ sender: Any) {
        healthManager.authorizeHealthKit()

        //TODO: Need to wrap below in completion block for when user actually enables health data
        isAuthorized = true
        defaults.set(isAuthorized, forKey: "isAuthorized")
        getStepData()
    }
}
