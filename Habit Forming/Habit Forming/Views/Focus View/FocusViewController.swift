//
//  FocusViewController.swift
//  Habit Forming
//
//  Created by Joaquin Jacinto on 23/02/2019.
//  Copyright © 2019 Team Generics. All rights reserved.
//

import UIKit

class FocusViewController: UIViewController {

    @IBOutlet weak var focusTitle: UILabel!
    @IBOutlet weak var countdownTimer: UILabel!
    
    var rt:Routine?
    
    var timer: Timer?
    var hour: Int = 0
    var minute: Int = 0
    var second: Int = 0
        
    override func viewDidLoad() {
        super.viewDidLoad()

        focusTitle.text = rt?.name
        let minutesRemaining = rt?.duration ?? 1 * 60
        
        
        hour = minutesRemaining / 60
        minute = (minutesRemaining % 60)
        second = 0
        
        countdownTimer.text = String.init(format: "%02d:%02d:%02d", hour, minute, second)

        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateCounter), userInfo: nil, repeats: true)
        
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "endTimer"){
            let vc = segue.destination as! FocusDoneController
            vc.rt = rt
        }
    }
    
    @objc func updateCounter() {
        if(minute > 0 || second > 0 || hour > 0) {
            if(second == 0){
                if(minute == 0){
                    hour -= 1
                    minute = 60
                }
                minute -= 1
                second = 60
            }
            second -= 1
        
            countdownTimer.text = String.init(format: "%02d:%02d:%02d", hour, minute, second)
        } else {
            timer?.invalidate()
            self.performSegue(withIdentifier: "endTimer", sender: nil)
        }
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        timer?.invalidate()
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
