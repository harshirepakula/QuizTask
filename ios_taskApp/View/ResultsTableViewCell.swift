//
//  ResultsTableViewCell.swift
//  ios_taskApp
//
//  Created by Kartheek Repakula on 13/03/21.
//  Copyright © 2021 Task. All rights reserved.
//

import UIKit

class ResultsTableViewCell: UITableViewCell {
    

    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var scoreLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
