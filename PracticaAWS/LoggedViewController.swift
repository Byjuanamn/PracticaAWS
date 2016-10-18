//
//  LoggedViewController.swift
//  PracticaAWS
//
//  Created by Juan Antonio Martin Noguera on 17/10/2016.
//  Copyright © 2016 Cloud On Mobile. All rights reserved.
//

import UIKit
import TwitterKit
import AWSCore
import AWSCognito

class CustomAWSProvider: NSObject, AWSIdentityProviderManager{
    
    var tokens: NSDictionary
    init(tokens: [String:String]) {
        self.tokens = tokens as NSDictionary
    }
    
    @objc func logins() -> AWSTask<NSDictionary> {
        return AWSTask(result: tokens)
    }
}

class LoggedViewController: UITableViewController {

    
    var credentialsProvider: AWSCredentialsProvider?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    @IBAction func loginWithTwitterAction(_ sender: AnyObject) {
        loginWithTwitter()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    
    func loginWithTwitter() {
        
        Twitter.sharedInstance().logIn { (session, error) in
            if let _ = error {
                print(error)
                return
            }
            
            let credentials = (session?.authToken)! + ";" + (session?.authTokenSecret)!
            
            let customCrenditials = CustomAWSProvider(tokens: [AWSIdentityProviderTwitter: credentials])
            
            self.startWithTwitterCredentials(customCrenditials)
            
        }
    
    }
    
    
    func startWithTwitterCredentials(_ credentials: CustomAWSProvider) {
        
        
        credentialsProvider = AWSCognitoCredentialsProvider(regionType: .euWest1,
                                                            identityPoolId: "",
                                                            identityProviderManager: credentials)
        
        let configuration = AWSServiceConfiguration(
            region:.euWest1, credentialsProvider:credentialsProvider)
        
        
        
        AWSServiceManager.default().defaultServiceConfiguration = configuration
        

        // OJO esto ya no es valido
//        credentialsProvider.logins = ["api.twitter.com": credentials]
    }
    
    
    
    /*
     let logInButton = TWTRLogInButton { (session, error) in
     if let unwrappedSession = session {
     let alert = UIAlertController(title: "Logged In",
     message: "User \(unwrappedSession.userName) has logged in",
     preferredStyle: UIAlertControllerStyle.alert
     )
     alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
     self.present(alert, animated: true, completion: nil)
     } else {
     NSLog("Login error: %@", error!.localizedDescription);
     }
     }
     
     // TODO: Change where the log in button is positioned in your view
     logInButton.center = self.view.center
     self.view.addSubview(logInButton)

     */
    
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
