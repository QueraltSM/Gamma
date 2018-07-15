//
//  ViewController.swift
//  Gamma
//
//  Created by Queralt Sosa Mompel on 13/7/18.
//  Copyright © 2018 Queralt Sosa Mompel. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase

struct postStruct {
    let title : String!
    let message : String!
}

class ViewController: UITableViewController {
    
    var posts = [postStruct]()
    let ref = FIRDatabase.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Retrieve data
        ref.child("Posts").queryOrderedByKey().observe(.childAdded, with: {
            snapshot in
            let value = snapshot.value as? NSDictionary
            let title = value!["title"] as? String
            let message = value!["message"] as? String
            
            self.posts.insert(postStruct(title:title,message:message), at: 0)
            self.tableView.reloadData()
        })
        post()
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func post() {
        // Save data
        let title="Title"
        let message="Message"
        
        let post : [String : AnyObject] = ["title" : title as AnyObject,
                                           "message" : message as AnyObject]
        ref.child("Posts").childByAutoId().setValue(post)
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        let label1 = cell?.viewWithTag(1) as! UILabel
        label1.text = posts[indexPath.row].title
        let label2 = cell?.viewWithTag(2) as! UILabel
        label2.text = posts[indexPath.row].message
        return cell!
    }
}


