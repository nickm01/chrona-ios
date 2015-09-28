import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var logoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func logoutTouch(sender: AnyObject) {
        //FIXME destroy session through new services
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        var viewController = mainStoryboard.instantiateViewControllerWithIdentifier("loginViewController") as! LoginViewController
        UIApplication.sharedApplication().keyWindow!.rootViewController = viewController;
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
}
