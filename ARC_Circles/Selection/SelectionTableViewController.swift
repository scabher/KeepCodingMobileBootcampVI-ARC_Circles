//
//  SelectionTableViewController.swift
//  ARC_Circles
//
//  Created by Joaquin Perez on 04/02/2018.
//  Copyright © 2018 Joaquin Perez. All rights reserved.
//

import UIKit

protocol SelectionTableViewControllerDelegate:NSObjectProtocol
{
    func selectionIs(string:String, atRow:Int)
}




class SelectionTableViewController: UITableViewController {
    
    var listOfOptions:[String] = []
    var row = 0
    
     var delegate:SelectionTableViewControllerDelegate?  // With circle
   // weak var delegate:SelectionTableViewControllerDelegate?   // Without
    
    var selectionClosure:((String)->Void)?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listOfOptions.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier")
        if cell == nil
        {
         cell = UITableViewCell(style: .default, reuseIdentifier: "reuseIdentifier")
        }
        cell!.textLabel?.text = listOfOptions[indexPath.row]
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if delegate != nil {
            
            delegate?.selectionIs(string: listOfOptions[indexPath.row], atRow: row)
            
        } else if selectionClosure != nil
        {
            selectionClosure!(listOfOptions[indexPath.row])
        }
        navigationController?.popViewController(animated: true)
    }


    deinit {
       
        print("Bye bye SelectionTableViewController")
    }

}
