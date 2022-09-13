//
//  render.swift
//  界面嵌入测试
//
//  Created by 郭映杉 on 2022/8/30.
//

import Foundation
import SceneKit
import UIKit

extension ViewController {
    
    //每一帧实现刷新
  func renderer(_ renderer: SCNSceneRenderer, updateAtTime time:
    TimeInterval) {
      
      let camera = ScenekitView.scene?.rootNode.childNode(withName: "lowerCarCamera", recursively: true)
    
      
      let scnView = ScenekitView
      //格式化坐标数字
      let numberFormatter = NumberFormatter()
      numberFormatter.maximumFractionDigits = 2 //设置小数点后最多3位
      numberFormatter.minimumFractionDigits = 2 //设置小数点后最少2位（不足补0）
      //格式化
      
      
      let previousX = NSNumber(value: car.position.x)
      let previousY = NSNumber(value: car.position.z)
      let x = numberFormatter.string(from: previousX)!
      let y = numberFormatter.string(from: previousY)!
      positionWord = "(X:\(x),Y:\(y),Z:0.0)"
      //更新text的值,设置text的属性
      text.string = positionWord
      text.font = UIFont.systemFont(ofSize: 3)
      text.firstMaterial?.diffuse.contents = UIColor.gray
      textNode.position = textposition
      // 设置字体的大小
      text.font = UIFont.systemFont(ofSize: 1)
      
      scnView?.scene!.rootNode.addChildNode(textNode)
      textposition = SCNVector3((car.position.x)-4.0,(car.position.y)+2.0,(car.position.z))
      
      
//      camera?.position = SCNVector3(car.position.x,car.position.y+5,car.position.z)
      
 
//      if game.state == .Playing { //当时可玩状态时
//        if time > spawnTime { 进行生产几何模型速度的时间调节
//          spawnShape()
//          spawnTime = time + TimeInterval(Float.random(min: 0.2, max: 1.5))
//        }
//        cleanScene() //删除场景内节点
//      }
//      game.updateHUD() //更新文字表述
  }
}
 
