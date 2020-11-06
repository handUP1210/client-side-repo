//
//  MainSearchViewController.swift
//  handUP_new
//
//  Created by 김재석 on 2020/09/04.
//  Copyright © 2020 김재석. All rights reserved.
//
/*
 check
 */
import UIKit

class MainSearchViewController: UIViewController {
    
    @IBAction func touchUpBefore(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func touchUpSearch(_ sender: Any) {
        print(self.textFieldToSearch.text)

    }
    
    @IBOutlet weak var textFieldToSearch: UITextField!
    
    
    @IBAction func touchUpViewController(_ sender: Any) {
        self.textFieldToSearch.resignFirstResponder()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.modalPresentationStyle = .fullScreen
    }
    

}

extension MainSearchViewController: UITableViewDataSource, UITableViewDelegate{
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recentSearchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainSearchTableViewCell", for: indexPath) as? MainSearchTableViewCell else{
            return UITableViewCell()
        }
        cell.labelToRecentSearch.text = recentSearchResults[indexPath.row]
        return cell
    }
}

extension MainSearchViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}



class MainSearchTableViewCell:UITableViewCell{
    
    @IBOutlet weak var labelToRecentSearch: UILabel!
    
}
