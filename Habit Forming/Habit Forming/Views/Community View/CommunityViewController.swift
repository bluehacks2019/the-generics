//
//  CommunityViewController.swift
//  Habit Forming
//
//  Created by Joaquin Jacinto on 23/02/2019.
//  Copyright © 2019 Team Generics. All rights reserved.
//

import UIKit

class CommunityViewController: UIViewController {

    @IBOutlet weak var communityView: UITableView!
    @IBOutlet weak var searchBar: UITextField!
    
    var selectedIndex: Int = 0
    
    let communities: [Community] = [Community(name: "MLM buy and sell",members: 23232, description: "Supporting local businesses!"), Community(name: "Anti-vax PH", members: 1345345, description: "Protecting the future generations!"), Community(name: "Flat Earth Society",members: 34513, description: "Spreading the truth")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        communityView.delegate = self
        communityView.dataSource = self
        searchBar.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        communityView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showCommunityDetails"){
            let vc = segue.destination as! CommunityDetailsView
            vc.community = communities[selectedIndex]
        }
    }
    
    @IBAction func refreshAction(_ sender: Any) {
        communityView.reloadData()
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

class Community{
    init(name:String, members:Int, description:String){
        self.name = name
        self.members = members
        self.description = description
    }
    var name = ""
    var members = 0
    var description = ""
}

extension CommunityViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        self.performSegue(withIdentifier: "showCommunityDetails", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension CommunityViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cellIdentifier = "communityViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CommunityTableViewCell else {
            fatalError("The dequeued cell is not an instance of SubTaskViewCell.")
        }
        
        cell.communityName.text = communities[indexPath.row].name
        cell.communityMembers.text = String(communities[indexPath.row].members) + " members"
        
        return cell
    }
}

extension CommunityViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
