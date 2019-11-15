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

class ARViewController: UIViewController, ARSCNViewDelegate {
   
    @IBOutlet weak var sceneView: ARSCNView!
    //private var bookList: BookList!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        sceneView.delegate = self;
        //bookList = BookList();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        let config = ARImageTrackingConfiguration();
        if let trackedImages = ARReferenceImage.referenceImages(inGroupNamed: "ARResources", bundle: Bundle.main){
            config.trackingImages = trackedImages;
            config.maximumNumberOfTrackedImages = 1;
        } else {
            print("cant find image");
        }
        
        sceneView.session.run(config);
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        sceneView.session.pause();
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        print("render")
        guard let imageAnchor = anchor as? ARImageAnchor, let videoURL = Bundle.main.path(forResource: "testVideo", ofType: "mp4") else {
            print("no video found")
            return}
        
        let videoToPlay = AVPlayerItem(url: URL(fileURLWithPath: videoURL));
        let player = AVPlayer(playerItem: videoToPlay);
        let videoNode = SKVideoNode(avPlayer: player);
        player.play();
        
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: nil) { (notification) in
            player.seek(to: CMTime.zero)
            player.play()
            print("Looping Video")
        }
        
        let videoScene = SKScene(size: CGSize(width: 480, height: 360));
        
        videoNode.position = CGPoint(x: videoScene.size.width / 2, y: videoScene.size.height / 2);
        videoNode.yScale = -1.0;
        videoScene.addChild(videoNode);
        
        let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height);
        plane.firstMaterial?.diffuse.contents = videoScene;
        let planeNode = SCNNode(geometry: plane);
        planeNode.eulerAngles.x = -Float.pi / 2;
        node.addChildNode(planeNode);
    }
    


}

