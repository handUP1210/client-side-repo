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
 5.signUP 예외처리
 -isValid o
 -회원가입 메소드 따로 만들기 o
 -segue를 회원가입인 되면 실행되도록 로직 구성
 */


import UIKit
import Alamofire
import Firebase
import FirebaseCore
import FirebaseFirestore

class SignUPViewController: UIViewController {
    
    var db : Firestore!
    
    @IBAction func touchUpToBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func touchUpToSignIn(_ sender: Any) {
        performSegue(withIdentifier: "segueForLoginViewController", sender: nil)
   }

    @IBAction func touchUpSignUp(_ sender: Any) {
        //ToDo: 이메일 활용한 회원가입
        signUpToUser(name: textFieldToName.text, email: textFieldToEmail.text, password: textFtextFieldToPassWord.text)
    
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
            centerYConstrainsToSignButton.constant = 50
        }
    }
}

extension SignUPViewController{
    
    func isValid(email:String?, password:String?) -> Bool{
        if email != "" && password != ""{
            return true
        }
        else{
            return false
        }
    }
    
    func signUpToUser(name: String?, email: String?, password: String?){
        //회원가입 로직 작성
        let isTextFieldValid = isValid(email: email, password: password)
        
        if isTextFieldValid{
            Auth.auth().createUser(withEmail: email! , password: password!) { authResult, error in
                // 회원가입하고 가입한 user 정보로 userDefalults저장하기
                DispatchQueue.global().async {
                    self.setUserInfo(email: email, name: name, gender: nil, classes: nil, location: nil, anonymity: false)
                }
                self.performSegue(withIdentifier: "segueForMainView", sender: nil)
                print(" signIn Complete & value Checking ----> \(authResult)")
                
            }
        }
        else{
            print(" value Checking ----> \(isTextFieldValid)")

            let alert = UIAlertController(title: "확인", message: "아이디 및 비밀번호 입력란을 확인해주세요 :)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
