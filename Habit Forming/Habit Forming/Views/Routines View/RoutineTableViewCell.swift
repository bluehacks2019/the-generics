//
//  RoutineTableViewCell.swift
//  Habit Forming
//
//  Created by Joaquin Jacinto on 24/02/2019.
//  Copyright © 2019 Team Generics. All rights reserved.
//

import UIKit

class RoutineTableViewCell: UITableViewCell {
    
    @IBOutlet weak var routineImageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var info: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
