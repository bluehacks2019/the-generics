//
//  ViewController.swift
//  Habit Forming
//
//  Created by Joaquin Jacinto on 23/02/2019.
//  Copyright © 2019 Team Generics. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func loginButtonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = storyboard.instantiateViewController(withIdentifier: StoryboardID.loginViewController.rawValue)
        
        self.dismiss(animated: false, completion: nil)
        self.present(loginViewController, animated: true, completion: nil)
    }
    
}

