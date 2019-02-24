//
//  CommunityDetailsView.swift
//  Habit Forming
//
//  Created by Gink on 24/02/2019.
//  Copyright © 2019 Team Generics. All rights reserved.
//

import UIKit

class CommunityDetailsView: UIViewController {

    var community:Community?
    
    @IBOutlet weak var communityName: UILabel!
    @IBOutlet weak var communityMembers: UILabel!
    @IBOutlet weak var communityDescription: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let vaxTitles: [String] = ["Vaccines and our children", "Rising incidence of autism", "Kid dies to dengvaxia vaccine", "Essential oils and you"]
    let vaxPreviews: [String] = ["Your children deserve better....", "Autism up this year by almost...", "Kid in philippines in...", "These are natural alternatives to...."]
    
    let flatTitles: [String] = ["Greatest proof of flatness", "The greatest NASA conspiracy", "Earth is round","Latin is flat"]
    let flatPreviews: [String] = ["If the earth is round, why does it look...", "NASA faked the moon landing...","....NOT", "lorem ipsum..."]
    
    let mlmTitles: [String] = ["Support local businesses", "Selling: doTerra", "Selling: herbalife", "Do you wanna be rich?"]
    let mlmPreviews: [String] = ["don't buy from big stores", "$69...", "$21", "pM ME FOR INFO HUN"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        communityName.text = community?.name
        communityMembers.text = String(community?.members ?? 0) + " members"
        communityDescription.text = community?.description

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}

extension CommunityDetailsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension CommunityDetailsView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cellIdentifier = "communityDetailCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CommunityDetailViewCell else {
            fatalError("The dequeued cell is not an instance of SubTaskViewCell.")
        }
        
        switch(community?.name){
        case "MLM buy and sell":
            cell.threadTitle.text = mlmTitles[indexPath.row]
            cell.threadPreview.text = mlmPreviews[indexPath.row]
        case "Anti-vax PH":
            cell.threadTitle.text = vaxTitles[indexPath.row]
            cell.threadPreview.text = vaxPreviews[indexPath.row]
        case "Flat Earth Society":
            cell.threadTitle.text = flatTitles[indexPath.row]
            cell.threadPreview.text = flatPreviews[indexPath.row]
        default:
            print("spelling error")
        }
        
        
        return cell
    }
    //vaccines and your children
    //rising occurence of autism
    //kid dies after dengvaxia
}
