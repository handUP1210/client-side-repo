//
//  LogInViewController.swift
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


class LogInViewController: UIViewController {
    
    @IBOutlet weak var textFieldToEmail: UITextField!
    
    @IBOutlet weak var textFieldToPassWord: UITextField!
    
    @IBAction func touchUpLoginButton(_ sender: Any) {
    }
    
    @IBAction func touchUpToViewController(_ sender: Any) {
        textFieldToEmail.resignFirstResponder()
        textFieldToPassWord.resignFirstResponder()
        
    }
    
    
    @IBAction func touchUpLeftBarButton(_ sender: Any) {
        performSegue(withIdentifier: "unwindForInitViewController", sender: nil)
    }
    
    @IBAction func touchUpPssWordForgotButton(_ sender: Any) {
    }
    
    @IBAction func touchUpApple(_ sender: Any) {
    }
    
    @IBAction func touchUpGoogle(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}







class LogInNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationBar.isTranslucent = false
        self.navigationBar.barTintColor = UIColor(hex: "#FAFBFD")
        self.navigationBar.shadowImage = UIImage()
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
