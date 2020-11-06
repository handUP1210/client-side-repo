//
//  ProfileBasicViewController.swift
//  handUP_new
//
//  Created by 김재석 on 2020/09/15.
//  Copyright © 2020 김재석. All rights reserved.
//
/*
 check
 1. profileImageSet o
 2. userDefaults o
 3. profileSelect -> Dispatch.global.Async o
 */


import UIKit

class ProfileBasicViewController: UIViewController {
    
    @IBOutlet weak var imageViewToProfile: UIImageView!
    
    @IBOutlet weak var labelToID: UILabel!
    
    @IBOutlet weak var tableViewToUserInfo: UITableView!
    
    
    var picker = UIImagePickerController()
    
    var name  = "testing"
    
    var gender = "testing"
    
    var location = "testing"
    
    var user :userInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        initImageViewSetting()
        setUerInfo()
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

extension ProfileBasicViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileBasicTableViewSetTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 4{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileBasicAnonymousSetTableViewCell", for: indexPath) as? ProfileBasicAnonymousSetTableViewCell else{
                return UITableViewCell()
            }
            cell.labelToSetTitle.text = profileBasicTableViewSetTitles[indexPath.row]
            cell.switchToAnonymousActivity.isOn = (self.user?.Anonymity)! ?? true
            return cell
        }
        else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileBasicSetTableViewCell", for: indexPath) as? ProfileBasicSetTableViewCell else{
                return UITableViewCell()
            }
            cell.labelToSetTitle.text = profileBasicTableViewSetTitles[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // select Cell init
        
        guard var cell = tableView.cellForRow(at: indexPath) as? ProfileBasicSetTableViewCell else{
            fatalError()
        }
        selectOftableviewAction(rowOfIndexPath: indexPath, selectCell: cell)
        
        print(cell.labelToSetData)
    }
    
    func selectOftableviewAction(rowOfIndexPath: IndexPath, selectCell: ProfileBasicSetTableViewCell){
        // select Cell paramiter
        
        switch rowOfIndexPath.row {
        case 0:
            
            initAlerController(title: "이름을 입력해주세요!", alertStyle: .alert, selectCell: selectCell){ cell in
                cell.labelToSetData.text = self.name
            }
        case 1:
            initAlerController(title: "성별을 골라주세요!", alertStyle: .actionSheet,selectCell: selectCell){ cell in
                cell.labelToSetData.text = self.name
            }
        case 2:
            print("test")
        case 3:
            initAlerController(title: "거주지역을 입력해주세요!", alertStyle: .alert,selectCell: selectCell){ cell in
                cell.labelToSetData.text = self.location
            }
        default:
            print("defaults")
        }
        
    }
}

extension ProfileBasicViewController{
    func initAlerController(title: String, alertStyle: UIAlertController.Style , selectCell: ProfileBasicSetTableViewCell, completionHandler:  @escaping (ProfileBasicSetTableViewCell) -> Void){
        
        
        switch alertStyle {
        case .alert:
            var alerController = UIAlertController(title: title, message: nil, preferredStyle: alertStyle)
            
            var alertActionOfCancle = UIAlertAction(title: "취소", style: .destructive, handler: nil)
            var alertActionOfComplete = UIAlertAction(title: "확인", style: .default){_ in
                DispatchQueue.global().async {
                    DispatchQueue.main.async {
                        // data 저장부분 확인
                        self.name = (alerController.textFields?[0].text)!
                        completionHandler(selectCell)
                        print("input Data -> \(alerController.textFields?[0].text)")
                    }
                }
            }
            
            alerController.addTextField { textField in
                textField.placeholder = title
            }
            
            alerController.addAction(alertActionOfComplete)
            alerController.addAction(alertActionOfCancle)
            present(alerController, animated: true, completion: nil)
            
        case .actionSheet:
            var alerController = UIAlertController(title: title, message: nil, preferredStyle: alertStyle)
            
            var alertActionOfCancle = UIAlertAction(title: "남자", style: .destructive){_ in
                
                DispatchQueue.global().async {
                    self.gender = title
                    DispatchQueue.main.async {
                        completionHandler(selectCell)
                        print("select Male")
                    }
                    
                }
            }
            var alertActionOfComplete = UIAlertAction(title: "여자", style: .default){_ in
                DispatchQueue.global().async {
                    self.gender = title
                    DispatchQueue.main.async {
                        completionHandler(selectCell)
                        print("selecte Female")
                    }
                }
            }
            
            alerController.addAction(alertActionOfComplete)
            alerController.addAction(alertActionOfCancle)
            present(alerController, animated: true, completion: nil)
            
        default:
            print("initAlerInit")
        }
        
    }
}


extension ProfileBasicViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate{
    
    func initImageViewSetting(){
        setProfileImage(profileImageView: imageViewToProfile, key: userDefaultsKeys.profileImage.rawValue)
        var tapGesture = UITapGestureRecognizer(target: self, action: #selector(showGallery))
        self.imageViewToProfile.addGestureRecognizer(tapGesture)
        self.imageViewToProfile.isUserInteractionEnabled = true
        picker.delegate = self
        
    }
    
    @objc func showGallery(){
        print("setGesture")
        openLibray()
    }
    
    func openLibray(){
        self.picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    
    func openCamera(){
        self.picker.sourceType = .camera
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        DispatchQueue.global().async {
            var userCoreData = UserDefaults.standard
            if let profileImg = info[.originalImage] as? UIImage{
                let profileImgJpeg = profileImg.jpegData(compressionQuality: 0.1)
                userCoreData.set(profileImgJpeg, forKey: userDefaultsKeys.profileImage.rawValue)
                userCoreData.synchronize()
                
                DispatchQueue.main.async {
                    self.imageViewToProfile.image = profileImg
                }
            }
        }
        dismiss(animated: true, completion: nil)
    }
}

extension ProfileBasicViewController{
    func setUerInfo(){
        // userDefault에 저장된 데이터 뽑아오는 로직 작성
        if UserDefaults.standard.object(forKey: userDefaultsKeys.userInfo.rawValue) != nil{
            if let data = UserDefaults.standard.value(forKey: userDefaultsKeys.userInfo.rawValue) as? Data{
                let decoderUserInfo = try? PropertyListDecoder().decode(userInfo.self, from: data)
                self.user = decoderUserInfo
                print(decoderUserInfo)
            }
        }
    }
}



