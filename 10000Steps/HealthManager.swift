import Foundation
import HealthKit

class HealthManager {
    var healthStore: HKHealthStore = HKHealthStore()
    var numberOfSteps = Double()

    func authorizeHealthKit() {
        if HKHealthStore.isHealthDataAvailable() {
            let steps = NSSet(object: HKQuantityType.quantityType(
                forIdentifier: HKQuantityTypeIdentifier.stepCount)!)

            healthStore.requestAuthorization(toShare: nil, read: (steps as! Set<HKObjectType>)) { (success, error) -> Void in
                if success { print(success) } else { print(error!) }
            }
        } else { print("HealthKit is not available on this Device") }
    }

    func getCurrentNumberOfSteps(completion: @escaping ((Double, NSError?) -> ())) {
        let stepsCount = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)

        let date = NSDate()
        let cal = Calendar(identifier: Calendar.Identifier.gregorian)
        let newDate = cal.startOfDay(for: date as Date)

        let predicate = HKQuery.predicateForSamples(withStart: newDate as Date, end: date as Date, options: .strictStartDate)
        let interval: NSDateComponents = NSDateComponents()
        interval.day = 1

        let query = HKStatisticsCollectionQuery(quantityType: stepsCount!, quantitySamplePredicate: predicate, options: [.cumulativeSum], anchorDate: newDate as Date, intervalComponents:interval as DateComponents)

        query.initialResultsHandler = { query, results, error in
            if error != nil {
                print(error?.localizedDescription as Any)
                return
            }

            if let myResults = results{
                myResults.enumerateStatistics(from: newDate as Date, to: date as Date) {
                    statistics, stop in
                    if let quantity = statistics.sumQuantity() {
                        let steps = quantity.doubleValue(for: HKUnit.count())
                        self.numberOfSteps = steps
                        print("Steps = \(steps)")
                        completion(self.numberOfSteps, nil)
                    }
                }
            }
        }
        healthStore.execute(query)
    }
}
