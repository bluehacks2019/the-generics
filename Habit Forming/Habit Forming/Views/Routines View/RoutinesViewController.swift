//
//  RoutinesViewController.swift
//  Habit Forming
//
//  Created by Joaquin Jacinto on 23/02/2019.
//  Copyright © 2019 Team Generics. All rights reserved.
//

import UIKit

class RoutinesViewController: UIViewController {

    let db: DBManager = DBManager.db
    @IBOutlet weak var routineView: UIView!
    @IBOutlet weak var routineTableView: UITableView!
    
    let color1 = UIColor.init(red: 79.0/255.0, green: 90.0/255.0, blue: 118.0/255.0, alpha: 1.0)
    let color2 = UIColor.init(red: 242.0/255.0, green: 201.0/255.0, blue: 76.0/255.0, alpha: 1.0)
    let color3 = UIColor.init(red: 33.0/255.0, green: 150.0/255.0, blue: 83.0/255.0, alpha: 1.0)
    
    var routines = [Routine]()
    var selectedCell = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        routineTableView.delegate = self
        routineTableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        routineTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showDetails"){
            let vc = segue.destination as! RoutineDetailsViewController
            vc.index = selectedCell
        }
    }
    
    @IBAction func resetRoutines(_ sender: Any) {
        db.clearAll()
        routineTableView.reloadData()
    }
}

extension RoutinesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row > -1) {
            
            selectedCell = indexPath.row
            self.performSegue(withIdentifier: "showDetails", sender: self)
            
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    /*func prepare(_ tableView: UITableView, for segue: UIStoryboardSegue, sender: Any?) {
        if let segueIdentifier = segue.identifier {
            switch segueIdentifier {
            case "routineDetails":
                guard let routineDetailsViewController = segue.destination as? RoutineDetailsViewController else {
                    fatalError("Unexpected destination \(segue.destination)")
                }
                
                guard let selectedTaskCell = sender as? RoutineTableViewCell else {
                    fatalError("Unexpected sender: \(String(describing: sender))")
                }
                
                guard let indexPath = tableView.indexPath(for: selectedTaskCell) else {
                    fatalError("The selected cell is not being displayed by the table")
                }
                
                
            default:
                fatalError("Unexpected Segue Identifier: \(String(describing: segue.identifier))")
            }
        }
    }*/
}

extension RoutinesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return db.countRoutines()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cellIdentifier = "routineViewCell"
        let rt = db.getRoutines()[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RoutineTableViewCell else {
            fatalError("The dequeued cell is not an instance of SubTaskViewCell.")
        }
        
        cell.title.text = rt.name
        cell.duration.text = String(rt.duration) + " minutes, " + String(rt.frequency) + " times a day"
        cell.info.text = "6 ppl in yo area like this"
        
        switch(rt.color){
        case 1:
            cell.routineImageView.backgroundColor = color1
        case 2:
            cell.routineImageView.backgroundColor = color2
        case 3:
            cell.routineImageView.backgroundColor = color3
        default:
            cell.routineImageView.backgroundColor = UIColor.black
        }
        
        return cell
    }
}
