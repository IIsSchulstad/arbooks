//
//  SettingTableViewController.swift
//  arbooks
//
//  Created by Rasmus Stamm on 27/11/2019.
//  Copyright © 2019 Rasmus Stamm. All rights reserved.
//

import UIKit

class SettingTableViewController: UITableViewController {
    @IBOutlet var settingsTable: UITableView!
    var howToUse: Info?
    var faq: Info?
    var terms: Info?
    var selectedInfo: Info?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createInfo()
        createDoneButton()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            selectedInfo = howToUse
        case 1:
            selectedInfo = faq
        case 2:
            selectedInfo = terms
            
        default:
            selectedInfo = nil
        }
        
        self.performSegue(withIdentifier: "InfoSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "InfoSegue"){
            let InfoVC = segue.destination as! InfoViewController
            InfoVC.info = selectedInfo
        }
    }
    
    func createDoneButton(){
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneClicked))
        
        self.navigationItem.rightBarButtonItem = doneButton
    }
    
    @objc func doneClicked(){
        dismiss(animated: true, completion: nil)
    }
    
    private func createInfo() {
        var textArray = [String]()
        var imageArray = [UIImage?]()
        
        textArray.append("Here you will find the information, \non how to use the app.")
        imageArray.append(UIImage(named: "howToUse"))
        howToUse = Info(title: "How to use", textArray: textArray, imageArray: imageArray)
        
        textArray.removeAll()
        imageArray.removeAll()
        
        textArray.append("Q1: Is this where you find the FAQ? \nA1: Indeed it is!")
        textArray.append("Q2: Did this app turn out like we hoped? \nA2: It's allright...")
        faq = Info(title: "FAQ", textArray: textArray, imageArray: imageArray)
        
        textArray.removeAll()
        imageArray.removeAll()
        
        textArray.append("If you clicked yes, you now belong to us..")
        
        terms = Info(title: "Terms and conditions", textArray: textArray, imageArray: imageArray)
        
    }

}
