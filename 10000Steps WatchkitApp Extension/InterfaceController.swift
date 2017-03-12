import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {

    @IBOutlet var headerLabel: WKInterfaceLabel!
    @IBOutlet var gifImage: WKInterfaceImage!
    @IBOutlet var numberOfStepsLabel: WKInterfaceLabel!
    @IBOutlet var andCountingLabel: WKInterfaceLabel!

    var steps = 9000
    var hasReached10000 = false
    let waitingGifs = [UIImage]()
    let celebratingGifs = [UIImage]()
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)

        steps > 9999 ? setUpCelebratingView() : setUpWaitingView()
    }

    func setUpWaitingView() {
        numberOfStepsLabel.setHidden(true)
        andCountingLabel.setHidden(true)

        let formattedSteps = formatNumber(of: steps)
        headerLabel.setText("\(formattedSteps) Steps")
    }

    func setUpCelebratingView() {
        numberOfStepsLabel.setHidden(false)
        andCountingLabel.setHidden(false)

        headerLabel.setText("YOU DID IT!")
        let formattedSteps = formatNumber(of: steps)
        numberOfStepsLabel.setText("\(formattedSteps) Steps")
    }

    func formatNumber(of steps: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal

        guard let formattedNumber = numberFormatter.string(from: NSNumber(value: steps)) else { return String() }

        return formattedNumber
    }

    override func willActivate() {
        super.willActivate()
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }
}
