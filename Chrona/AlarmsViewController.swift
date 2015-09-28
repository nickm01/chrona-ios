import UIKit

protocol communicationAlarm {
    func backFromAddAlarm(newAlarmTime: NSDate)
}

class AlarmsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, communicationAlarm {
    
    @IBOutlet weak var addAlarmButton: UIButton!
    @IBOutlet weak var alarmTableView: UITableView!
    
    var alarms: [Alarm] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addAlarmTouch(sender: AnyObject) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let addAlarmView : TimePickerViewController = mainStoryboard.instantiateViewControllerWithIdentifier("timePickerViewController") as! TimePickerViewController
        addAlarmView.delegate = self
        
        self.presentViewController(addAlarmView, animated: true, completion: nil)
    }
    
    func backFromAddAlarm(newAlarmTime: NSDate) {
        alarms.append(Alarm(time: newAlarmTime, `repeat`: false))
        alarmTableView.reloadData()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return alarms.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("alarm_cell", forIndexPath: indexPath) as! AlarmTableViewCell
        
        let alarm = alarms[indexPath.row] as Alarm
        let calendar = NSCalendar.currentCalendar()
        let comp = calendar.components(([.Hour, .Minute]), fromDate: alarm.time)
        cell.timeLabel.text = String(comp.hour % 12) + ":" + String(comp.minute)
        cell.activeSwitch.setOn(alarm.active, animated: false)
        
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            alarms.removeAtIndex(indexPath.row)
            tableView.reloadData()
        }
    }
    
}
