import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {

    @IBOutlet var headerLabel: WKInterfaceLabel!
    @IBOutlet var gifImage: WKInterfaceImage!
    @IBOutlet var numberOfStepsLabel: WKInterfaceLabel!
    @IBOutlet var andCountingLabel: WKInterfaceLabel!

    var numberOfSteps = 10000
    var hasReached10000 = false
    let waitingGifs = [UIImage]()
    let celebratingGifs = [UIImage]()
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        headerLabel.setText("\(numberOfSteps) Steps")
    }

    override func willActivate() {
        super.willActivate()
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }
}
