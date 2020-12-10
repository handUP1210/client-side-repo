//
//  QuestionDetailCollectionViewCell.swift
//  handUP_new
//
//  Created by 김재석 on 2020/09/09.
//  Copyright © 2020 김재석. All rights reserved.
//

import UIKit

class QuestionDetailCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var constraintToTopViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var constraintToBottomViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var viewToBottom: UIView!
    
    @IBOutlet weak var viewToTop: UIView!
    
    @IBOutlet weak var imageViewToQuestionUserProfileImg: UIImageView!
    
    @IBOutlet weak var labelToQuestionHeadLine: UILabel!
    
    @IBOutlet weak var labelToDate: UILabel!
    
    
    @IBOutlet weak var labelToQuestionUserID: UILabel!
    
    @IBOutlet weak var labelToNumOfQuestionUserAsking: UILabel!
    
    @IBOutlet weak var labelToQuestionContents: UILabel!
    
    @IBOutlet weak var labelToQuestionKeyWordFirst: UILabel!
    
    @IBOutlet weak var labelToQuestionKeyWordSecond: UILabel!
    
    @IBOutlet weak var labelToQuestionKeyWordThird: UILabel!
    
    @IBOutlet weak var buttonToBottom: UIButton!
    
    var buttonClick:(()->Void)?
    
    @IBAction func touchUpToButtonBottom(_ sender: Any) {
//        let appDelegaete = UIApplication.shared.delegate as? AppDelegate
//        let appDelegaete = UIApplication.shared.keyWindow?.rootViewController
//        let alert = UIAlertController(title: " 확인", message: "현재 1대1 질문하기 기능은 점검 때문에 사용할 수 없습니다ㅠㅠ", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
//        appDelegaete?.present(alert, animated: true, completion: nil)
        buttonClick?()
        
    }
    
    @IBAction func touchUpToRecordQuestion(_ sender: Any) {
    }
    
}
