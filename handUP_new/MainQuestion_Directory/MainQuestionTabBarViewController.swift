//
//  MainQuestionTabBarViewController.swift
//  handUP_new
//
//  Created by 김재석 on 2020/09/08.
//  Copyright © 2020 김재석. All rights reserved.
//

import UIKit
import Alamofire
/*
 check
 1. action(back o , finish, selectPhoto)
 2. containerView Embeded VC 접근방법 고민! x
 */

class MainQuestionTabBarViewController: UIViewController {

    
    @IBAction func touchUpToBack(_ sender: Any) {
        performSegue(withIdentifier: "unwindForMainViewControllerWithSegue", sender: self)
        
    }
    
    @IBAction func tpuchUpToFinish(_ sender: Any) {
        //Netword Testing logic 
        self.performSegue(withIdentifier: "segueForComplete", sender: nil)
        //        self.performSegue(withIdentifier: "segueForWebViewTesting", sender: nil)
        DispatchQueue.global().async {
            self.networkGetTesting()
            self.networkPostTesting()
            //        webViewTesting()
            
            
        }
    }
    
    @IBAction func touchUpToSelectPhoto(_ sender: Any) {
        openLibraray()
    }
    
    
    
    var pick = UIImagePickerController()
    
    @IBOutlet weak var textFieldToHeadLine: UITextField!
    
    @IBOutlet weak var textViewToContent: UITextView!
    
    @IBOutlet weak var textFieldToTag: UITextField!
    
    @IBOutlet weak var constraintsToTagBottom: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSetting()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueForComplete"{
            
            let destinationData = completeTitle(head: "질문하기 완료!", contents: "질문하기가 완료되었습다 ! 좀 더 자세한 질문을 하고싶다면 아래 1대1 질문하기 기능을 이용해 보세요 :)", topButtom: "1대1 질문하기", buttomButton: "메인화면으로 돌아가기")
            var destination = segue.destination as? CompleteViewController
            destination?.modalPresentationStyle = .fullScreen
            destination?.uiTitles = destinationData
        }
    }
    
}



extension MainQuestionTabBarViewController{
    func registerForKeyboardNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(adjustTextFieldConstraintsToKeyboard(noti:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc private func adjustTextFieldConstraintsToKeyboard(noti: Notification){
        guard let userInfo = noti.userInfo else{
            fatalError()
        }
        guard let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            fatalError()
        }
        
        if noti.name == UIResponder.keyboardWillShowNotification{
            var keyboardHeight = (keyboardFrame.height - view.safeAreaInsets.bottom)
            constraintsToTagBottom.constant = keyboardHeight
        }
        
    }
}

extension MainQuestionTabBarViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func openLibraray(){
        pick.sourceType = .photoLibrary
        present(pick, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        DispatchQueue.global().async {
            if let imageInfo = info[.originalImage] as? UIImage{
                //select Image
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    func initSetting(){
        pick.delegate = self
        registerForKeyboardNotification()
        self.textFieldToHeadLine.becomeFirstResponder()
    }
}


extension MainQuestionTabBarViewController{
    func networkGetTesting(){
        //        let url = "http://ec2-3-34-156-244.ap-northeast-2.compute.amazonaws.com:8080/api/v1"
        let url = "https://decdfc320a45.ngrok.io/api/v1/"
        let decoder = JSONDecoder()
        
        AF.request(url).responseJSON { respond in
            switch respond.result{
            
            case .success(let value):
                do{
                    let data = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                    let parsingResult = try decoder.decode([postRead].self, from: data)
                    print("Success parsingDAta-> \(parsingResult)")
                    print(type(of: parsingResult))
                }catch{
                    print(error)
                }
            case .failure(let error):
                print("fail -> \(error.localizedDescription)")
            }
        }
    }
    
    func networkPostTesting(){
        let url = "https://bc7ef560f5f7.ngrok.io/api/v1/posts"
        let Author = "박지충"
        let Content = "도움좀"
        let Title = "도와줘유 .... :)"
        let encoder = JSONEncoder()
        let written = postWritten(author: Author, content: Content, title: Title)
        
        do{
            let postJson = try encoder.encode(written)
            let jsonObject = try JSONSerialization.jsonObject(with: postJson, options:.mutableContainers)
            
            print("success -> \(type(of: jsonObject))")
            
            print("success -> \(String(data: postJson, encoding: .utf8))")
        }catch{
            print(error.localizedDescription)
        }
        

        do{
//            let postJson = try encoder.encode(written)
            AF.request(url, method: .post, parameters: written, encoder: JSONParameterEncoder.default ).responseJSON {res in
                switch res.result{
                case .success(let value):
                    print("success -> \(value)")
                case .failure(let error):
                    print("fail -> \(error.localizedDescription)")
                }
            }
        }catch{
            print(error.localizedDescription)
        }
    }
    
    
}
