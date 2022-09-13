//
//  ViewController.swift
//  界面嵌入测试
//
//  Created by 郭映杉 on 2022/8/25.
//

import UIKit
import SceneKit
import SpriteKit


class ViewController: UIViewController,SCNSceneRendererDelegate {
    @IBOutlet weak var ScenekitView: SCNView!
    //主页面三个按钮
    
    @IBOutlet weak var ARbeginButton: UIButton!
    @IBOutlet weak var SceneBeginButton: UIButton!
    @IBOutlet weak var projectBeginBUtton: UIButton!
    //三个图标
        
    //展示界面的UI绑定
    @IBOutlet weak var BackButton: UIButton!
    @IBOutlet weak var Text3: UITextView!
    @IBOutlet weak var TextView: UITextView!
    @IBOutlet weak var LEDButton: UIButton!
    @IBOutlet weak var FrameButton: UIButton!
    @IBOutlet weak var Title1: UITextView!
   
    @IBOutlet weak var showButton: UIButton!
    @IBOutlet weak var TextTitle2: UITextView!
    @IBOutlet weak var LocationButton: UIButton!
    
    @IBOutlet weak var clickLabel: UILabel!
    
    
    var count = 0
    var isMainmenu = true
    var angle = SCNVector3(0, 0, 0)
    var positionWord = "(X:,Y:,Z:)"
    //小汽车的坐标
    var carPosition = SCNVector3()
    //坐标标签的坐标
    var textposition = SCNVector3()
    var car = SCNNode()
    //标签节点
    var textNode = SCNNode()
    let text = SCNText()
    
    //设置界面层级
    var sceneLayer = 0
    
    var isAnimated = true
    //视频节点
    let url = Bundle.main.url(forResource: "art.scnassets/core", withExtension: "mov")
    var videoNode = SKVideoNode()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        let hardware = scene.rootNode.childNode(withName: "hardware", recursively: true)
        hardware?.opacity = 0.0
        
        car = scene.rootNode.childNode(withName: "car", recursively: true)!
        car.opacity = 0.0
        let computer = scene.rootNode.childNode(withName: "computer", recursively: true)
        let desk = scene.rootNode.childNode(withName: "table", recursively: true)
        
        computer?.opacity = 0.0
        desk?.opacity = 0.0
        
        
        //车和车坐标文字的父节点
        text.extrusionDepth = 0.2
        text.firstMaterial?.diffuse.contents = UIColor.yellow
        textNode = SCNNode(geometry: text)
        textNode.isHidden = true
        //将代理设成self的,才可以实现render(update)函数
        ScenekitView.delegate = self
        //添加坐标文字标签
        Text3.layer.cornerRadius = 15
        carPosition = SCNVector3(car.position.x,car.position.y,car.position.z)
        print(car.position.y)
        textposition = SCNVector3((car.position.x)-1.0,(car.position.y)+2.0,(car.position.z))
        print(car.position.y)
        
//        car.runAction(SCNAction.move(to: SCNVector3(10, 0, 10), duration: 5))
//
//        ARbeginButton.addSubview(ArIcon)
//        SceneBeginButton.addSubview(LocationIcon)
//        projectBeginBUtton.addSubview(projectIcon)
        
        ARbeginButton.setImage(UIImage(systemName: "search"), for: .normal)
        ARbeginButton.imageEdgeInsets = UIEdgeInsets(top: 3, left: 0, bottom: 0, right: -8)
        //设置9个灯光慢慢亮起
        let spotNode = scene.rootNode.childNode(withName: "spot", recursively: true)
    
       
        let image = UIImage(systemName: "star")

        let imageView = UIImageView(image: image)
        let attachment = NSTextAttachment()
        attachment.image = UIImage(systemName: "xmark.circle")

        let imageString = NSMutableAttributedString(attachment: attachment)
        let textString = NSAttributedString(string: "Please try again")
        imageString.append(textString)

        let label = UILabel()
        label.attributedText = imageString
        label.sizeToFit()
        
    
//设置图标大小
        ARbeginButton.imageView?.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5)
        projectBeginBUtton.imageView?.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5)
        SceneBeginButton.imageView?.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5)
        
      //设置UItextview自适应大小
       
       
        
        //设置ui属性
        Title1.layer.cornerRadius = 10
        TextTitle2.layer.cornerRadius = 10
        TextTitle2.isHidden = true
        TextTitle2.translatesAutoresizingMaskIntoConstraints = true
        TextTitle2.isScrollEnabled = false
        TextTitle2.sizeToFit()
