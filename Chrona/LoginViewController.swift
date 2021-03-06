
import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var EmailText: UITextField!
    @IBOutlet weak var PasswordText: UITextField!
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var RegisterButton: UIButton!
    let requestController = RequestController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginTouch(sender: AnyObject) {
        var email:NSString = EmailText.text as NSString
        var password:NSString = PasswordText.text as NSString
        var response: NSDictionary? = requestController.login(String(email), password: String(password))
        if(response?.objectForKey("sessionToken") != nil) {
            var prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
            prefs.setObject(response?.objectForKey("Token"), forKey: "SessionToken")
            prefs.synchronize()
            
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            var viewController = mainStoryboard.instantiateViewControllerWithIdentifier("tabBarController") as! UITabBarController
            UIApplication.sharedApplication().keyWindow!.rootViewController = viewController;
        }
        else {
            var alert = UIAlertController(title: "Invalid Login", message: "Invalid username or password", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func forgotPasswordTouch(sender: AnyObject) {
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

}
