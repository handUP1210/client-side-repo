//
//  MainContainerQuestionCollectionViewCell.swift
//  handUP_new
//
//  Created by 김재석 on 2020/09/05.
//  Copyright © 2020 김재석. All rights reserved.
//

import UIKit

/*
 check
 1. cell 연결 o
 2. cell custom
 3.
 */
class MainContainerQuestionCollectionViewCell: UICollectionViewCell {

}


extension MainContainerQuestionCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainContainerQuestionContentCollectionViewCell", for: indexPath) as? MainContainerQuestionContentCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var storyboard = UIStoryboard(name: "QuestionDetail", bundle: nil)
        var VC = storyboard.instantiateViewController(withIdentifier: "QuestionDetailViewController")
        // VC 띄우기

    }
    
}

extension MainContainerQuestionCollectionViewCell: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var width = collectionView.bounds.width
        var height = CGFloat(integerLiteral: 120)
        return CGSize(width: width, height: height)
        
    }
}



class MainContainerQuestionContentCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var labelToHeadLine: UILabel!
    
    @IBOutlet weak var labelToContents: UILabel!
    
    @IBOutlet weak var labelToDate: UILabel!
    
    @IBOutlet weak var labelToLocation: UILabel!
    
    

}


