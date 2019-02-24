//
//  AddHabitViewController.swift
//  Habit Forming
//
//  Created by Joaquin Jacinto on 23/02/2019.
//  Copyright © 2019 Team Generics. All rights reserved.
//

import UIKit

class AddRoutineViewController: UIViewController {

    let db: DBManager = DBManager.db
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    var selectedLifetime: Int = 1
    var selectedIconColor: Int = 1
    
    let unselectedColor: UIColor = UIColor.init(red: 220.0/255.0, green: 220.0/255.0, blue: 220.0/255.0, alpha: 1.0)
    let unselectedTextColor: UIColor = UIColor.init(red: 79.0/255.0, green: 90.0/255.0, blue: 118.0/255.0, alpha: 1.0)
    
    let selectedColor: UIColor = UIColor.init(red: 79.0/255.0, green: 90.0/255.0, blue: 118.0/255.0, alpha: 1.0)
    let selectedTextColor: UIColor = UIColor.white
    
    let color1 = UIColor.init(red: 79.0/255.0, green: 90.0/255.0, blue: 118.0/255.0, alpha: 1.0)
    let color2 = UIColor.init(red: 242.0/255.0, green: 201.0/255.0, blue: 76.0/255.0, alpha: 1.0)
    let color3 = UIColor.init(red: 33.0/255.0, green: 150.0/255.0, blue: 83.0/255.0, alpha: 1.0)
    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var frequencyTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var visibilityTextField: UITextField!
    @IBOutlet weak var alarmTextField: UITextField!
    
