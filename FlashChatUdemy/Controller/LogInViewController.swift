//
//  LogInViewController.swift
//  FlashChatUdemy
//
//  Created by SINCY on 14/01/20.
//  Copyright © 2020 SINCY. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class LogInViewController: UIViewController {
    
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logInPressed(_ sender: AnyObject) {
        guard let email = emailTextfield.text, let pass = passwordTextfield.text else {
            return
        }
        SVProgressHUD.show()
        
        Auth.auth().signIn(withEmail: email, password: pass) { (result, error) in
            if error != nil {
                print("error while logging in - \(error.debugDescription)")
            } else {
                print("Log in Successful!")
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: "goToChat", sender: self)
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
