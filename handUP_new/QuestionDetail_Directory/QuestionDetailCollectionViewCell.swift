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
    
    @IBAction func touchUpToButtonBottom(_ sender: Any) {
    }
    
    @IBAction func touchUpToRecordQuestion(_ sender: Any) {
    }
    
    
}
