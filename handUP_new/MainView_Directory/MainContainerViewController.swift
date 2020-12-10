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
import Firebase
import FirebaseCore
import FirebaseFirestore


// delegaete
class MainContainerViewController: UIViewController {
    var selectedIndexPath : Int?
    var sendRecentQuestionInfoArr : [QueryDocumentSnapshot]?
    let maxOfRecentQuetionInerCell = 3

    
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    
    
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
    override func viewWillAppear(_ animated: Bool) {

        NotificationCenter.default.addObserver(self, selector: #selector(recentQuestionInfoProcess(notification:)), name: .newValueDidInput, object: nil)
        defer {
            DispatchQueue.global().async {
                self.receivedQuetionInfoFromFireStore(numOfMaxIndex: self.maxOfRecentQuetionInerCell)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueForQuestionDetailViewController"{
            var destination = segue.destination as? QuestionDetailViewController
            destination?.modalPresentationStyle = .fullScreen
            destination?.indexPathOfSelectedQuestionCell = self.selectedIndexPath
            
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

// MainConatinerCell CustomMethod(추천, 최근질문, 핫 키워드 셀)
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
    
    func returnToCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell{
        switch indexPath.row {
        case 0://추천셀
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainContainerRecomendCollectionViewCell", for: indexPath) as? MainContainerRecomendCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
        case 1://최근질문셀
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainContainerQuestionCollectionViewCell", for: indexPath) as? MainContainerQuestionCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.delegate = self
            cell.recentQuestionInfosArrs = self.sendRecentQuestionInfoArr
            
            defer {
                if (self.sendRecentQuestionInfoArr != nil) {
                    cell.inerCollectinView.reloadData()
                }
            }
            print("maincontainercollectionView Cell reload \(indexPath.row)")
            
            return cell
        case 2://핫 키워드 셀
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

extension MainContainerViewController : MainContainerQuestionDelegate{
    
    func selectedCell(indexOf: Int) {
        //1. idexPath 저장
        self.selectedIndexPath = indexOf
        self.performSegue(withIdentifier: "segueForQuestionDetailViewController", sender: nil)
    }
    
}

extension MainContainerViewController{
    @objc func recentQuestionInfoProcess(notification: NSNotification){
        guard let data = notification.userInfo?["data"]  as? [QueryDocumentSnapshot] else{
            return
        }
//        self.recentQuestionInfosArr = data
        print("--recentQuestionInfoProcess observer run : \(data)--")
        self.sendRecentQuestionInfoArr = data
        DispatchQueue.main.async {
            self.mainCollectionView.reloadData()
        }
    }
    
    
    func receivedQuetionInfoFromFireStore(numOfMaxIndex: Int?){
        // fireStore에서 userInfo 받아오는 로직짜기 (아직 적용 x)
        var db = Firestore.firestore()
        var uid = Auth.auth().currentUser?.uid
        let docRef = db.collection("questions").order(by: "date", descending: true)
        var recentQuestionInfosTempArr = [QueryDocumentSnapshot]()
        docRef.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                
            } else {
                // 여기서 받은 fireStore에서 Data를 이용해 notification을 만들고 notificationCenter에 post하기!
                for data in 0...numOfMaxIndex!{
                    recentQuestionInfosTempArr.append((querySnapshot?.documents[data])!)
                }
                NotificationCenter.default.post(name: .newValueDidInput, object: nil, userInfo: ["data":recentQuestionInfosTempArr])
            }
        }
    }
}



