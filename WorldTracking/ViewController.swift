//
//  ViewController.swift
//  WorldTracking
//
//  Created by Lyle Christianne Jover on 1/26/18.
//  Copyright © 2018 OnionApps Inc. All rights reserved.
//

import UIKit
import ARKit
class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    
    var configuration = ARWorldTrackingConfiguration()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        self.sceneView.session.run(configuration)
        self.sceneView.autoenablesDefaultLighting = true
        
    }

    @IBAction func addBtnPressed(_ sender: Any) {
        let node = SCNNode()
       // node.geometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.03)
       // node.geometry = SCNCapsule(capRadius: 0.1, height: 0.3)
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 0.2))
        path.addLine(to: CGPoint(x: 0.2, y: 0.3))
        path.addLine(to: CGPoint(x: 0.4, y: 0.2))
        path.addLine(to: CGPoint(x: 0.4, y: 0))
        
        let shape = SCNShape(path: path, extrusionDepth: 0.2)
        node.geometry = shape
        node.geometry?.firstMaterial?.specular.contents = UIColor.white
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.green
        
        //node.position = SCNVector3(0,0,-0.3)
//        let x = randomNumber(firstNum: -0.3, secondNum: 0.3)
//        let y = randomNumber(firstNum: -0.3, secondNum: 0.3)
//        let z = randomNumber(firstNum: -0.3, secondNum: 0.3)
        node.position = SCNVector3(0, 0, 0.7)
        self.sceneView.scene.rootNode.addChildNode(node)
    }
    
    @IBAction func resetBtnPressed(_ sender: Any) {
        restartSession()
    }
    
    func restartSession(){
        self.sceneView.session.pause()
        self.sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
            node.removeFromParentNode()
        }
        self.sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    func randomNumber(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
}

