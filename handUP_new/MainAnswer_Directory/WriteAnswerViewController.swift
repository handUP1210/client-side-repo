//
//  WriteAnswerViewController.swift
//  handUP_new
//
//  Created by 김재석 on 2020/09/11.
//  Copyright © 2020 김재석. All rights reserved.
//

/*
 check
 1. back Action (unwind)
 2. photo
 3. finish
 4. questionView(actionSheet)
 4. keyboard(always Visiable) o
 
 */

import UIKit

class WriteAnswerViewController: UIViewController {

    @IBOutlet weak var constraintsToTextViewBottom: NSLayoutConstraint!
    
    @IBOutlet weak var textViewToWriteAnswer: UITextView!
    
    @IBAction func touchUpToBack(_ sender: Any) {
    }
    
    @IBAction func touchUpToPhoto(_ sender: Any) {
    }
    
    @IBAction func touchUpToFinish(_ sender: Any) {
    }
    
    @IBAction func touchUpToViewQuestion(_ sender: Any) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initKeyboardVisiable()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueForComplete"{
            let destinationData = completeTitle(head: "답변하기 완료!", contents: "답변작성을 완료하였습니다! 이제 질문자의 채택을 기다리는 일만 남았어요  :)", topButtom: "다른 질문에 답변하러 가기", buttomButton: "메인화면으로 돌아가기")
            var destination = segue.destination as? CompleteViewController
            destination?.modalPresentationStyle = .fullScreen
            destination?.uiTitles = destinationData
        }
    }
    
}

extension WriteAnswerViewController{
    func initKeyboardVisiable(){
        textViewToWriteAnswer.becomeFirstResponder()
        
        NotificationCenter.default.addObserver(self, selector: #selector(adjustKeyboardConstraints(noti:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
    }
    
    @objc func adjustKeyboardConstraints(noti: Notification){
        guard let userInfo = noti.userInfo else{
            fatalError()
        }
        
        guard let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else{
            fatalError()
        }
        
        if noti.name == UIResponder.keyboardWillShowNotification{
            var keyboardHeight = (keyboardFrame.height - view.safeAreaInsets.bottom)
            constraintsToTextViewBottom.constant = keyboardHeight
        }
    }
}
