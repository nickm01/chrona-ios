import Foundation

class SleepReport {
    var date: NSDate
    var deepSleep: Int
    var lightSleep: Int
    var sleepDuration: Int
    var inBedDuration: Int
    
    init (date: NSDate, deepSleep: Int, lightSleep: Int, sleepDuration: Int, inBedDuration: Int) {
        self.date = date
        self.deepSleep = deepSleep
        self.lightSleep = lightSleep
        self.sleepDuration = sleepDuration
        self.inBedDuration = inBedDuration
    }
    
    func getSleepScore() -> Int {
        let baseScore: Float = (sleepDuration > 420) ? 100.0 : 100.0 * (Float(sleepDuration) / 420.0)
        let ratio: Float = Float(deepSleep) / Float(lightSleep)
        let ratioFactor: Float = ratio > 0.7 ? 1.0 : ratio / 0.7
        return Int(ratioFactor * baseScore)
    }
}