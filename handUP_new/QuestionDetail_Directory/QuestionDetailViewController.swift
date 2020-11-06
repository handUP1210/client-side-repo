//
//  QuestionDetailViewController.swift
//  handUP_new
//
//  Created by 김재석 on 2020/09/09.
//  Copyright © 2020 김재석. All rights reserved.
//

import UIKit

class QuestionDetailViewController: UIViewController {
    
    @IBAction func touchUpToMenu(_ sender: Any) {
    }
    
    @IBAction func touchUpToBack(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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

extension QuestionDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("-collectionView numberOfItemsInSection init-")
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("-collectionView cellForItemAt init-")
        var rowOfLastIndexPath = 4
        //cell 1(질문)
        if indexPath.row == 0{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuestionDetailCollectionViewCell", for: indexPath) as? QuestionDetailCollectionViewCell else{
                return UICollectionViewCell()
            }
            var cellTextViewHeight = (cell.labelToQuestionContents.bounds.height)
            var cellTopViewHeight = (cell.viewToTop.bounds.height)
            var cellBottomHeight = (cell.viewToBottom.bounds.height)
            var flexibleSpacing = CGFloat(integerLiteral: 40)
            
            var cellWidth = collectionView.bounds.width
            let cellHegiht = cellBottomHeight + cellTopViewHeight + cellTextViewHeight + flexibleSpacing
            cell.bounds.size.height = cellHegiht
            return cell
        }//cell 2(답변)
        else if indexPath.row == 4{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuestionDetailRelationCollectionViewCell", for: indexPath) as? QuestionDetailRelationCollectionViewCell else{
                return UICollectionViewCell()
            }
            return cell
        }//cell 3(연관질문)
        else{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuestionDetailAnswerCollectionViewCell", for: indexPath) as? QuestionDetailAnswerCollectionViewCell else{
                return UICollectionViewCell()
            }
            return cell
        }
    }
}

extension QuestionDetailViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print("-collectionView flowLayout init-")
        
        var rowOfLastIndexPath = 4
        var cellWidth = collectionView.bounds.width
        var cellHegiht : CGFloat!
        //cell 1(질문)
        if indexPath.row == 0{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuestionDetailCollectionViewCell", for: indexPath) as? QuestionDetailCollectionViewCell else{
                fatalError()
            }
            var cellTextViewHeight = (cell.labelToQuestionContents.bounds.height)
            var cellTopViewHeight = (cell.viewToTop.bounds.height)
            var cellBottomHeight = (cell.viewToBottom.bounds.height)
            var flexibleSpacing = CGFloat(integerLiteral: 60)
            cellHegiht = cellTextViewHeight+cellTopViewHeight+cellBottomHeight+flexibleSpacing
        }//cell 2(답변)
        else if indexPath.row == rowOfLastIndexPath{
            cellHegiht = CGFloat(integerLiteral: 300)
        }//cell 3(연관질문)
        else{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuestionDetailAnswerCollectionViewCell", for: indexPath) as? QuestionDetailAnswerCollectionViewCell else{
                fatalError()
            }
            var cellTextViewHeight = (cell.labelToAnswerContents.bounds.height)
            var cellTopViewHeight = (cell.viewToTop.bounds.height)
            var cellBottomHeight = (cell.buttonToIndepthQuestion.bounds.height)
            var flexibleSpacing = CGFloat(integerLiteral: 60)
            cellHegiht = cellTextViewHeight+cellTopViewHeight+cellBottomHeight+flexibleSpacing
        }
        return CGSize(width: cellWidth, height: cellHegiht)
    }
    
}
