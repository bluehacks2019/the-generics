//
//  CommunityDetailViewCell.swift
//  Habit Forming
//
//  Created by Gink on 24/02/2019.
//  Copyright © 2019 Team Generics. All rights reserved.
//

import UIKit

class CommunityDetailViewCell: UITableViewCell {

    @IBOutlet weak var threadTitle: UILabel!
    @IBOutlet weak var threadPreview: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
