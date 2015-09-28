
import UIKit
import Firebase

class AnalyticsViewController: UIViewController {
    
    @IBOutlet weak var sleepDurationTimeLabel: UILabel!
    @IBOutlet weak var inBedTimeLabel: UILabel!
    @IBOutlet weak var deepSleepTimeLabel: UILabel!
    @IBOutlet weak var lightSleepTimeLabel: UILabel!
    @IBOutlet weak var sleepScoreNumberLabel: UILabel!
    @IBOutlet weak var sleepScoreGraphView: CircleGraphView!
    @IBOutlet weak var awakeGraphView: CircleGraphView!
    @IBOutlet weak var lightGraphView: CircleGraphView!
    @IBOutlet weak var deepGraphView: CircleGraphView!
    @IBOutlet weak var awakePercentLabel: UILabel!
    @IBOutlet weak var lightPercentLabel: UILabel!
    @IBOutlet weak var deepPercentLabel: UILabel!
    
    let sleepRecordManager = MockSleepReportManager()
    var currentRecordDate: NSDate
    var currentSleepReport: SleepReport
    
    required init?(coder aDecoder: NSCoder) {
        
        currentRecordDate = NSDate()
        currentSleepReport = sleepRecordManager.getSleepReport(currentRecordDate)
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setTimeLabels()
        setSleepScore()
        setGraphPercentages()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    private func minutesToTimeString(minutes: Int) -> String {
        let hours: Int = minutes / 60
        let minutes: Int = minutes % 60
        return String(hours) + "hrs" + String(minutes) + "min"
    }
    
    private func setTimeLabels() {
        sleepDurationTimeLabel.text = minutesToTimeString(currentSleepReport.sleepDuration)
        inBedTimeLabel.text = minutesToTimeString(currentSleepReport.inBedDuration)
        deepSleepTimeLabel.text = minutesToTimeString(currentSleepReport.deepSleep)
        lightSleepTimeLabel.text = minutesToTimeString(currentSleepReport.lightSleep)
    }
    
    private func setSleepScore() {
        let sleepScore = currentSleepReport.getSleepScore()
        sleepScoreNumberLabel.text = String(currentSleepReport.getSleepScore())
        sleepScoreGraphView.endArc = CGFloat(Float(sleepScore) / 100.0)
    }
    
    private func setGraphPercentages() {
        
        let awakeTime = currentSleepReport.inBedDuration - currentSleepReport.sleepDuration
        let awakePercent = Float(awakeTime) / Float(currentSleepReport.inBedDuration)
        awakeGraphView.arcColor = UIColor.whiteColor()
        awakeGraphView.endArc = CGFloat(awakePercent)
        awakePercentLabel.text = String(Int(awakePercent * 100)) + "%"
        
        let lightPercent = Float(currentSleepReport.lightSleep) / Float(currentSleepReport.inBedDuration)
        lightGraphView.arcColor = UIColor.blueColor()
        lightGraphView.endArc = CGFloat(lightPercent)
        lightPercentLabel.text = String(Int(lightPercent * 100)) + "%"
        
        let deepPercent = Float(currentSleepReport.deepSleep) / Float(currentSleepReport.inBedDuration)
        deepGraphView.arcColor = UIColor.yellowColor()
        deepGraphView.endArc = CGFloat(deepPercent)
        deepPercentLabel.text = String(Int(deepPercent * 100)) + "%"
    }

}
