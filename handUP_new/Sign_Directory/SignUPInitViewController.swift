//
//  SignUPInitViewController.swift
//  handUP_new
//
//  Created by 김재석 on 2020/09/01.
//  Copyright © 2020 김재석. All rights reserved.
//

/*
 check
 1.  ActionToBack o
 2.  shadowEffect x
 
 */

import UIKit
import Alamofire


class SignUPInitViewController: UIViewController {
    
    @IBAction func touchUpSignApple(_ sender: Any) {
    }
    
    @IBAction func touchUpSignGoogle(_ sender: Any) {
    }
    
    @IBAction func touchUpSignEmail(_ sender: Any) {
        //segueIdentifier = "segueForSignUP"
    }
    
    @IBAction func touchUpViewController(_ sender: Any) {
        textFieldResignResponder(textField: self.textFieldToEmail)
    }
    
    @IBAction func touchUpToBackButton(_ sender: Any) {
        performSegue(withIdentifier: "unwindForInitViewController", sender: nil)
        
    }
    
    
    @IBOutlet weak var textFieldToEmail: UITextField!
    
    
    @IBOutlet weak var bottomConstraintsToLabel: NSLayoutConstraint!
    
    @IBOutlet weak var bottomConstraintsToEmailButton: NSLayoutConstraint!
    
    @IBOutlet weak var constraintsCenterYToApple: NSLayoutConstraint!
    
    @IBOutlet weak var viewToSignUpApple: UIView!
    
    @IBOutlet weak var viewSignUpGoogle: UIView!
    
    @IBOutlet weak var viewToSignUpEmailTextField: UIView!
    
    @IBAction func buttonToSignUpEmail(_ sender: Any) {
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerForKeyboardNotification()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //        if segue.identifier == "segueForSignUP"{
        //            let destination = segue.destination as? SignUPViewController
        //            guard let text = self.textFieldToEmail.text else {
        //                return print("please write Email")
        //            }
        //            destination?.textFieldToEmail.text = text
        //        }
    }
    
    
}

extension SignUPInitViewController{
    func adjustShadowEffect(view:UIView){
        let shadowView  = UIView()
        let containerView = view
//        shadowView.addSubview(containerView)
        
        
        containerView.layer.shadowColor = UIColor.red.cgColor
        containerView.layer.shadowOpacity = 1
        containerView.layer.shadowOffset = CGSize(width: containerView.frame.width, height: containerView.frame.height)
        containerView.layer.shadowRadius = 10
        containerView.layer.shadowPath = UIBezierPath(rect: containerView.bounds).cgPath
        containerView.layer.shouldRasterize = true
        containerView.layer.rasterizationScale = UIScreen.main.scale
        
        print(" value Checking ----> \(containerView)")
    }
}

extension SignUPInitViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func registerForKeyboardNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(adjustSignUpButtonConstraintsToKeyborad(noti:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustSignUpButtonConstraintsToKeyborad(noti:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func adjustSignUpButtonConstraintsToKeyborad(noti:Notification){
        guard let uerInfo = noti.userInfo else{
            fatalError()
        }
        
        guard let keyboardFrame = (uerInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else{
            fatalError()
        }
        if noti.name == UIResponder.keyboardWillShowNotification{
            var keyboardHeght = (keyboardFrame.height - view.safeAreaInsets.bottom)
            //            let adjustConstant =
            constraintsCenterYToApple.constant = -(keyboardHeght - keyboardHeght/2)
        }
        else{
            constraintsCenterYToApple.constant = 0
        }
    }
}

class SignUPInitNavigationViewController: UINavigationController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.shadowImage = UIImage()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationBar.isTranslucent = false
        self.navigationBar.barTintColor = UIColor(hex: "#FAFBFD")
        self.navigationBar.shadowImage = UIImage()
    }
}
