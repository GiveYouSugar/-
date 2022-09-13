//
//  VIewControllerFunction.swift
//  界面嵌入测试
//
//  Created by 郭映杉 on 2022/9/2.
//

import Foundation
import SceneKit
import UIKit
import SpriteKit

extension ViewController {
    
    //单个粒子效果
    func produceParticle(node: SCNNode){
        //创建粒子节点
        let particle = SCNSphere()
        let particleGemNode = SCNNode(geometry: particle)
        particleGemNode.scale = SCNVector3(0.01, 0.01, 0.01)
        let color = UIColor.white
        particle.materials.first?.diffuse.contents = color
        
        let particleSystem = SCNParticleSystem()
            
        particleSystem.birthRate = 100
        particleSystem.particleSize = 0.25
        particleSystem.particleColor = .yellow
        particleSystem.particleBounce = .greatestFiniteMagnitude
//        particleGemNode.opacity = 0
        //添加粒子效果到粒子节点
        particleGemNode.addParticleSystem(particleSystem)
        ScenekitView.scene?.rootNode.addChildNode(particleGemNode)
        particleGemNode.position = node.position
        moveToCar(node: particleGemNode)
//        print(particleGemNode.position)
       
    }
    
    
   
    
    //待实现克隆效果
    //实现节点移动到小车的动画
    func moveToCar(node: SCNNode){
        var duplicatedNode = SCNNode()
        duplicatedNode = node
        SCNTransaction.begin()
        SCNTransaction.animationDuration = 5
        duplicatedNode.runAction(SCNAction.move(to: carPosition, duration: 2))
        duplicatedNode.opacity = 0.0
        SCNTransaction.commit()
    }
    
    //实现灯光发送到信号发射的动画
    func lightAnimation(){
        //创建9个节点
        let lightNode1 = ScenekitView.scene?.rootNode.childNode(withName: "mainspot", recursively: true)
        let lightNode2 = ScenekitView.scene?.rootNode.childNode(withName: "spot1", recursively: true)
        let lightNode3 = ScenekitView.scene?.rootNode.childNode(withName: "spot2", recursively: true)
        let lightNode4 = ScenekitView.scene?.rootNode.childNode(withName: "spot3", recursively: true)
        let lightNode5 = ScenekitView.scene?.rootNode.childNode(withName: "spot4", recursively: true)
        let lightNode6 = ScenekitView.scene?.rootNode.childNode(withName: "spot5", recursively: true)
        let lightNode7 = ScenekitView.scene?.rootNode.childNode(withName: "spot6", recursively: true)
        let lightNode8 = ScenekitView.scene?.rootNode.childNode(withName: "spot7", recursively: true)
        let lightNode9 = ScenekitView.scene?.rootNode.childNode(withName: "spot8", recursively: true)
        var lightNodes = Set<SCNNode>()
        
         lightNodes.insert(lightNode1!)
         lightNodes.insert(lightNode2!)
         lightNodes.insert(lightNode3!)
         lightNodes.insert(lightNode4!)
         lightNodes.insert(lightNode5!)
         lightNodes.insert(lightNode6!)
         lightNodes.insert(lightNode7!)
         lightNodes.insert(lightNode8!)
         lightNodes.insert(lightNode9!)
        
        for node in lightNodes {
//            print(node.position)
            produceParticle(node: node)
//            print("\n")
                    }
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: { [self] in
            signalAnimation()
        })
        
        
    }
