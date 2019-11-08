//
//  ViewController.swift
//  arbooks
//
//  Created by Rasmus Stamm on 01/11/2019.
//  Copyright © 2019 Rasmus Stamm. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {
   
    @IBOutlet weak var sceneView: ARSCNView!
    let config = ARWorldTrackingConfiguration()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        sceneView.session.run(config)
    }


}

