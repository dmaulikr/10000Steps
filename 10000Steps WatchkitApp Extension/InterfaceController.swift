import WatchKit
import Foundation
import HealthKit

class InterfaceController: WKInterfaceController {

    @IBOutlet var headerLabel: WKInterfaceLabel!
    @IBOutlet var gifImage: WKInterfaceImage!
    @IBOutlet var numberOfStepsLabel: WKInterfaceLabel!
    @IBOutlet var andCountingLabel: WKInterfaceLabel!

    lazy var labels: [WKInterfaceLabel] = { return [ self.headerLabel, self.numberOfStepsLabel, self.andCountingLabel ] }()

    var hasReached10000 = false
    let steps = 10000
    var randomIndex = 0
    let successColor = UIColor(red: 72/255, green: 129/255, blue: 141/255, alpha: 1.0)


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
        setupView()
    }

    func setupView() {
        let headerText = hasReached10000  ? "YOU DID IT!" : "Try to reach 10,000"
        headerLabel.setText(headerText)
        numberOfStepsLabel.setText("\(formatNumber(of: steps)) Steps")
        let finalText = hasReached10000 ? "and Counting!" : "Keep steppin!"
        andCountingLabel.setText(finalText)

        if hasReached10000 { labels.forEach { $0.setTextColor(successColor) } }
        
        setGifImage()
    }

    func formatNumber(of steps: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal

        guard let formattedNumber = numberFormatter.string(from: NSNumber(value: steps)) else { return String() }

        return formattedNumber
    }

    func setGifImage() {
        let gif = hasReached10000 ? celebratingGifs[randomIndex] : waitingGifs[randomIndex]
        gifImage.setImageNamed(gif.name)
        gifImage.startAnimatingWithImages(in: NSRange(location: 0, length: gif.length), duration: gif.duration, repeatCount: Int.max)
    }
}

struct Gif {
    let name: String
    let length: Int
    let duration: Double
}
