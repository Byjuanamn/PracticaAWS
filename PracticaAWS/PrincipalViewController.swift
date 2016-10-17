//
//  PrincipalViewController.swift
//  PracticaAWS
//
//  Created by Juan Antonio Martin Noguera on 17/10/2016.
//  Copyright © 2016 Cloud On Mobile. All rights reserved.
//

import UIKit

class PrincipalViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func userLoggedAction(_ sender: AnyObject) {
        let storyBoardL = UIStoryboard(name: "Logged", bundle: Bundle.main)
        let vc = storyBoardL.instantiateViewController(withIdentifier: "loggedScene")
        
        present(vc, animated: true, completion: nil)

    }

    @IBAction func userAnonymousAction(_ sender: AnyObject) {
        
        let storyBoardA = UIStoryboard(name: "Anonymous", bundle: Bundle.main)
        let vc = storyBoardA.instantiateViewController(withIdentifier: "anonymousScene")
        
        present(vc, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
