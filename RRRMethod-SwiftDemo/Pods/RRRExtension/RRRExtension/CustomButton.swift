//
//  CustomButton.swift
//  RRRMethod-SwiftDemo
//
//  Created by 任敬 on 2019/8/26.
//  Copyright © 2019 任敬. All rights reserved.
//

import UIKit


public extension UIButton {

    convenience init(title:String?, titleColor:UIColor?, btColor:UIColor, _ frame:CGRect?, _ type:UIButton.ButtonType?){
        self.init(type: type ?? ButtonType.system)
        self.setTitle(title, for: UIControl.State.normal)
        self.setTitleColor(titleColor, for: UIControl.State.normal)
        self.backgroundColor = btColor
        if let _ = frame {
             self.frame = frame!
        }
    }
}

public extension UIButton{
    //button图片位置
    enum EdgeInsetsStyle {
        case top
        case left
        case right
        case bottom
    }
    func layoutBt(style:EdgeInsetsStyle, space:CGFloat) {
        let imageW = self.imageView?.frame.width ?? 0.0
        let imageH = self.imageView?.frame.height ?? 0.0
        
        var labelW = CGFloat(0.0)
        var labelH = CGFloat(0.0)
        
        if #available(iOS 8.0, *) {
            labelW = self.titleLabel?.intrinsicContentSize.width ?? 0.0
            labelH = self.titleLabel?.intrinsicContentSize.height ?? 0.0
        }else{
            labelW = self.titleLabel?.frame.width ?? 0.0
            labelH = self.titleLabel?.frame.height ?? 0.0
        }
        
        var imageEdgeInset = UIEdgeInsets.zero
        var labelEdgeInset = UIEdgeInsets.zero
        
        switch style {
        case .top:
            imageEdgeInset = UIEdgeInsets(top: -labelH-space/2.0, left: 0, bottom: 0, right: -labelW)
            labelEdgeInset = UIEdgeInsets(top: 0, left: -imageW, bottom: -imageH - space/2.0, right: 0)
        case .left:
            imageEdgeInset = UIEdgeInsets(top: 0, left: -space/2.0, bottom: 0, right: space/2.0)
            labelEdgeInset = UIEdgeInsets(top: 0, left: space/2.0, bottom:0, right: -space/2.0)
        case .right:
            imageEdgeInset = UIEdgeInsets(top: 0, left: labelW+space/2.0, bottom: 0, right: -labelW - space/2.0)
            labelEdgeInset = UIEdgeInsets(top: 0, left: -imageW-space/2.0, bottom: 0, right: imageW+space/2.0)
        case .bottom:
            imageEdgeInset = UIEdgeInsets(top: 0, left: 0, bottom: -labelH - space/2.0, right: -labelW)
            labelEdgeInset = UIEdgeInsets(top: -imageH-space/2.0, left: -imageW, bottom: 0, right: 0)
        
        }
        self.titleEdgeInsets = labelEdgeInset;
        self.imageEdgeInsets = imageEdgeInset;
    }
}


