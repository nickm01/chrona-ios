import Foundation

public class RequestController {
    
    var baseURL: String = "https://chrona.herokuapp.com/"
    //var baseURL: String = "http://localhost:8080/"
    
    func login(email: String, password: String) -> NSDictionary? {
        
        let params = ["email":email, "password":password] as Dictionary<String, String>
        let url = "/Login"
        //NM var sessionToken: String!
        var success: Bool?
        var requestResponse: NSDictionary?
        
        self.post(params, url: url) { (succeeded: Bool, response: NSDictionary?) -> () in
            success = succeeded
            requestResponse = response
        }
        while (success == nil) {
            
        }
        return requestResponse
    }
    
    func register(email: String, password: String, firstname: String, lastname: String) -> Bool {
        
        let url = "/Register"
        let params = ["email":email, "password":password, "firstname":firstname, "lastname":lastname] as Dictionary<String, String>
        var success: Bool?
        
        self.post(params, url: url) { (succeeded: Bool, response: NSDictionary?) ->() in
            success = succeeded
        }
        while (success == nil) {
            
        }
        
        return success!
    }
    
    func logout() {
        let url = "/Logout"
        self.post(nil, url: url) { (succeeded: Bool, response: NSDictionary?) -> () in
            print("Logged Out")
        }
    }
    
    func post(params : Dictionary<String, String>?, url : String, postCompleted : (succeeded: Bool, response: NSDictionary?) -> ()) {
        
        let prefs: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let fullUrl = self.baseURL + url
        let request = NSMutableURLRequest(URL: NSURL(string: fullUrl)!)
        let session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        //nm let err: NSError?
        
        //Add parameters if any were passed in
        if (params != nil) {
            do {
                request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params!, options: [])
            } catch {
                print(error)
                request.HTTPBody = nil
            }
        }
        
        //Add session header if a session exists
        if (prefs.stringForKey("SessionToken") != nil) {
            request.addValue(prefs.stringForKey("SessionToken")!, forHTTPHeaderField: "Token")
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            print("Response: \(response)")
            guard let responseData = data else {
                print("Error response data nil")
                postCompleted(succeeded: false, response: nil)
                return
            }
            
            let strData = NSString(data: responseData, encoding: NSUTF8StringEncoding)
            print("Body: \(strData)")
            //NM let error: NSError?
            let json = try!NSJSONSerialization.JSONObjectWithData(responseData, options: .MutableLeaves) as? NSDictionary
            
            // Check for error creating JSON object
            if(error != nil) {
                print(error!.localizedDescription)
                let jsonStr = NSString(data: responseData, encoding: NSUTF8StringEncoding)
                print("Error could not parse JSON: '\(jsonStr)'")
                postCompleted(succeeded: false, response: nil)
            }
            else {
                // Check that the json has a value
                if let parseJSON = json {
                    // Return the parsed JSON
                    return postCompleted(succeeded: true, response: parseJSON)
                }
                else {
                    // JSON object was nil
                    let jsonStr = NSString(data: responseData, encoding: NSUTF8StringEncoding)
                    print("Error could not parse JSON: \(jsonStr)")
                    postCompleted(succeeded: false, response: nil)
                }
            }
        })
        
        task.resume()
    }
    
    func get(url: String, getCompleted: (succeeded: Bool, response: NSDictionary?) -> ()) {
        let prefs: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let fullUrl = self.baseURL + url
        let request = NSMutableURLRequest(URL: NSURL(string: fullUrl)!)
        let session = NSURLSession.sharedSession()
        request.HTTPMethod = "GET"
        //nm let err: NSError?
        
        //Add session header if a session exists
        if (prefs.stringForKey("SessionToken") != nil) {
            request.addValue(prefs.stringForKey("SessionToken")!, forHTTPHeaderField: "Token")
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            print("Response: \(response)")
            guard let responseData = data else {
                print("Error response data nil")
                postCompleted(succeeded: false, response: nil)
                return
            }
            let strData = NSString(data: responseData, encoding: NSUTF8StringEncoding)
            print("Body: \(strData)")
            //NM let err: NSError?
            let json = try!NSJSONSerialization.JSONObjectWithData(responseData, options: .MutableLeaves) as? NSDictionary
            
            // Check for error creating JSON object
            if(error != nil) {
                print(error!.localizedDescription)
                let jsonStr = NSString(data: responseData, encoding: NSUTF8StringEncoding)
                print("Error could not parse JSON: '\(jsonStr)'")
                getCompleted(succeeded: false, response: nil)
            }
            else {
                // Check that the json has a value
                if let parseJSON = json {
                    // Return the parsed JSON
                    return getCompleted(succeeded: true, response: parseJSON)
                }
                else {
                    // JSON object was nil
                    let jsonStr = NSString(data: responseData, encoding: NSUTF8StringEncoding)
                    print("Error could not parse JSON: \(jsonStr)")
                    getCompleted(succeeded: false, response: nil)
                }
            }
        })
        
        task.resume()
        
    }
}

