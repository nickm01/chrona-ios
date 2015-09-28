import Foundation

class MockSleepReportManager {
    
    func getSleepReport(date: NSDate) -> SleepReport {
        let randDeepSleep = randRange(50, upper: 200)
        let randLightSleep = randRange(100, upper: 250)
        let randSleepDuration = randDeepSleep + randLightSleep
        let randInBedDuration = randSleepDuration + randRange(5, upper: 60)
        return SleepReport(date: date, deepSleep: randDeepSleep, lightSleep: randLightSleep, sleepDuration: randSleepDuration, inBedDuration: randInBedDuration)
    }
    
    private func randRange (lower: UInt32, upper: UInt32) -> Int {
        return Int(lower + arc4random_uniform(upper - lower + 1))
    }
    
}