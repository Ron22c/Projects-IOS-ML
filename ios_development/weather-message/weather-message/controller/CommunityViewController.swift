//
//  CommunityViewController.swift
//  weather-message
//
//  Created by Ranajit Chandra on 24/02/20.
//  Copyright © 2020 Ranajit Chandra. All rights reserved.
//

import UIKit
import Firebase

class CommunityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet var tableView: UITableView!
    @IBOutlet var contenttextView: UITextField!
    var messageArray : [MessageModel] = [MessageModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
        getDataFromFireBase()
    }
    
    @IBAction func sendButton(_ sender: UIButton) {
        contenttextView.isEnabled = false
        let myDB = Database.database().reference().child("discuss")
        let data = ["data": self.contenttextView.text, "user": Auth.auth().currentUser?.email]
        myDB.childByAutoId().setValue(data){
            (error, reference) in
            if error != nil {
                print(error!)
            } else {
                self.contenttextView.isEnabled = true
                print("message sent")
            }
        }
    }
    
    @IBAction func signoutButton(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch {
            print("Unable to signOut")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! TableViewCell
        cell.message.text = messageArray[indexPath.row].messeage!
        cell.username.text = messageArray[indexPath.row].user!
        return cell
    }
    
    func getDataFromFireBase() {
        let myDB = Database.database().reference().child("discuss")
        myDB.observe(.childAdded) {
            sanpshot in
            let snap = sanpshot.value as! Dictionary<String,String>
            let message = snap["data"]
            let user = snap["user"]
            
            let model = MessageModel()
            model.messeage = message
            model.user = user
            
            self.messageArray.append(model)
            self.tableView.reloadData()
        }
    }
}
