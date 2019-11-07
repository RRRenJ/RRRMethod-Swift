//
//  CustomImage.swift
//  RRRExtensionDemo
//
//  Created by 任敬 on 2019/8/27.
//  Copyright © 2019 任敬. All rights reserved.
//

import UIKit
import AVFoundation

public extension UIImage {
    //image切圆
    func cutCircle() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0.0)
        let ctr = UIGraphicsGetCurrentContext()
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        ctr?.addEllipse(in: rect)
        ctr?.clip()
        self.draw(in: rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image ?? self
    }
    //修改image尺寸
    func modifySize(reSize:CGSize) -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: reSize.width, height: reSize.height))
        self.draw(in: CGRect(x: 0, y: 0, width: reSize.width, height: reSize.height))
        let reSizeImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return reSizeImage?.withRenderingMode(.alwaysOriginal) ?? self
        
    }
    //根据颜色获得图片
    class func create(color:UIColor, size:CGSize) -> UIImage{
        let imageW = size.width
        let imageH = size.height
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        color.set()
        UIRectFill(CGRect(x: 0, y: 0, width: imageW, height: imageH))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    //根据url获取size
    class func getSize(url : AnyObject) -> CGSize{
        var uRL : URL
        if url is String {
            uRL = URL(string: url as! String)!
        }else if  url is URL{
            uRL = url as! URL
        }else{
            return CGSize.zero
        }
        
        var imageSize:CGSize = .zero
        guard let imageSourceRef = CGImageSourceCreateWithURL(uRL as CFURL, nil) else {return imageSize}
        guard let imagePropertie = CGImageSourceCopyPropertiesAtIndex(imageSourceRef, 0, nil)  as? Dictionary<String,Any> else {return imageSize }
        imageSize.width = CGFloat((imagePropertie[kCGImagePropertyPixelWidth as String] as! NSNumber).floatValue)
        imageSize.height = CGFloat((imagePropertie[kCGImagePropertyPixelHeight as String] as! NSNumber).floatValue)
        return imageSize
        
    }
    
    

}