    var datePicker: UIDatePicker?
    var time: Date?
    var timeText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextField.delegate = self
        frequencyTextField.delegate = self
        durationTextField.delegate = self
        visibilityTextField.delegate = self
        alarmTextField.delegate = self
    }
    
    func resetColor(){
        button1.backgroundColor = unselectedColor
        button1.setTitleColor(unselectedTextColor, for: .normal)
        button2.backgroundColor = unselectedColor
        button2.setTitleColor(unselectedTextColor, for: .normal)
        button3.backgroundColor = unselectedColor
        button3.setTitleColor(unselectedTextColor, for: .normal)
        button4.backgroundColor = unselectedColor
        button4.setTitleColor(unselectedTextColor, for: .normal)
        button5.backgroundColor = unselectedColor
        button5.setTitleColor(unselectedTextColor, for: .normal)
    }
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func color1Button(_ sender: Any) {
        selectedIconColor = 1
        iconView.backgroundColor = color1
    }
    
    @IBAction func color2Button(_ sender: Any) {
        selectedIconColor = 2
        iconView.backgroundColor = color2
    }
    
    @IBAction func color3Button(_ sender: Any) {
        selectedIconColor = 3
        iconView.backgroundColor = color3
    }
    
    @IBAction func button1Action(_ sender: Any) {
        selectedLifetime = 1
        resetColor()
        button1.backgroundColor = selectedColor
        button1.setTitleColor(selectedTextColor, for: .normal)
    }
    
    @IBAction func button2Action(_ sender: Any) {
        selectedLifetime = 2
        resetColor()
        button2.backgroundColor = selectedColor
        button2.setTitleColor(selectedTextColor, for: .normal)
    }
    
    @IBAction func button3Action(_ sender: Any) {
        selectedLifetime = 3
        resetColor()
        button3.backgroundColor = selectedColor
        button3.setTitleColor(selectedTextColor, for: .normal)
    }
    
    @IBAction func button4Action(_ sender: Any) {
        selectedLifetime = 4
        resetColor()
        button4.backgroundColor = selectedColor
        button4.setTitleColor(selectedTextColor, for: .normal)
    }
    
    @IBAction func button5Action(_ sender: Any) {
        selectedLifetime = 5
        resetColor()
        button5.backgroundColor = selectedColor
        button5.setTitleColor(selectedTextColor, for: .normal)
    }
    
    @IBAction func confirmAction(_ sender: Any) {
        print("yes")
        let rt:Routine = Routine()
        
        rt.id = db.routineId()
        rt.color = selectedIconColor
        rt.name = titleTextField.text!
        rt.frequency = Int(frequencyTextField.text!) ?? 1
        
        var split = durationTextField.text?.components(separatedBy: ":")
        rt.duration = (Int(split![0]) ?? 0) * 60 + (Int(split![1]) ?? 0)
        
        rt.visibility = visibilityTextField.text!
        rt.alarm = alarmTextField.text!
        
        switch (selectedLifetime){
        case 1:
            rt.lifetime = 30
        case 2:
            rt.lifetime = 70
        case 3:
            rt.lifetime = 120
        case 4:
            rt.lifetime = 99999
        case 5:
            rt.lifetime = 99999
        default:
            rt.lifetime = 30
        }
        
        rt.started = Date()
        db.insert(object: rt)
        
        print(db.countRoutines())
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension AddRoutineViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let routineTextField = textField as? RoutineTextField
        
        if let routineTextFieldIdentifier = TextFieldID(rawValue: routineTextField?.identifier ?? "") {
            switch routineTextFieldIdentifier {
            case .title:
                break
            case .frequency:
                break
            case .duration:
                datePicker = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
                
                if let datePicker = datePicker {
                    datePicker.backgroundColor = UIColor.white
                    datePicker.datePickerMode = UIDatePicker.Mode.countDownTimer
                    datePicker.minuteInterval = 1
                    textField.inputView = datePicker
                }
                
                let toolBar = UIToolbar()
                toolBar.barStyle = .default
                toolBar.isTranslucent = true
                toolBar.tintColor = UIColor(red: 0, green: 0.478431, blue: 1.0, alpha: 1.0)
                toolBar.sizeToFit()
                
                let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(AddRoutineViewController.doneClick))
                let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
                let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(AddRoutineViewController.cancelClick))
                toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
                toolBar.isUserInteractionEnabled = true
                textField.inputAccessoryView = toolBar
                
                break
            case .visibility:
                routineTextField?.inputView = UIView()
                
                let alertController = UIAlertController(title: "Who can see this?", message: "", preferredStyle: .actionSheet)
                
                let visibilities: [Visibility] = [.publ, .priv, .friends]
                
                for visibility in visibilities {
                    let button = UIAlertAction(title: visibility.rawValue, style: .default) { (action) -> Void in
                        self.visibilityTextField.text = visibility.rawValue
                        routineTextField?.resignFirstResponder()
                    }
                    
                    alertController.addAction(button)
                }
                
                let cancelButton = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                    routineTextField?.resignFirstResponder()
                }
                
                alertController.addAction(cancelButton)
                
                self.present(alertController, animated: true, completion: nil)
                break
            case .alarm:
                routineTextField?.inputView = UIView()
                
                let alertController = UIAlertController(title: "Alarm Setting", message: "", preferredStyle: .actionSheet)
                
                let alarms: [Alarm] = [.silent, .notif, .alert]
                
                for alarm in alarms {
                    let button = UIAlertAction(title: alarm.rawValue, style: .default) { (action) -> Void in
                        self.alarmTextField.text = alarm.rawValue
                        routineTextField?.resignFirstResponder()
                    }
                    
                    alertController.addAction(button)
                }
                
                let cancelButton = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                    routineTextField?.resignFirstResponder()
                }
                
                alertController.addAction(cancelButton)
                
                self.present(alertController, animated: true, completion: nil)
                break
            }
        }
    }
}

extension AddRoutineViewController {
    func setDate(date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        time = date
        timeText = dateFormatter.string(from: date)
        durationTextField.text = timeText
    }
    
    @objc func doneClick() {
        if let datePicker = datePicker {
            setDate(date: datePicker.date)
        }
        
        durationTextField.resignFirstResponder()
    }
    
    @objc func cancelClick() {
        durationTextField.resignFirstResponder()
    }
}
