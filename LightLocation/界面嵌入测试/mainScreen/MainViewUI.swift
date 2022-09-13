//
//  MainViewUI.swift
//  界面嵌入测试
//
//  Created by 郭映杉 on 2022/9/4.
//

import Foundation
import SceneKit
import UIKit

extension ViewController {
    //进行主菜单三个按钮的隐藏切换
    func hideMainButton(){
        if ARbeginButton.isHidden == false{
            ARbeginButton.isHidden = true
            SceneBeginButton.isHidden = true
            projectBeginBUtton.isHidden = true
            BackButton.isHidden = false
            
        }
        else{
            ARbeginButton.isHidden = false
            SceneBeginButton.isHidden = false
            projectBeginBUtton.isHidden = false
            BackButton.isHidden = true
        }
       
        
    }
}
