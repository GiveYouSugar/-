//
//  IntroductionController.swift
//  界面嵌入测试
//
//  Created by 郭映杉 on 2022/9/10.
//

import Foundation
import UIKit
import SceneKit


class IntroductionController: UIViewController {
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var mini3DModel: SCNView!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button2: UIButton!
    
    
    @IBOutlet weak var TItle: UITextView!
    
    let scene = SCNScene(named: "art.scnassets/mini.scn")!
    
    override func loadView() {
        super.loadView()
        let hardware = scene.rootNode.childNode(withName: "hardware", recursively: true)
        let camera = scene.rootNode.childNode(withName: "camera", recursively: true)
        camera?.camera?.zFar = 1000
        hardware?.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 1, z: 0, duration: 3)))
        hardware?.opacity = 0.0
        //设置UI显示的属性
        TItle.layer.cornerRadius = 20
        button1.imageView?.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5)
        button2.imageView?.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5)
        button3.imageView?.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5)
        
        //让场景的背景是透明的
        mini3DModel.backgroundColor = UIColor.clear
        
        
        mini3DModel.scene = scene
        mini3DModel.allowsCameraControl = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 5
            hardware?.opacity = 1
            SCNTransaction.commit()
            
            
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
    }
}
