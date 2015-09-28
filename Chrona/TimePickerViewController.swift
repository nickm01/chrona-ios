//
//  TimePickerViewController.swift
//  Chrona
//
//  Created by Jake Strang on 9/15/15.
//  Copyright (c) 2015 Ultradia. All rights reserved.
//

import UIKit

class TimePickerViewController: UIViewController {

    @IBOutlet weak var timePicker: UIDatePicker!
    
    var delegate: communicationAlarm? = nil
    var alarmIndex: Int? = nil
    
    override func viewDidLoad() {
        timePicker.setValue(UIColor.whiteColor(), forKeyPath: "textColor")
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func backButtonTouch(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func saveButtonTouch(sender: AnyObject) {
        self.delegate?.backFromAddAlarm(timePicker.date)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
