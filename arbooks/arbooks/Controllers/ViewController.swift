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
import CoreMedia;

class ViewController: UIViewController, ARSCNViewDelegate {
   
    @IBOutlet var sceneView: ARSCNView!
    private var config = ARWorldTrackingConfiguration();
    private var imageConfig: ARImageTrackingConfiguration?
    private var bookList: BookList!
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        bookList = BookList();
        
        let scene = SCNScene();
        sceneView.scene = scene;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        config = ARWorldTrackingConfiguration();
        super.viewWillAppear(animated);
        config.planeDetection = .horizontal;
        setupImageDetection();
        
        sceneView.scene = SCNScene();
        sceneView.delegate = self;
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints];
        sceneView.session.run(config);
    }
    
    override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      sceneView.session.pause()
    }
    
    private func setupImageDetection() {
       imageConfig = ARImageTrackingConfiguration()

       guard let referenceImages = ARReferenceImage.referenceImages(
         inGroupNamed: "AR Resources", bundle: nil) else {
           fatalError("Missing expected asset catalog resources.")
       }
       imageConfig?.trackingImages = referenceImages
     }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if let imageAnchor = anchor as? ARImageAnchor {
            handleImageDetection(node, imageAnchor);
            //if let planeAnchor = anchor as? ARPlaneAnchor {
            //    print("Found plane")
            //}
        }
    }
    
    private func handleBookDetected(node: SCNNode, imageAnchor: ARImageAnchor) {
        let reference = imageAnchor.referenceImage;

           if let ID = reference.name, let book = bookList.books[ID] {
                let alert = UIAlertController(title: book.title, message: "Author is \(book.author).\nPublished in \(book.yearPublished).", preferredStyle: .alert);
                // if let url = URL(string: book.videoURL) {
                // UIApplication.shared.openURL(url);
                // }
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil));
            self.present(alert, animated: true, completion: nil);
           }
       }
    
    func handlePlaneDetected(node: SCNNode, planeAnchor: ARPlaneAnchor) {
           DispatchQueue.main.async {
               let cupScene = SCNScene(named: "ARModel.scnassets/cup.usdz")
               let cupNode = cupScene?.rootNode.childNode(withName: "cup", recursively: true)
               if let model = cupNode {
                   model.position = SCNVector3Make(planeAnchor.center.x, planeAnchor.center.y, planeAnchor.center.z)
                   node.addChildNode(model)
               }
           }
       }

   private func handleImageDetection(_ node: SCNNode, _ imageAnchor: ARImageAnchor) {
    let name = imageAnchor.referenceImage.name!
       print("you found a \(name) image")
         let size = imageAnchor.referenceImage.physicalSize;
         if let videoNode = makeVideo(size: size) {
            node.addChildNode(videoNode)
            node.opacity = 1
         }
     }

  private func makeVideo(size: CGSize) -> SCNNode? {
      guard let videoURL = Bundle.main.url(forResource: "testVideo",
                                           withExtension: "mp4") else {
                                            return nil;
      }
    let avPlayerItem = AVPlayerItem(url: videoURL);
      let avPlayer = AVPlayer(playerItem: avPlayerItem)
      avPlayer.play()
      
      NotificationCenter.default.addObserver(
        forName: .AVPlayerItemDidPlayToEndTime,
        object: nil,
        queue: nil) { notification in
          avPlayer.seek(to: .zero)
          avPlayer.play()
      }
      
      let avMaterial = SCNMaterial()
      avMaterial.diffuse.contents = avPlayer

      let videoPlane = SCNPlane(width: size.width, height: size.height)
      videoPlane.materials = [avMaterial]

      let videoNode = SCNNode(geometry: videoPlane)
      videoNode.eulerAngles.x = -.pi / 2
      return videoNode
  }
}

