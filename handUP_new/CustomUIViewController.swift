//
//  CustomUIViewController.swift
//  handUP_new
//
//  Created by 김재석 on 2020/09/02.
//  Copyright © 2020 김재석. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseCore
import FirebaseFirestore

extension UIViewController{
    
    func textFieldResignResponder(textField: UITextField){
        textField.resignFirstResponder()
    }
    func setUserInfo(uid : String?, email: String?, name: String?, gender: String?, classfication: Int?, score: Int?, location: String?, anonymity: Bool?){ //
        DispatchQueue.global().async {
            let classes = returnClass(classfication: classfication, score: score)
            
            let user = userInfo(uid: uid, email: email, name: name, gender: gender, score: score, classfication: classfication, classes: classes, location: location, Anonymity: anonymity)
            self.sendUserInfoToFireStore(data: user)
            
            var propertyListEncoder = try? PropertyListEncoder().encode(user)
            var userCoreData = UserDefaults.standard
            userCoreData.set(propertyListEncoder, forKey: userDefaultsKeys.userInfo.rawValue)
            userCoreData.synchronize()
        }
    }
    
    func setUserPostInfo(numOfQuestion:Int?, numOfAnswer:Int?, questions:[String]?, answers : [String]?){
        let userPost = userPostInfo(numOfQuestion: numOfQuestion, numOfAnswer: numOfAnswer, questions: questions, answers: answers)
        self.sendQuestionIDFireStoreForInit(userPostInfo: userPost)
        var propertyListEncoder = try? PropertyListEncoder().encode(userPost)
        var userCoreData = UserDefaults.standard
        userCoreData.set(propertyListEncoder, forKey: userDefaultsKeys.userPostInfo.rawValue)
        userCoreData.synchronize()
    }
    
    func loadUerInfo() -> userInfo {
        // userDefault에 저장된 데이터 뽑아오는 로직 작성
        if UserDefaults.standard.object(forKey: userDefaultsKeys.userInfo.rawValue) != nil{
            let returnUserInfo : userInfo?
            if let data = UserDefaults.standard.value(forKey: userDefaultsKeys.userInfo.rawValue) as? Data{
                let decoderUserInfo = try? PropertyListDecoder().decode(userInfo.self, from: data)
                print(decoderUserInfo)
                return decoderUserInfo!
            }
        }
        return userInfo(uid: "no", email: "no", name: "no", gender: "no", score: 0, classfication: 0, classes: "no", location: "no", Anonymity: false)
    }
    
    func loadUerPostInfo() -> userPostInfo{
        // userDefault에 저장된 데이터 뽑아오는 로직 작성
        if UserDefaults.standard.object(forKey: userDefaultsKeys.userPostInfo.rawValue) != nil{
            let returnUserInfo : userInfo?
            if let data = UserDefaults.standard.value(forKey: userDefaultsKeys.userPostInfo.rawValue) as? Data{
                let decoderUserInfo = try? PropertyListDecoder().decode(userPostInfo.self, from: data)
                print(decoderUserInfo)
                return decoderUserInfo!
            }
        }
        return userPostInfo(numOfQuestion: 0, numOfAnswer: 0, questions: nil, answers: nil)
    }
    
    func receivedUserInfoFromFireStore(){
        // fireStore에서 userInfo 받아오는 로직짜기
        var db = Firestore.firestore()
        var uid = Auth.auth().currentUser?.uid
        // 1. recievedData from FirsStore
        let docRef = db.collection("users").document(uid!)
        
        DispatchQueue.global().async {
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    let data = document.data()
                    defer{
                        let user = userInfo(dictionary: data!)
                        var propertyListEncoder = try? PropertyListEncoder().encode(user)
                        var userCoreData = UserDefaults.standard
                        userCoreData.set(propertyListEncoder, forKey: userDefaultsKeys.userInfo.rawValue)
                        userCoreData.synchronize()
                    }
                    print("Document data: \(data)")
                } else {
                    print("Document does not exist")
                }
            }
        }
    }
    
//    func receivedUserPostInfoFromFireStore(){
//        //수정 x
//        var db = Firestore.firestore()
//        var uid = Auth.auth().currentUser?.uid
//        // 1. recievedData from FirsStore
//        let docRef = db.collection("users").document(uid!)
//        
//        DispatchQueue.global().async {
//            docRef.getDocument { (document, error) in
//                if let document = document, document.exists {
//                    let data = document.data()
//                    defer{
//                        let user = userInfo(dictionary: data!)
//                        var propertyListEncoder = try? PropertyListEncoder().encode(user)
//                        var userCoreData = UserDefaults.standard
//                        userCoreData.set(propertyListEncoder, forKey: userDefaultsKeys.userInfo.rawValue)
//                        userCoreData.synchronize()
//                    }
//                    print("Document data: \(data)")
//                } else {
//                    print("Document does not exist")
//                }
//            }
//        }
//    }
//    
    func sendUserInfoToFireStore(data: userInfo){
        let db = Firestore.firestore()
        let uid = Auth.auth().currentUser?.uid
        
        let data = data.dictionaryRepresent
        
        do {
            try db.collection("users").document(uid!).setData(data)
        } catch let error {
            print("Error writing city to Firestore: \(error)")
        }
    }
    
    func sendQuestionInfoToFireStore(title: String?, contents: String?, keywords: String?){
        //component이용
        let db = Firestore.firestore()
        let uid = Auth.auth().currentUser?.uid
        let email = Auth.auth().currentUser?.email
        let keywordArr = keywords?.components(separatedBy: ",")
        let nowDate = returnStringOfNow()
        let data = questionInfo(writerUid: uid, writerEmail: email, title: title, contents: contents, profileURL: nil, questions: 2, date: nowDate, keyword: keywordArr).dictionaryRepresent
        
        var ref: DocumentReference? = nil
        ref = db.collection("questions").addDocument(data: data){ err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
                self.sendQuestionIDFireStoreForUpdate(questionID: ref!.documentID)
            }
        }
    }
    
    func sendQuestionIDFireStoreForUpdate(questionID: String){
        let db = Firestore.firestore()
        let uid = Auth.auth().currentUser?.uid
        do{
            try db.collection("usersQuestions").document(uid!).updateData([
                "questions": FieldValue.arrayUnion([questionID])
            ])
        }
        catch let error{
            print("Error writing city to Firestore: \(error)")
        }
        
        do{
            try db.collection("usersQuestions").document(uid!).updateData([
                "numOfQuestion": FieldValue.increment(Int64(1))
            ])
        }
        catch let error{
            print("Error writing city to Firestore: \(error)")
        }
    }
    
    
    func sendQuestionIDFireStoreForInit(userPostInfo: userPostInfo){
        let db = Firestore.firestore()
        let uid = Auth.auth().currentUser?.uid
        // read해서 없으면 새로쓰기 있으면 업데이트
        let data = userPostInfo.dictionaryRepresent
        do{
            try db.collection("usersQuestions").document(uid!).setData(data)
        }
        catch let error{
            print("Error writing city to Firestore: \(error)")
        }
    }
}




extension UIViewController{
    func setProfileImage(profileImageView: UIImageView, key: String){
        DispatchQueue.global().async {
            if let profileImg = UserDefaults.standard.object(forKey: key) as? NSData{
                if let castingProfileImage = UIImage(data: profileImg as Data){
                    DispatchQueue.main.async{
                        profileImageView.image = castingProfileImage
                    }
                }
            }
        }
    }
}


extension UIViewController{
    
    func navigtionBarIsHidden(VC: UIViewController, bool: Bool){
        VC.navigationController?.navigationBar.isHidden = true
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
