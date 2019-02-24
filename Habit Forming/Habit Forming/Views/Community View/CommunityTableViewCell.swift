//
//  RoutineTableViewCell.swift
//  Habit Forming
//
//  Created by Joaquin Jacinto on 24/02/2019.
//  Copyright © 2019 Team Generics. All rights reserved.
//

import UIKit

class CommunityTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var communityImage: UIImageView!
    @IBOutlet weak var communityName: UILabel!
    @IBOutlet weak var communityMembers: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
