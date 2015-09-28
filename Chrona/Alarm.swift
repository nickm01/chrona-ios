import Foundation

class Alarm {
    var time: NSDate
    var repeat: Bool
    var active: Bool
    
    init (time: NSDate, repeat: Bool) {
        self.time = time
        self.repeat = repeat
        self.active = false
    }

}