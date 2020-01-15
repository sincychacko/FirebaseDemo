//
//  RegisterViewController.swift
//  FlashChatUdemy
//
//  Created by SINCY on 14/01/20.
//  Copyright © 2020 SINCY. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class RegisterViewController: UIViewController {
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func registerPressed(_ sender: AnyObject) {
        guard let email = emailTextfield.text, let pass = passwordTextfield.text else {
            return
        }
        SVProgressHUD.show()
        Auth.auth().createUser(withEmail: email, password: pass) { (result, error) in
            if error != nil {
                print(error!)
            } else {
                print("Registration successful")
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: "goToChat", sender: self)
            }
        }
    }

}
