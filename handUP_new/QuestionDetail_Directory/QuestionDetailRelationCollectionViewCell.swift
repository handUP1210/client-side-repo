//
//  QuestionDetailRelationCollectionViewCell.swift
//  handUP_new
//
//  Created by 김재석 on 2020/09/09.
//  Copyright © 2020 김재석. All rights reserved.
//

import UIKit

class QuestionDetailRelationCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var labelToRelationKeyword: UILabel!
    
}

extension QuestionDetailRelationCollectionViewCell:UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuestionDetailRalationQuestionCollectionViewCell", for: indexPath) as? QuestionDetailRalationQuestionCollectionViewCell else{
            return UICollectionViewCell()
        }
        
        return cell
    }
    
    
}

extension QuestionDetailRelationCollectionViewCell: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width = collectionView.bounds.width - 10
        var height = CGFloat(integerLiteral: 140)
        return CGSize(width: width, height: height)
    }
}


//--------------------------childCell--------------------------

class QuestionDetailRalationQuestionCollectionViewCell
: UICollectionViewCell{
    
    @IBOutlet weak var labelToHeadLine: UILabel!
    
    @IBOutlet weak var labelToDate: UILabel!
    
    @IBOutlet weak var labelToNumOfAnswer: UILabel!
    
    @IBOutlet weak var labelToContents: UILabel!
}