//发送信号到电脑的动画
    func signalAnimation(){
        //获取电脑节点位置
        let computer = ScenekitView.scene?.rootNode.childNode(withName: "computer", recursively: true)
        //创建粒子节点
        let particle = SCNSphere()
        let particleGemNode = SCNNode(geometry: particle)
        particleGemNode.scale = SCNVector3(0.01, 0.01, 0.01)
        let color = UIColor.white
        particle.materials.first?.diffuse.contents = color
        
        let particleSystem = SCNParticleSystem()
            
        particleSystem.birthRate = 100
        particleSystem.particleSize = 0.25
        particleSystem.particleColor = .orange
       
        
       
        particleSystem.particleBounce = .greatestFiniteMagnitude
//        particleGemNode.opacity = 0
        //添加粒子效果到粒子节点
        particleGemNode.addParticleSystem(particleSystem)
        ScenekitView.scene?.rootNode.addChildNode(particleGemNode)
        particleGemNode.position = carPosition
        
       
        SCNTransaction.begin()
        SCNTransaction.animationDuration = 5
        particleGemNode.runAction(SCNAction.wait(duration: 5))
       
        particleGemNode.runAction(SCNAction.move(to: computer!.position, duration: 2))
        particleGemNode.opacity = 0.0
        SCNTransaction.commit()
        
        
    }
    
    
    
    
    
    
    
    //实现开灯效果
    func switchLight(){
        let lightNode1 = ScenekitView.scene?.rootNode.childNode(withName: "mainspot", recursively: true)
        let lightNode2 = ScenekitView.scene?.rootNode.childNode(withName: "spot1", recursively: true)
        let lightNode3 = ScenekitView.scene?.rootNode.childNode(withName: "spot2", recursively: true)
        let lightNode4 = ScenekitView.scene?.rootNode.childNode(withName: "spot3", recursively: true)
        let lightNode5 = ScenekitView.scene?.rootNode.childNode(withName: "spot4", recursively: true)
        let lightNode6 = ScenekitView.scene?.rootNode.childNode(withName: "spot5", recursively: true)
        let lightNode7 = ScenekitView.scene?.rootNode.childNode(withName: "spot6", recursively: true)
        let lightNode8 = ScenekitView.scene?.rootNode.childNode(withName: "spot7", recursively: true)
        let lightNode9 = ScenekitView.scene?.rootNode.childNode(withName: "spot8", recursively: true)
       
        var lightNodes = Set<SCNNode>()
        
         lightNodes.insert(lightNode1!)
         lightNodes.insert(lightNode2!)
         lightNodes.insert(lightNode3!)
         lightNodes.insert(lightNode4!)
         lightNodes.insert(lightNode5!)
         lightNodes.insert(lightNode6!)
         lightNodes.insert(lightNode7!)
         lightNodes.insert(lightNode8!)
         lightNodes.insert(lightNode9!)
        
        //实现关灯效果和开灯效果
        if lightNode2?.light?.intensity == 0{
            SCNTransaction.begin()
            for node in lightNodes {
                node.light?.intensity = 4000
            }

//            textNode.opacity = 1.0
            SCNTransaction.animationDuration = 3
            SCNTransaction.commit()
            
        }
        else{
            SCNTransaction.begin()
            for node in lightNodes {
                node.light?.intensity = 0
            }
//            textNode.opacity = 0.0
            SCNTransaction.animationDuration = 2
            SCNTransaction.commit()
            
        }
        
    }
    
    
    //隐藏和显示第二层按钮UI
    func HideUI (state: Bool){
        //全部按钮消失，返回键出现
        if (state) {
            //消失动画
            UIView.transition(with: LEDButton, duration: 0.1, options: .curveLinear, animations: {self.LEDButton.alpha = 0.0
            }, completion: .none)
            
            UIView.transition(with: FrameButton, duration: 0.1, options: .curveLinear, animations: {self.FrameButton.alpha = 0.0
            }, completion: .none)
            
            UIView.transition(with: showButton, duration: 0.1, options: .curveLinear, animations: {self.showButton.alpha = 0.0
            }, completion: .none)
            
            UIView.transition(with: LocationButton, duration: 0.1, options: .curveLinear, animations: {self.LocationButton.alpha = 0.0
            }, completion: .none)
            
//            BackButton.isHidden = false
            
           
        }else{
//
//            BackButton.isHidden = true
                //出现动画
                UIView.transition(with: LEDButton, duration: 0.1, options: .curveLinear, animations: {self.LEDButton.alpha = 1
                }, completion: .none)
                
                UIView.transition(with: FrameButton, duration: 0.1, options: .curveLinear, animations: {self.FrameButton.alpha = 1
                }, completion: .none)
                
                UIView.transition(with: showButton, duration: 0.1, options: .curveLinear, animations: {self.showButton.alpha = 1
                }, completion: .none)
                
                UIView.transition(with: LocationButton, duration: 0.1, options: .curveLinear, animations: {self.LocationButton.alpha = 1
                }, completion: .none)
            TextTitle2.isHidden = true
            
        }
        
        
    }
    
    
    func totalAnimationOfProgress(){
        
        let scene = ScenekitView.scene
        //灯光射下来
        let cameraNode = ScenekitView.scene?.rootNode.childNode(withName: "carCamera", recursively: true)
        let computerCamera = ScenekitView.scene?.rootNode.childNode(withName: "computerCamera", recursively: true)
        let floorText = ScenekitView.scene!.rootNode.childNode(withName: "floorlabel", recursively: true)
        
        SCNTransaction.begin()
        SCNTransaction.lock()
        SCNTransaction.unlock()
        SCNTransaction.animationDuration = 2
        cameraNode?.eulerAngles = SCNVector3(0.25, 0, 0)
        SCNTransaction.commit()
        
        TextTitle2.frame.size = CGSize(width: 400, height: 400)
        
        changeView(cameraNode: cameraNode!)
        //灯光动画
        lightAnimation()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: { [self] in
            for i in 1...3 {
                lightAnimation()
            }
            UIView.transition(with: TextTitle2, duration: 1, options: .curveLinear, animations: {self.TextTitle2.text = "LED发射的光线，覆盖了定位范围，源源不断发射可见光信号"}, completion: .none)
            TextTitle2.isHidden = false
            textViewDidChange(TextTitle2)
        })
       
        //延迟实现
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: { [self] in
            print("done")
            SCNTransaction.begin()
            SCNTransaction.lock()
            SCNTransaction.unlock()
            SCNTransaction.animationDuration = 2
            cameraNode?.eulerAngles = SCNVector3(-0.31, 0, 0)
            SCNTransaction.commit()
            UIView.transition(with: TextTitle2, duration: 1, options: .curveLinear, animations: {self.TextTitle2.text = "装有PD模块的小车，接收到来自顶部LED的光线信号，并将其传输到电脑"}, completion: .none)
            textViewDidChange(TextTitle2)
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(8), execute: { [self] in
            changeView(cameraNode: computerCamera!)
            let boxNode = SCNNode()
             let plane = SCNPlane(width: 5, height: 3)
            videoNode = SKVideoNode(url: url!)
              boxNode.geometry = plane;
              boxNode.geometry?.firstMaterial?.isDoubleSided = true
            boxNode.position = SCNVector3Make(14, 11.5,2.9);
              scene!.rootNode.addChildNode(boxNode);
            boxNode.eulerAngles = SCNVector3(x: Float((Double.pi))*(10/180), y: Float(Double.pi)/2, z: 0)
             
              videoNode.size = CGSize(width: 1600, height: 900)
              videoNode.position = CGPoint(x: videoNode.size.width/2, y: videoNode.size.height/2)
            videoNode.zRotation = CGFloat(Double.pi)
              let skScene = SKScene()
              skScene.addChild(videoNode)
              skScene.size = videoNode.size
            plane.firstMaterial?.diffuse.contents = skScene
            videoNode.play()
//            videoNode.isPaused = true
            UIView.transition(with: TextTitle2, duration: 1, options: .curveLinear, animations: {self.TextTitle2.text = "电脑基于最小二乘法进行拟合，实现位置求解，并将位置信息反馈到移动设备或显示设备"}, completion: .none)
            textViewDidChange(TextTitle2)
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(12), execute: { [self] in
            changeView(cameraNode: cameraNode!)
            
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(Int(15)), execute: { [self] in
           
            textNode.isHidden = false
            let material = textNode.geometry?.firstMaterial
        
            
            SCNTransaction.begin()
                SCNTransaction.animationDuration = 1
                
                // on completion - unhighlight
                SCNTransaction.completionBlock = {
                    SCNTransaction.begin()
                    SCNTransaction.animationDuration = 1
                    material!.emission.contents = UIColor.black
                    SCNTransaction.commit()
                }
                
                material?.emission.contents = UIColor.red
            
            SCNTransaction.completionBlock = {
                SCNTransaction.begin()
                SCNTransaction.animationDuration = 1
                material!.emission.contents = UIColor.black
                SCNTransaction.commit()
            }
            
            material?.emission.contents = UIColor.red

            SCNTransaction.commit()
            UIView.transition(with: TextTitle2, duration: 1, options: .curveLinear, animations: {self.TextTitle2.text = "计算出的位置信息，可以传递到AR手持设备上，进行可视化展示，并提供了显示与虚拟互动的新交互方式"}, completion: .none)
            textViewDidChange(TextTitle2)
            floorText?.isHidden = false
            
        })
       
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(18), execute: { [self] in
            
            //让地面的字显示出来
           
            let material = floorText?.geometry?.firstMaterial
        
            
            SCNTransaction.begin()
                SCNTransaction.animationDuration = 1
                
                // on completion - unhighlight
                SCNTransaction.completionBlock = {
                    SCNTransaction.begin()
                    SCNTransaction.animationDuration = 1
                    material!.emission.contents = UIColor.black
                    SCNTransaction.commit()
                }
                
                material?.emission.contents = UIColor.red
            
            SCNTransaction.completionBlock = {
                SCNTransaction.begin()
                SCNTransaction.animationDuration = 1
                material!.emission.contents = UIColor.black
                SCNTransaction.commit()
            }
            
            material?.emission.contents = UIColor.red

            SCNTransaction.commit()
            
        })
        
       
        print("原理动画展示完成")
    }
    
    
    func rotateAll(){
        let cameraNode = ScenekitView.scene?.rootNode.childNode(withName: "camera" , recursively: true)
        //获取视野内的全部节点
        let nodes = ScenekitView.nodesInsideFrustum(of: cameraNode!)
//        let node  = ScenekitView.scene?.rootNode
//        node?.runAction(SCNAction.rotateBy(x: 0, y: 1, z: 0, duration: 3))
//        for node in nodes {
//            node.runAction(SCNAction.rotate(by: 1, around: SCNVector3(0, 1, 0), duration: 3))
//                }
    }
}
