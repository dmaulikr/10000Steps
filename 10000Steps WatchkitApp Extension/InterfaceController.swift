import WatchKit
import Foundation
import HealthKit

class InterfaceController: WKInterfaceController {

    @IBOutlet var headerLabel: WKInterfaceLabel!
    @IBOutlet var gifImage: WKInterfaceImage!
    @IBOutlet var numberOfStepsLabel: WKInterfaceLabel!
    @IBOutlet var andCountingLabel: WKInterfaceLabel!

    var hasReached10000 = false
    let steps = String()
    var randomIndex = Int()

    let waitingGifs = [
        Gif.init(name: "waiting1frame", length: 10, duration: 1),
        Gif.init(name: "waiting2frame", length: 7, duration: 1),
        Gif.init(name: "waiting3frame", length: 23, duration: 3),
        Gif.init(name: "waiting4frame", length: 180, duration: 5),
        Gif.init(name: "waiting5frame", length: 16, duration: 1),
        Gif.init(name: "waiting6frame", length: 10, duration: 1.5),
        Gif.init(name: "waiting7frame", length: 114, duration: 3),
        Gif.init(name: "waiting8frame", length: 59, duration: 3),
        Gif.init(name: "waiting9frame", length: 58, duration: 4),
        Gif.init(name: "waiting10frame", length: 23, duration: 2)
    ]

    let celebratingGifs = [
        Gif.init(name: "celebrating1frame", length: 6, duration: 1),
        Gif.init(name: "celebrating2frame", length: 22, duration: 1.5),
        Gif.init(name: "celebrating3frame", length: 14, duration: 1),
        Gif.init(name: "celebrating4frame", length: 29, duration: 1.5),
        Gif.init(name: "celebrating5frame", length: 6, duration: 1),
        Gif.init(name: "celebrating6frame", length: 40, duration: 1.5),
        Gif.init(name: "celebrating7frame", length: 15, duration: 3),
        Gif.init(name: "celebrating8frame", length: 22, duration: 1),
        Gif.init(name: "celebrating9frame", length: 23, duration: 2),
        Gif.init(name: "celebrating10frame", length: 41, duration: 4)
    ]
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)

        randomIndex = Int(arc4random_uniform(UInt32(10)))
        hasReached10000 ? setUpCelebratingView() : setUpWaitingView()
        setGifImage()
    }

    func setUpWaitingView() {
        numberOfStepsLabel.setHidden(false)
        andCountingLabel.setHidden(false)

        headerLabel.setText("Try to reach 10,000")
        numberOfStepsLabel.setText("\(steps) Steps")
        andCountingLabel.setText("Keep steppin!")
    }

    func setUpCelebratingView() {
        numberOfStepsLabel.setHidden(false)
        andCountingLabel.setHidden(false)

        headerLabel.setText("YOU DID IT!")
        numberOfStepsLabel.setText("\(steps) Steps")
    }

    func setGifImage() {
        let gif = hasReached10000 ? celebratingGifs[randomIndex] : waitingGifs[randomIndex]
        gifImage.setImageNamed(gif.name)
        gifImage.startAnimatingWithImages(in: NSRange(location: 0, length: gif.length), duration: gif.duration, repeatCount: Int.max)
    }

    override func willActivate() {
        super.willActivate()
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }
}

struct Gif {
    let name: String
    let length: Int
    let duration: Double
}


