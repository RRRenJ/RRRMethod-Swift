//
//  CustomColor.swift
//  RRRExtensionDemo
//
//  Created by 任敬 on 2019/8/27.
//  Copyright © 2019 任敬. All rights reserved.
//

import UIKit

public extension UIColor {

    class func hex(hexCode:String) -> UIColor {
       var cleanCode = hexCode.replacingOccurrences(of:"#", with:"")
        if cleanCode.count == 3 {
            
            let str1 = cleanCode[0]
            let str2 = cleanCode[1]
            let str3 = cleanCode[2]
            cleanCode = str1 + str1 + str2 + str2 + str3 + str3
        }
        if cleanCode.count == 6 {
            cleanCode = cleanCode + "ff"
        }
        
        var baseValue : CUnsignedInt = 0
        Scanner(string: cleanCode).scanHexInt32(&baseValue)
        
        let red = CGFloat(baseValue >> 24 & 0xFF) / CGFloat(255.0)
        let green = CGFloat(baseValue >> 16 & 0xFF) / CGFloat(255.0)
        let blue = CGFloat(baseValue >> 8 & 0xFF) / CGFloat(255.0)
        let alpha = CGFloat(baseValue >> 0 & 0xFF) / CGFloat(255.0)
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }

}

public extension UIColor {
    
    class func gradientColor(view:UIView, fromColor:UIColor, toColor:UIColor, fromPoint:CGPoint, toPoint:CGPoint) ->CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [fromColor.cgColor,toColor.cgColor]
        gradientLayer.startPoint = fromPoint
        gradientLayer.endPoint = toPoint
        gradientLayer.locations = [NSNumber.init(value: 0),NSNumber.init(value: 1)]
        return gradientLayer
    }
    
}
