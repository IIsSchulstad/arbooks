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
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var sceneView: ARSCNView!
    
    var testBook: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = testBook?.cover
        self.navigationItem.title = testBook?.title
        sceneView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let config = ARImageTrackingConfiguration()
        if let trackedImages = ARReferenceImage.referenceImages(inGroupNamed: testBook!.resource, bundle: Bundle.main) {
            config.trackingImages = trackedImages
            config.maximumNumberOfTrackedImages = 1
        } else {
            print("Can't track image!")
        }
        
        sceneView.session.run(config)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        guard let imageAnchor = anchor as? ARImageAnchor, let videoURL = Bundle.main.path(forResource: (imageAnchor.name ?? "No name found"), ofType: "mp4") else {
            return
        }
        
        let videoToPlay = AVPlayerItem(url: URL(fileURLWithPath: videoURL));
        let player = AVPlayer(playerItem: videoToPlay)
        let videoNode = SKVideoNode(avPlayer: player)
        player.play()
        
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: nil) { (notification) in
            player.seek(to: CMTime.zero)
            player.play()
        }
        
        let videoScene = SKScene(size: CGSize(width: 480, height: 360))
        
        videoNode.position = CGPoint(x: videoScene.size.width / 2, y: videoScene.size.height / 2)
        videoNode.yScale = -1.0
        videoScene.addChild(videoNode)
        
        let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
        plane.firstMaterial?.diffuse.contents = videoScene
        let planeNode = SCNNode(geometry: plane)
        planeNode.eulerAngles.x = -Float.pi / 2
        node.addChildNode(planeNode)
    }
}