//        textViewDidChange(TextTitle2)
        
        
        //设置地面为白色
        let floor = scene.rootNode.childNode(withName: "floor", recursively: true)
        floor?.geometry?.firstMaterial?.emission.contents = UIColor.white
        
        
        angle = hardware!.eulerAngles
 TextView.alpha = 0
        TextView.layer.cornerRadius = 15
        
       
       
        TextView.textContainerInset = UIEdgeInsets(top: 10,left: 20, bottom: 20, right: 20)
//        TextView.textContainer.lineFragmentPadding = 0
    
        
        
        BackButton.isHidden = true
        clickLabel.isHidden = true
        
        HideUI(state: true)
        //初始相机配置
//        let camera = scene.rootNode.childNode(withName: "camera", recursively: true)
        let camera = scene.rootNode.childNode(withName: "mainCamera", recursively: true)
        let viewConstraint = SCNLookAtConstraint(target: hardware)
//        viewConstraint.influenceFactor = 0.07
        viewConstraint.isGimbalLockEnabled = true
        
        
        let distanceConstraint = SCNDistanceConstraint(target: hardware)
        distanceConstraint.maximumDistance = 60
        distanceConstraint.minimumDistance = 55
        
//        camera?.constraints = [viewConstraint,distanceConstraint]
        camera?.camera?.zFar = 10000
        
//        //灯光设置
//        let lightNode = SCNNode()
//        lightNode.light = SCNLight()
//        lightNode.light!.type = .omni
//        lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
//        scene.rootNode.addChildNode(lightNode)
        
        // create and add an ambient light to the scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light?.intensity = 500
        ambientLightNode.light!.type = .ambient
        ambientLightNode.light!.color = UIColor.white
        scene.rootNode.addChildNode(ambientLightNode)
        
        self.ScenekitView.pointOfView = camera
        ScenekitView.allowsCameraControl = true
        ScenekitView.scene = scene
        
        //开局的缓慢出现
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: { [self] in
            
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 5
            hardware?.opacity = 1
            computer?.opacity = 1
            desk?.opacity = 1
            car.opacity = 1
            SCNTransaction.commit()
            
            
        })
        
        //让框架转起来
        
//         hardware?.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 1, z: 0, duration: 20)))
        
        //定义点击手势
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        ScenekitView.addGestureRecognizer(tapGesture)
        
        
        
        
        
        //蓝牙模块
        let baby = BabyBluetooth()
        
        
        //创建视频在电脑屏幕上
       
