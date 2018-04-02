//
//  FormTableViewController.swift
//  ARC_Circles
//
//  Created by Joaquin Perez on 04/02/2018.
//  Copyright © 2018 Joaquin Perez. All rights reserved.
//

import UIKit

class FormTableViewController: UITableViewController, SelectionTableViewControllerDelegate {
    
    lazy var selectionTVC = SelectionTableViewController.init(style: .plain)
    
    var option = 0
    
    var list: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.register(UINib.init(nibName: "FormCell", bundle: nil), forCellReuseIdentifier: "formCellReuse")
        
        list = ["País", "Número de identificación", "Valor a introducir", "Nombre"]
        
    }


    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return list.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "formCellReuse", for: indexPath) as! FormCell

        cell.label.text = list[indexPath.row]
        cell.textField.isUserInteractionEnabled = false

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectionTVC.listOfOptions = ["España", "Portugal"]
        switch option {
        case 0:
            let selectInMap = SelectionInMapViewController()
            navigationController?.pushViewController(selectInMap, animated: true)
            
//        selectionTVC.listOfOptions = ["España", "Portugal"]
//        selectionTVC.delegate = self
//        selectionTVC.row = indexPath.row
            
        default:
            selectionTVC.selectionClosure = { // [unowned self]
                string in
                let cell = self.tableView.cellForRow(at: indexPath) as! FormCell
                cell.textField.text = string
            }
            navigationController?.pushViewController(selectionTVC, animated: true)
        }


        
    }
    
   func selectionIs(string:String, atRow:Int)
   {
    let cell = tableView.cellForRow(at: IndexPath(row: atRow, section: 0)) as! FormCell
    cell.textField.text = string

   }
    
    deinit {
       
        print("Bye bye FormTableViewController")
    }
  

}
