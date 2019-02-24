//
//  SignUpViewController.swift
//  Habit Forming
//
//  Created by Joaquin Jacinto on 23/02/2019.
//  Copyright © 2019 Team Generics. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var agreeButton: UIButton!
    var agreeTerms: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func checkbox(_ sender: UIButton) {
        print("yes")
        if(agreeTerms){
            agreeButton.setImage(UIImage(named: "checkbox-unticked"), for: .normal)
            agreeTerms = false
        } else {
            agreeButton.setImage(UIImage(named: "checkbox-ticked"), for: .normal)
            agreeTerms = true
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