//        videoNode.play()
//        
       
    }
    //加载完画面之后做的事情
    override func viewDidAppear(_ animated: Bool) {
        //产生粒子效果
       
//        switchLight()
    }
    
    //启动ar界面
    @IBAction func beginAR(_ sender: Any) {
        
        
    }
    
    
    //加载定位原理动画展示界面
    @IBAction func beginScene(_ sender: Any) {
        hideMainButton()
        HideUI(state: false)
        let camera = ScenekitView.scene!.rootNode.childNode(withName: "camera", recursively: true)
        changeView(cameraNode: camera!)
        
        
        //让地面变成白色
        let floor = ScenekitView.scene!.rootNode.childNode(withName: "floor", recursively: true)
        //
        SCNTransaction.begin()
        SCNTransaction.animationDuration = 1
        floor?.geometry?.firstMaterial?.emission.contents = UIColor.gray
        SCNTransaction.commit()
        
        switchLight()
        rotateAll()
        increaseLayer()
        
    }
    
    
    
    //加载项目介绍
    @IBAction func beginIntroduce(_ sender: Any) {
        
        
    }
    
    
    
    
    //点击定位模块按钮
    @IBAction func showDetailOfLocation(_ sender: Any) {
        Title1.isHidden = true
        let camera = ScenekitView.scene?.rootNode.childNode(withName: "lowerCarCamera", recursively: true)
        camera?.position = SCNVector3(carPosition.x,carPosition.y+7,carPosition.z)
        changeView(cameraNode: camera!)
        HideUI(state: true)
        Text3.text = "装有PD（光电二极管）的小车\n将接收的光线强度信号转换成电信号\n采用频分复用的形式降低噪声"
        Text3.layer.cornerRadius = 15
        Text3.isHidden = false
       textViewDidChange(Text3)
        
        increaseLayer()
        
    }
    
    
    //开关灯
    @IBAction func 关灯(_ sender: Any) {
        switchLight()
    }
    //点击介绍框架内容
    @IBAction func showDetailsOfHardware(_ sender: Any) {
        Title1.isHidden = true
        let camera = ScenekitView.scene?.rootNode.childNode(withName: "frameCamera2", recursively: true)
        HideUI(state: true)
        Text3.text = "外部框架\n2.7m高，1m宽，2m长铝制框架\n形成有效范围2平方米的定位空间"
        Text3.layer.cornerRadius = 15
        Text3.isHidden = false
        textViewDidChange(Text3)
        changeView(cameraNode: camera!)
        increaseLayer()
        
    }
    
    //展示原理过程的动画
    @IBAction func showProgress(_ sender: Any) {
        Title1.isHidden = true
        HideUI(state: true)
      //展示原理的全过程
        totalAnimationOfProgress()
        increaseLayer()

       
        
    }
    //点击返回按钮的响应事件
    @IBAction func BackToward(_ sender: Any) {
        //返回主菜单选项
        if sceneLayer == 1{
            let LightcameraNode = ScenekitView.scene?.rootNode.childNode(withName: "mainCamera", recursively: true)
            changeView(cameraNode: LightcameraNode!)
            hideMainButton()
            sceneLayer -= 1
            HideUI(state: true)
            ScenekitView.allowsCameraControl = true
            let floor = ScenekitView.scene!.rootNode.childNode(withName: "floor", recursively: true)
            //
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 1
            floor?.geometry?.firstMaterial?.emission.contents = UIColor.white
            SCNTransaction.commit()
            switchLight()
//            totalAnimationOfProgress()
        }
        //返回scene展示界面
        else if sceneLayer == 2{
            let LightcameraNode1 = ScenekitView.scene?.rootNode.childNode(withName: "camera", recursively: true)
            //消失动画
            HideUI(state: false)
            UIView.transition(with: TextView, duration: 0.3, options: .curveLinear, animations: {self.TextView.alpha = 0.0}, completion: .none)
            changeView(cameraNode: LightcameraNode1!)
            Title1.isHidden = false
            isMainmenu = true
            LEDButton.isHidden = false
            Text3.isHidden = true
            sceneLayer -= 1
            ScenekitView.allowsCameraControl = true
            clickLabel.isHidden = true
            isAnimated = false
        }
        
        
        
        
        
        
    }
    
    @objc func callback() {
        print("done")
    }
    
    //介绍灯光部分
    @IBAction func ShowLed(_ sender: UIButton) {
//        let hardware = ScenekitView.scene?.rootNode.childNode(withName: "hardware", recursively: true)
//
//        hardware?.runAction(SCNAction.rotateBy(x: 0, y: 2, z: 0, duration: 3))
        let LightcameraNode1 = ScenekitView.scene?.rootNode.childNode(withName: "lightcamera1", recursively: true)
        let hardware = ScenekitView.scene?.rootNode.childNode(withName: "hardware", recursively: true)
//        hardware?.eulerAngles = angle
        Text3.text = "采集频分复用的光信号\n\n信号频率（80k～150K)赫兹\n\n有别于处于高频位置的随机噪声喝热噪声\n\n带通滤波器处理后，通过FFT提取信号强度\n\n可大幅降低环境光干扰和随机干扰"
        textViewDidChange(Text3)
        Text3.isHidden = false
//        TextTitle2.isHidden = false
        HideUI(state: true)
//     UIView.transition(with: TextView, duration: 1, options: .curveLinear, animations: {self.TextView.alpha = 1.0}, completion: .none)
        
        
        //显示红色
        let material = ScenekitView.scene?.rootNode.childNode(withName: "Cube_001", recursively: true)?.geometry?.firstMaterial
        
        
        changeView(cameraNode: LightcameraNode1!)
//        TextView.isHidden = false
        Title1.isHidden = true
        
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

        SCNTransaction.commit()
        
        clickLabel.isHidden = false
        
        increaseLayer()
        
    }
    
    
    //手势点击操作
    @objc
    func handleTap(_ gestureRecognize: UIGestureRecognizer) {
        // retrieve the SCNView
        let scnView = ScenekitView
        let alertView = UIAlertController(title: "光源介绍", message: "这是一个可以调频的LED灯", preferredStyle: UIAlertController.Style.alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: {_ in})
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertAction.Style.cancel, handler: {_ in})
        alertView.addAction(OKAction)
        alertView.addAction(cancelAction)
        
        
        
        // check what nodes are tapped
        let p = gestureRecognize.location(in: ScenekitView)
        let hitResults = ScenekitView.hitTest(p, options: [:])
        //远景视角
        let cameraNode = ScenekitView.scene?.rootNode.childNode(withName: "camera", recursively: true)
        
        //灯泡视角
        let LightcameraNode1 = ScenekitView.scene?.rootNode.childNode(withName: "lightcamera1", recursively: true)
        
        let LightcameraNode2 = ScenekitView.scene?.rootNode.childNode(withName: "lightcamera2", recursively: true)
        
        
        
        // check that we clicked on at least one object
        if hitResults.count > 0 {
            // retrieved the first clicked object
            let result = hitResults[0]
            let resultPostion = result.node.position.x
            let tapPosition = result.worldCoordinates
            print(tapPosition)
            //让小车移动到手点击的位置并发送灯光效果到小车身上
            if tapPosition.x>(-7) && tapPosition.x<7 && tapPosition.y<1 && tapPosition.z>(-7) && tapPosition.z<7 {
                print("点击成功")
                car.runAction(SCNAction.move(to: tapPosition, duration: 2))
                TextTitle2.text = "小车会根据移动的位置\n实时获取坐标\n产生可视化结果"
               
                TextTitle2.isHidden = false
                textViewDidChange(TextTitle2)
                carPosition = tapPosition
                //显示一个红点来描述点击的位置
                let sphere = SCNSphere()
                let node = SCNNode(geometry: sphere)
                sphere.firstMaterial?.diffuse.contents = UIColor.red
                sphere.radius = 0.3
                scnView?.scene?.rootNode.addChildNode(node)
                node.position = tapPosition
                SCNTransaction.begin()
                SCNTransaction.animationDuration = 1
                node.opacity = 0.0
                SCNTransaction.commit()
                //实现灯光动画
                lightAnimation()
                
                
            }
            
        
            
            //检测点击到硬件框架
            if result.node.name == "Cube_001" && count == 0{
                changeView(cameraNode: LightcameraNode2!)
                clickLabel.isHidden = true
                //显示LED介绍
                TextTitle2.isHidden = true
                Text3.text = "LED(80k～150K赫兹)\n\n形成3*3可见光源矩阵"
                
                Text3.frame.size = CGSize(width: 400, height: 100)
//                textViewDidChange(Text3)
               
            }
            else if result.node.name == "Cube_001" && count == 1{
                changeView(cameraNode: LightcameraNode2!)
//                ShowLed(self.LEDButton)
               
            }
//            else if result.node.name == "Grid_003"{
//                //切换视角到远景上面
//                showDetailsOfHardware(self.FrameButton)
////
////                SCNTransaction.begin()
////                SCNTransaction.animationDuration = 2
////                ScenekitView.pointOfView = cameraNode
////                SCNTransaction.commit()
//            }
            
            

        }
    }

    func changeView (cameraNode: SCNNode){
        //切换视角到全部灯泡上面
        SCNTransaction.begin()
        SCNTransaction.animationDuration = 2
        ScenekitView.pointOfView = cameraNode
        SCNTransaction.commit()
    }
    
    
    
    //snctext文字居中
    func centerText (textnode: SCNNode)-> SCNVector3{
        let text = textnode.geometry as! SCNText
            let min = text.boundingBox.min
            let max = text.boundingBox.max
            let width = max.x - min.x
            let height = max.y - min.y
            let length = max.z - min.z
            let position = SCNVector3Make(-width/2.0 - min.x, -height/2.0 - min.y, -length/2.0 - min.z)
            
        return position
    }
    
    
    
    func textViewDidChange(_ textView: UITextView) {
        
        textView.translatesAutoresizingMaskIntoConstraints = true
        textView.isScrollEnabled = false
        UIView.transition(with: TextView, duration: 0.5, options: .curveLinear, animations: {self.TextView.sizeToFit()}, completion: .none)
        textView.sizeToFit()
    }
    
    //增加页面层级
    func increaseLayer(){
        sceneLayer += 1
    }
     
    
}


