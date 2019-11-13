//
//  ViewController.swift
//  arbooks
//
//  Created by Rasmus Stamm on 01/11/2019.
//  Copyright © 2019 Rasmus Stamm. All rights reserved.
//

import UIKit;
import SceneKit;
import ARKit;

class ViewController: UIViewController, ARSCNViewDelegate {
   
    @IBOutlet var sceneView: ARSCNView!
    private var config = ARWorldTrackingConfiguration();
    private var bookList: BookList!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        config.planeDetection = .horizontal;
        config.detectionImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil);
        
        sceneView.scene = SCNScene();
        sceneView.delegate = self;
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints];
        sceneView.session.run(config);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        bookList = BookList();
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if let imageAnchor = anchor as? ARImageAnchor {
            print("Found image");
            handleBookDetected(node: node, imageAnchor: imageAnchor);
        }
    }
    
    private func handleBookDetected(node: SCNNode, imageAnchor: ARImageAnchor) {
        let reference = imageAnchor.referenceImage;

           if let ID = reference.name, let book = bookList.books[ID] {
               DispatchQueue.main.async {
                let alert = UIAlertController(title: book.title, message: "Author is \(book.author).\nPublished in \(book.yearPublished).", preferredStyle: .alert);
                if let url = URL(string: book.videoURL) {
                UIApplication.shared.openURL(url);
                }
                
                alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil));
                self.present(alert, animated: true, completion: nil);
               }
           }
       }
    


}

