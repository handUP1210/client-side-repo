//
//  AppDelegate.swift
//  handUP_new
//
//  Created by 김재석 on 2020/09/01.
//  Copyright © 2020 김재석. All rights reserved.
//

import UIKit
import CoreData
import NMapsMap
import CoreLocation
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate{
    
    var window : UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        
        var storyboardName = "Init"
        var viewControllerIdentifier = "InitViewController"
//        var storyboardName = "Init"
//        var viewControllerIdentifier = "InitViewController"
        
        setRootViewcontroller(storyboard: storyboardName, viewController: viewControllerIdentifier)
        DispatchQueue.global().async {
            self.setUserInfo()
            self.setNaverMap(accesskey: "ra3fwyfwi4")//accessKey MetaData
            self.initLocation()
        }
        return true
    }


    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "handUP_new")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

extension AppDelegate{
    func setRootViewcontroller(storyboard: String, viewController: String){
        self.window = UIWindow(frame: UIScreen.main.bounds)
              
        // 스토리보드 인스턴스
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        // 뷰 컨트롤러 인스턴스
        let VC = storyboard.instantiateViewController(withIdentifier: viewController)
              
        // 윈도우의 루트 뷰 컨트롤러 설정
        self.window?.rootViewController = VC

        // 이제 화면에 보여주자.
        self.window?.makeKeyAndVisible()
    }
}

extension AppDelegate{
    func setUserInfo(){ // 수정? 
        DispatchQueue.global().async {
            var user = userInfo(email: "ynwa3690@gmail.com", name: "김재석", gender: "남자", classes: "일반학생", location: "서울 특별시", Anonymity: true)
            var propertyListEncoder = try? PropertyListEncoder().encode(user)
            var userCoreData = UserDefaults.standard
            userCoreData.set(propertyListEncoder, forKey: userDefaultsKeys.userInfo.rawValue)
            userCoreData.synchronize()
        }
    }
    
    func setNaverMap(accesskey : String){
        NMFAuthManager.shared().clientId = accesskey
    }
}

extension AppDelegate: CLLocationManagerDelegate{
    func initLocation(){
        setLocation(completion: nil)
    }
}

