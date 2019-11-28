//
//  InfoViewController.swift
//  arbooks
//
//  Created by Rasmus Stamm on 28/11/2019.
//  Copyright © 2019 Rasmus Stamm. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var infoTextView: UITextView!
    @IBOutlet weak var infoTableView: UITableView!
    var info: Info?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = info?.title
        infoTextView.text = info?.textArray[0]
        
        loadTableView()
        // Do any additional setup after loading the view.
    }
    
    func loadTableView() {
        //infoTableView.
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
