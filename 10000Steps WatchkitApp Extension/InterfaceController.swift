import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {

    @IBOutlet var headerLabel: WKInterfaceLabel!
    @IBOutlet var gifImage: WKInterfaceImage!
    @IBOutlet var numberOfStepsLabel: WKInterfaceLabel!
    @IBOutlet var andCountingLabel: WKInterfaceLabel!

    var steps = 10000
    var hasReached10000 = false

    let waitingGifs = [
        gif.init(name: "waiting1frame", length: 10, duration: 1),
        gif.init(name: "waiting2frame", length: 7, duration: 1),
        gif.init(name: "waiting3frame", length: 23, duration: 3),
        gif.init(name: "waiting4frame", length: 180, duration: 5),
        gif.init(name: "waiting5frame", length: 16, duration: 1),
        gif.init(name: "waiting6frame", length: 10, duration: 1.5),
        gif.init(name: "waiting7frame", length: 114, duration: 3),
        gif.init(name: "waiting8frame", length: 59, duration: 3),
        gif.init(name: "waiting9frame", length: 58, duration: 4),
        gif.init(name: "waiting10frame", length: 23, duration: 2)
    ]

    let celebratingGifs = [
        gif.init(name: "celebrating1frame", length: 6, duration: 1),
        gif.init(name: "celebrating2frame", length: 22, duration: 1.5),
        gif.init(name: "celebrating3frame", length: 14, duration: 1),
        gif.init(name: "celebrating4frame", length: 29, duration: 1.5),
        gif.init(name: "celebrating5frame", length: 6, duration: 1),
        gif.init(name: "celebrating6frame", length: 40, duration: 1.5),
        gif.init(name: "celebrating7frame", length: 15, duration: 3),
        gif.init(name: "celebrating8frame", length: 22, duration: 1),
        gif.init(name: "celebrating9frame", length: 23, duration: 2),
        gif.init(name: "celebrating10frame", length: 41, duration: 4)
    ]

    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)

        if steps > 9999 { hasReached10000 = true }
        else { hasReached10000 = false }
        hasReached10000 ? setUpCelebratingView() : setUpWaitingView()
    }

    func setUpWaitingView() {
        numberOfStepsLabel.setHidden(true)
        andCountingLabel.setHidden(true)

        let formattedSteps = formatNumber(of: steps)
        headerLabel.setText("\(formattedSteps) Steps")

        let gif = waitingGifs[0]
        gifImage.setImageNamed(gif.name)
        gifImage.startAnimatingWithImages(in: NSRange(location: 0, length: gif.length), duration: gif.duration, repeatCount: Int.max)
    }

    func setUpCelebratingView() {
        numberOfStepsLabel.setHidden(false)
        andCountingLabel.setHidden(false)

        headerLabel.setText("YOU DID IT!")
        let formattedSteps = formatNumber(of: steps)
        numberOfStepsLabel.setText("\(formattedSteps) Steps")

        let gif = celebratingGifs[0]
        gifImage.setImageNamed(gif.name)
        gifImage.startAnimatingWithImages(in: NSRange(location: 0, length: gif.length), duration: gif.duration, repeatCount: Int.max)
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

struct gif {
    let name: String
    let length: Int
    let duration: Double
}
