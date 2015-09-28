import UIKit

class AlarmTableViewController: UITableViewController {

    var alarms: [Alarm] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundView = UIImageView(image: UIImage(named: "background-L5"))
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        alarms.append(Alarm(time: NSDate(timeIntervalSinceNow: 10000), `repeat`: false))
        alarms.append(Alarm(time:NSDate(timeIntervalSinceNow: 12000), `repeat`: false))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return alarms.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("alarm_cell", forIndexPath: indexPath) as! AlarmTableViewCell
        
        let alarm = alarms[indexPath.row] as Alarm
        let calendar = NSCalendar.currentCalendar()
        let comp = calendar.components(([.Hour, .Minute]), fromDate: alarm.time)
        cell.timeLabel.text = String(comp.hour) + ":" + String(comp.minute)
        cell.activeSwitch.setOn(alarm.active, animated: false)
        
        return cell
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

}
