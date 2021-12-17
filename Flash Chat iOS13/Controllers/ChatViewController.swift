//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase
//import FirebaseFirestore

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    let db = Firestore.firestore()
    
    var messages:[Message] = [
        Message(sender: "1@2.com", body: "Hey"),
        Message(sender: "1@s.com", body: "Hellow"),
        Message(sender: "1@2.com", body: "What's up>")
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        navigationItem.title = K.appName
        
        tableView.dataSource = self
        
        // registrar una cellda custom
        // nibName nombre del archivo este caso MessageCell
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        loadMessage()
    }
    
    func loadMessage() {
        messages = []
        
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { qerySnapshot, error in
            if let e = error {
                print("error reading db \(e)")
            } else {
                if let snapShotDocumenr = qerySnapshot?.documents {
                    self.messages = []
                    for doc in snapShotDocumenr {
                        if let sender = doc.data()[K.FStore.senderField] as? String, let messageBody = doc.data()[K.FStore.bodyField] as? String {
                            let newMessago = Message(sender: sender, body: messageBody)
                            self.messages.append(newMessago)
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
                            }
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            
            navigationController?.popToRootViewController(animated: true)
            
        } catch let signOutError as NSError {
            
            print("Error signing out: %@", signOutError)
        }
    }
    @IBAction func sendPressed(_ sender: UIButton) {
        if let bodyText = messageTextfield.text , let sender = Auth.auth().currentUser?.email {
            db.collection(K.FStore.collectionName)
                .addDocument(data: [K.FStore.senderField: sender,
                                    K.FStore.bodyField: bodyText,
                                    K.FStore.dateField: Date().timeIntervalSince1970 ]) { error in
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    print("Succes")
                    self.messageTextfield.text = ""
                }
                
            }
        }
    }
    
    
}

extension ChatViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Fetch a cell of the appropriate type.
        let message = messages[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        
        // Configure the cell’s contents.
        
        cell.label!.text = message.body
        let isCurrentUserMessage = message.sender == Auth.auth().currentUser?.email
        
        cell.messageBubble.backgroundColor = isCurrentUserMessage ? UIColor(named: K.BrandColors.lightPurple) : UIColor(named: K.BrandColors.lighBlue)
        cell.leftImageView.isHidden = isCurrentUserMessage
        cell.rightImageView.isHidden = !isCurrentUserMessage
        cell.label.textColor = isCurrentUserMessage ? UIColor(named: K.BrandColors.purple) : UIColor(named: K.BrandColors.blue)
        
        return cell
    }
    
}
