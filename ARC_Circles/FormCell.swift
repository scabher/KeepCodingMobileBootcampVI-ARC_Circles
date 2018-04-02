//
//  FormCell.swift
//  ARC_Circles
//
//  Created by Joaquin Perez on 04/02/2018.
//  Copyright © 2018 Joaquin Perez. All rights reserved.
//

import UIKit

class FormCell: UITableViewCell {


    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var textField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
