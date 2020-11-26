//
//  UserInfo.swift
//  handUP_new
//
//  Created by 김재석 on 2020/09/25.
//  Copyright © 2020 김재석. All rights reserved.
//

import Foundation
import UIKit

var recentSearchResults = ["ios", "개발자", "컴퓨터", "디자인", "협업 툴", "코딩테스트", "스타트업"]

let hotKeyWords = ["스포츠", "프로그래밍", "코로나", "컴퓨터", "음식"]

let mainAnswerTabBarCellNames = ["전체", "관심분야", "관심지역", "관심키워드"]

let profileTopTabBarCellNames = ["기본정보", "계급", "활동분야", "관심키워드"]

let settingContents = ["프로필 설정", "나의 크레딧", "나의 Q&A", "설정", "로그아웃"]

let profileBasicTableViewSetTitles = ["이름", "성별", "계급", "거주지역", "익명활동"]

let myqaTopTabBarCellNames = ["궁금한 질문", "나의 질문", "나의 답변", "1대1 질문"]



let settingContentsDic = ["프로필 설정":UIImage(named: "user"),
                         "나의 크레딧":UIImage(named: "credit"),
                         "나의 Q&A":UIImage(named: "q&a"),
                         "설정": UIImage(named: "setting"),
                        "로그아웃":UIImage(named: "logOut")]


enum userDefaultsKeys : String {
    case profileImage
    case userInfo
    case location
}

struct userInfo: Codable{
    var uid : String?
    var email : String?
    var name :  String?
    var gender : String?
    var classes : String?
    var location: String?
    var Anonymity : Bool?
}

struct location: Codable{
    var lat : Double!
    var lng : Double!
}


struct completeTitle {
    init(head: String, contents: String, topButtom: String, buttomButton: String){
        headLineTitle = head
        contentsTitle = contents
        topButtonTitle = topButtom
        bottomButtonTitle = buttomButton
    }
    var headLineTitle : String?
    var contentsTitle : String?
    var topButtonTitle : String?
    var bottomButtonTitle : String?
}


struct postRead:Codable{
    var id : Int
    var title : String
    var author : String
    var modifiedDate : String
}

struct postWritten:Codable {
//    init(Author : String, Content : String, Title: String){
//        author = Author
//        content = Content
//        title = Title
//    }
    
    var author : String
    var content : String
    var title : String

//    var postJson = {
//        let encoder = JSONEncoder()
//        return encoder.encode(Self)
//    }
    
}
