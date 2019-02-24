//
//  RoutineDetailsViewController.swift
//  Habit Forming
//
//  Created by Joaquin Jacinto on 24/02/2019.
//  Copyright © 2019 Team Generics. All rights reserved.
//

import UIKit

class RoutineDetailsViewController: UIViewController {
    
    @IBOutlet weak var routineImageView: UIImageView!
    @IBOutlet weak var routineTitle: UILabel!
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var duration: UILabel!
    
    let db: DBManager = DBManager.db
    var index: Int = 0
    var rt: Routine = Routine()
    
    let color1 = UIColor.init(red: 79.0/255.0, green: 90.0/255.0, blue: 118.0/255.0, alpha: 1.0)
    let color2 = UIColor.init(red: 242.0/255.0, green: 201.0/255.0, blue: 76.0/255.0, alpha: 1.0)
    let color3 = UIColor.init(red: 33.0/255.0, green: 150.0/255.0, blue: 83.0/255.0, alpha: 1.0)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        rt = db.getRoutines()[index]
        
        switch(rt.color){
        case 1:
            routineImageView.backgroundColor = color1
        case 2:
            routineImageView.backgroundColor = color2
        case 3:
            routineImageView.backgroundColor = color3
        default:
            routineImageView.backgroundColor = UIColor.black
        }
        
        routineTitle.text = rt.name
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        startDate.text = "Started on " + dateFormatter.string(from: (rt.started)!)
        
        duration.text = String(rt.duration) + " minutes, " + String(rt.frequency) + " times a day"
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "startTimer"){
            let vc = segue.destination as! FocusViewController
            vc.rt = rt
        }
    }
    
    @IBAction func unwindToMainMenu(sender: UIStoryboardSegue)
    {
        print(sender)
        let fn:Finished = Finished()
        fn.done = Date()
        fn.routine = rt
        fn.journal = "Great habit forming today!"
        fn.id = db.finishedId()
        db.insert(object: fn)
    }
    
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
