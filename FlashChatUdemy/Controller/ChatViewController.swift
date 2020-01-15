//
//  ViewController.swift
//  FlashChatUdemy
//
//  Created by SINCY on 14/01/20.
//  Copyright © 2020 SINCY. All rights reserved.
//

import UIKit
import Firebase
import ChameleonFramework

class ChatViewController: UIViewController {
    
    var messageArray = [Message]()
    
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var messageTextfield: UITextField!
    @IBOutlet var messageTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
        messageTableView.addGestureRecognizer(tapGesture)
        
        messageTableView.register(UINib(nibName: "CustomMessageCell", bundle: nil), forCellReuseIdentifier: "customMessageCell")
        messageTableView.rowHeight = UITableView.automaticDimension
        messageTableView.estimatedRowHeight = 120.0
        retrieveMessages()
    }

    @IBAction func sendPressed(_ sender: AnyObject) {
        messageTextfield.endEditing(true)
        messageTextfield.isEnabled = false
        sendButton.isEnabled = false
        
        let messagesDB = Database.database().reference().child("Messages")
        let msgDict = [
            "sender": Auth.auth().currentUser?.email,
            "msgBody": messageTextfield.text
        ]
        
        messagesDB.childByAutoId().setValue(msgDict) { (err, reference) in
            if err != nil {
                print(err!)
            } else {
                print("msg saved successfully")
                self.messageTextfield.isEnabled = true
                self.sendButton.isEnabled = true
                self.messageTextfield.text = ""
            }
        }
    }
    
    @objc func tableViewTapped() {
        messageTextfield.endEditing(true)
    }
    
    @IBAction func logOutPressed(_ sender: AnyObject) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        }
        catch {
            print("error while signing out")
        }
    }
    
    func retrieveMessages() {
        let messageDB = Database.database().reference().child("Messages")
        
        messageDB.observe(.childAdded) { (snapshot) in
            if let snapshotVal = snapshot.value as? [String: String], let sender = snapshotVal["sender"], let text = snapshotVal["msgBody"] {
                let message = Message(sender: sender, messageBody: text)
                self.messageArray.append(message)
                self.messageTableView.reloadData()
            }
        }
    }
}

// MARK: - Table view data source methods
extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell") as! CustomMessageCell
        
        let message = messageArray[indexPath.row]
        cell.senderUsername.text = message.sender
        cell.messageBody.text = message.messageBody
        cell.avatarImageView.image = UIImage(named: "egg")
        
        if message.sender == Auth.auth().currentUser?.email {
            cell.avatarImageView.backgroundColor = UIColor.flatMint()
            cell.messageBackground.backgroundColor = UIColor.flatSkyBlue()
        } else {
            cell.avatarImageView.backgroundColor = UIColor.flatWatermelon()
            cell.messageBackground.backgroundColor = UIColor.flatGray()
        }
        
        return cell
    }
    
    
}

extension ChatViewController: UITableViewDelegate {
    
}

extension ChatViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5) {
            self.heightConstraint.constant = 308
            self.view.layoutIfNeeded()
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5) {
            self.heightConstraint.constant = 50
            self.view.layoutIfNeeded()
        }
    }
}
