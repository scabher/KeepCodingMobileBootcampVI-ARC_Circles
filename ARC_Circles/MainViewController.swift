//
//  MainViewController.swift
//  ARC_Circles
//
//  Created by Joaquin Perez on 04/02/2018.
//  Copyright © 2018 Joaquin Perez. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func presentForm(_ sender: UIButton) {
        
       let formTVController = FormTableViewController(style: .plain)
       formTVController.option = sender.tag
       navigationController?.pushViewController(formTVController, animated: true)
    }
    

}
