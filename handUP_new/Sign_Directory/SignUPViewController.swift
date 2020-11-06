//
//  SignUPViewController.swift
//  handUP_new
//
//  Created by 김재석 on 2020/09/01.
//  Copyright © 2020 김재석. All rights reserved.
//

/*
 check
 1.textField return, 키보드 올리기
 2.tapGesture 추가
 3.iooutlet, action 메소드 추가
 4.navigationBarItem actino추가
 */


import UIKit
import Alamofire

class SignUPViewController: UIViewController {
    
    @IBAction func touchUpToBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func touchUpToSignIn(_ sender: Any) {
        performSegue(withIdentifier: "segueForLoginViewController", sender: nil)
   }

    @IBAction func touchUpSignUp(_ sender: Any) {
    }
    
    @IBAction func touchUpApple(_ sender: Any) {
    }
    
    @IBAction func touchUpGoogle(_ sender: Any) {
    }
    
    
    @IBOutlet weak var textFieldToName: UITextField!
    
    @IBOutlet weak var textFieldToEmail: UITextField!
    
    @IBOutlet weak var textFtextFieldToPassWord: UITextField!
    
    
    @IBAction func touchUpViewController(_ sender: Any) {
        textFieldToEmail.resignFirstResponder()
        textFieldToName.resignFirstResponder()
        textFtextFieldToPassWord.resignFirstResponder()
    }
    
    //signUpButton Height = 50
    @IBOutlet weak var centerYConstrainsToSignButton: NSLayoutConstraint!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
    }
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueForMainView" {
            let destination = segue.destination
            destination.modalPresentationStyle = .fullScreen
        }
        else if segue.identifier == "segueForLoginViewController" {
            let destination = segue.destination
            destination.modalPresentationStyle = .fullScreen
        }
     }
}

extension SignUPViewController : UITextFieldDelegate{
    
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
            //check
            centerYConstrainsToSignButton.constant = -(keyboardHeght - keyboardHeght/2)
        }
        else{
            centerYConstrainsToSignButton.constant = 50        }
    }
}
