//
//  AnomymousViewController.swift
//  PracticaAWS
//
//  Created by Juan Antonio Martin Noguera on 17/10/2016.
//  Copyright © 2016 Cloud On Mobile. All rights reserved.
//

import UIKit
import AWSCore
import AWSCognito

class AnomymousViewController: UITableViewController {

    let credentialsProvider = AWSCognitoCredentialsProvider(
        regionType:.euWest1,
        identityPoolId:"eu-west-1:8e482ce0-358e-4948-98ff-923d7289b8c1")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        startWithAWSAnonymous()
        cognitoSyncAnonymousUserData()
    }
    
    override func viewWillAppear(_ animated: Bool) {

        let syncCognito = AWSCognito.default()

        let dataSet = syncCognito?.openOrCreateDataset("AnonymousDataSet")
        
        if let colorFondo = dataSet?.string(forKey: "Color Thema") {
            self.tableView.backgroundColor = UIColor(hexString: colorFondo)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - AWS code
    
    func startWithAWSAnonymous() {
        
        
        let configuration = AWSServiceConfiguration(
            region:.euWest1, credentialsProvider:credentialsProvider)
        AWSServiceManager.default().defaultServiceConfiguration = configuration
        
    }
    
    // - Cognito
    
    func cognitoSyncAnonymousUserData() {
        
        let syncCognito = AWSCognito.default()

        
        let dataSet = syncCognito?.openOrCreateDataset("AnonymousDataSet")
        
        dataSet?.setString("Anonymous", forKey: "Client Type")
        dataSet?.setString(UUID().uuidString, forKey: "anonymousID")
    
        dataSet?.setString(UIColor.orange.toHexString(), forKey: "Color Thema")
        
        dataSet?.synchronizeOnConnectivity().continue({ (task) -> Any? in
            
            if let _ = task.error {
                print("Tenemos un error \(task.error)")
            }
            
            return nil
            
        })
        
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

extension UIColor {
    convenience init(hexString:String) {
        let hexString:NSString = (hexString as NSString).trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines) as NSString
        let scanner            = Scanner(string: hexString as String)
        
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        
        var color:UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        self.init(red:red, green:green, blue:blue, alpha:1)
    }
    
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        
        return NSString(format:"#%06x", rgb) as String
    }
}







