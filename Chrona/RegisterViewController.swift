import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var verifyPasswordText: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    let requestController = RequestController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerTouch(sender: AnyObject) {
        if (passwordText.text != verifyPasswordText.text) {
            let alert = UIAlertController(title: "Password Invalid", message: "Passwords do not match", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            let registerSuccess = requestController.register(emailText.text!, password: passwordText.text!, firstname: "FirstName", lastname: "LastName")
            if registerSuccess {
                self.dismissViewControllerAnimated(true, completion: nil)
            }
            else {
                let alert = UIAlertController(title: "Registration Failed", message: "Registration attempt failed, please check your information", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

}
