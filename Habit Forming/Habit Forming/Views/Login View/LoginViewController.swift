//
//  LoginViewController.swift
//  Habit Forming
//
//  Created by Joaquin Jacinto on 23/02/2019.
//  Copyright © 2019 Team Generics. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var constraintContentHeight: NSLayoutConstraint!
    
    var activeTextField: UITextField?
    var lastOffset: CGPoint?
    var keyboardHeight: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        self.contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(returnTextView(gesture:))))
        
    }
    
    @objc func returnTextView(gesture: UIGestureRecognizer) {
        guard activeTextField != nil else {
            return
        }
        
        activeTextField?.resignFirstResponder()
        activeTextField = nil
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        if
            
            usernameTextField.text == passwordTextField.text
//            (usernameTextField.text == "BlueHacks2019" && passwordTextField.text == "compsat")
                
//            && usernameTextField.text != "" && usernameTextField.text != ""
        {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let tabBarController = storyboard.instantiateViewController(withIdentifier: StoryboardID.tabBarController.rawValue) as! UITabBarController
            
            usernameTextField.resignFirstResponder()
            passwordTextField.resignFirstResponder()
            
            self.dismiss(animated: false, completion: nil)
            self.present(tabBarController, animated: true, completion: nil)
        } else {
            usernameTextField.text = ""
            passwordTextField.text = ""
            
            let alertController = UIAlertController(title: "Error", message: "Incorrect Account ID/Password", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "OK", style: .default)
            
            alertController.addAction(okButton)
            
            self.present(alertController, animated: true, completion: nil)
            
            usernameTextField.resignFirstResponder()
            passwordTextField.resignFirstResponder()
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let landingViewController = storyboard.instantiateViewController(withIdentifier: StoryboardID.landingViewController.rawValue)
        
        self.dismiss(animated: false, completion: nil)
        self.present(landingViewController, animated: true, completion: nil)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        activeTextField = textField
        
        lastOffset = self.scrollView.contentOffset
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        activeTextField?.resignFirstResponder()
        
        activeTextField = nil
        
        return true
    }
    
    @objc private func doneButtonPressed() {
        usernameTextField.resignFirstResponder()
    }
}

extension LoginViewController {
    @objc func keyboardWillShow(notification: NSNotification) {
        if keyboardHeight != nil {
            return
        }
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            keyboardHeight = keyboardSize.height
            
            guard let keyboardHeight = keyboardHeight else {
                return
            }
            
            UIView.animate(withDuration: 0.3, animations: {
                self.constraintContentHeight.constant += keyboardHeight
            })
            
            if let activeTextFieldOriginY = activeTextField?.frame.origin.y, let activeTextFieldSizeHeight = activeTextField?.frame.size.height {
                let distanceToBottom = self.scrollView.frame.size.height - activeTextFieldOriginY - activeTextFieldSizeHeight
                
                let collapseSpace = keyboardHeight - distanceToBottom
                
                if collapseSpace < 0 {
                    return
                }
                
                UIView.animate(withDuration: 0.3, animations: {
                    if let lastOffset = self.lastOffset {
                        self.scrollView.contentOffset = CGPoint(x: lastOffset.x, y: collapseSpace + 10)
                    }
                })
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardHeight = self.keyboardHeight, let lastOffset = self.lastOffset {
            UIView.animate(withDuration: 0.3) {
                self.constraintContentHeight.constant -= keyboardHeight
                
                self.scrollView.contentOffset = lastOffset
            }
        }
        
        keyboardHeight = nil
        
    }
}
