//
//  MainContainerViewController.swift
//  handUP_new
//
//  Created by 김재석 on 2020/09/04.
//  Copyright © 2020 김재석. All rights reserved.
//
/*
 check
 1. cell 3개
 2. cell UI
 3. cell custom class 연결
 
 */

import UIKit

class MainContainerViewController: UIViewController {
    @IBAction func tapGestureToQuestionViewAll(_ sender: Any) {
        print("-QuestionViewAll-")
    }
    
    @IBAction func tapGestureToQuestionRankingViewAll(_ sender: Any) {
        print("-QuestionRankingViewAll-")
    }
    
    @IBAction func tapGestureToIndepthQuestion(_ sender: Any) {
        print("dfdfdf")
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          if segue.identifier == "segueForQuestionDetail"{
              
//              let destinationData = completeTitle(head: "질문하기 완료!", contents: "질문하기가 완료되었습다 ! 좀 더 자세한 질문을 하고싶다면 아래 1대1 질문하기 기능을 이용해 보세요 :)", topButtom: "1대1 질문하기", buttomButton: "메인화면으로 돌아가기")
              var destination = segue.destination
              destination.modalPresentationStyle = .fullScreen
//              destination?.uiTitles = destinationData
          }
      }
}

extension MainContainerViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = returnToCell(collectionView: collectionView, indexPath: indexPath)
        
        return cell
    }
}

extension MainContainerViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = returnToCellSize(collectionView: collectionView, indexPath: indexPath)
        return size
    }
    
            }

extension MainContainerViewController{
    func returnToCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell{
        switch indexPath.row {
            
        case 0:
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainContainerRecomendCollectionViewCell", for: indexPath) as? MainContainerRecomendCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
            
        case 1:
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainContainerQuestionCollectionViewCell", for: indexPath) as? MainContainerQuestionCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
            
        case 2:
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainContainerHotKeywordCollectionViewCell", for: indexPath) as? MainContainerHotKeywordCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
            
        default:
            print("init Cell")
        }
        return UICollectionViewCell()
    }
}

//1. cell height!
extension MainContainerViewController{
    func returnToCellSize(collectionView: UICollectionView, indexPath: IndexPath) -> CGSize{
        
        var width: CGFloat!
        var height: CGFloat!
        var size: CGSize!
        
        switch indexPath.row {
            
        case 0:
            width = collectionView.bounds.width
            height = CGFloat(integerLiteral: 170)
            size = CGSize(width: width, height: height)
            return size
        case 1:
            
            width = collectionView.bounds.width
            height = CGFloat(integerLiteral: 570)
            size = CGSize(width: width, height: height)
            return size
            
        case 2:
            
            width = collectionView.bounds.width
            height = CGFloat(integerLiteral: 300)
            size = CGSize(width: width, height: height)
            return size
            
        default:
            print("init Cell")
        }
        return CGSize(width: width, height: height)
    }
    
    
}

