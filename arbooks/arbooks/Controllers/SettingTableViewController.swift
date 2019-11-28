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
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            print("you pressed a setting!")
            
        case 1:
            
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
            
        default:
            print("you pressed nothing!")
        }
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

    // MARK: - Table view data source

    /*override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }*/

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    private func createInfo() {
        var textArray = [String]()
        var imageArray = [UIImage?]()
        
        textArray.append("Who the fuck even knows at this point omegalul")
        imageArray.append(UIImage(named: "howToUse"))
        howToUse = Info(title: "How to use", textArray: textArray, imageArray: imageArray)
        
        textArray.removeAll()
        imageArray.removeAll()
        
        textArray.append("Q1: Is this app any good? \nA1: Yes")
        textArray.append("Q2: Did this app turn out like we hoped? \nA2: No, not quite...")
        faq = Info(title: "FAQ", textArray: textArray, imageArray: imageArray)
        
        textArray.removeAll()
        imageArray.removeAll()
        
        textArray.append("We own you now")
        
        terms = Info(title: "Terms and conditions", textArray: textArray, imageArray: imageArray)
        
    }

}
