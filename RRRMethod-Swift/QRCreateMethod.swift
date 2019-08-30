//
//  QRCreateMethod.swift
//  RRRMethod-SwiftDemo
//
//  Created by 任敬 on 2019/8/26.
//  Copyright © 2019 任敬. All rights reserved.
//

import UIKit

public class QRCreateMethod: NSObject {

   public class func createQR(QRString qrString : String, QRWidth width : CGFloat , _ centerImage : UIImage? , _ centerSize : CGSize?) -> UIImage {
        
        let filter : CIFilter! = CIFilter.init(name: "CIQRCodeGenerator")
        filter.setDefaults()
        let data = qrString.data(using: .utf8)
        filter.setValue(data, forKey: "inputMessage")
        if let outputImage = filter.outputImage {
            let qrCodeImage = getImage(ciImage: outputImage, imageWidth: width)
            
            if let centerImage = centerImage {
                let newImage = syntheticImage(image: qrCodeImage, centerImage: centerImage, size: centerSize!)
                return newImage
            }
            
            return qrCodeImage
        }
        return UIImage()
    }

    
    
}

public extension QRCreateMethod {
    private class func getImage(ciImage : CIImage , imageWidth : CGFloat) -> UIImage {
        
        let integral = ciImage.extent.integral
        
        let scale = min(imageWidth / integral.width, imageWidth / integral.height)
        
        let width = size_t(integral.width * scale)
        
        let height = size_t(integral.height * scale)
        
        let cs = CGColorSpaceCreateDeviceGray()
        
        let bitmapRef = CGContext.init(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: 0, space: cs, bitmapInfo: 0)
        
        let context = CIContext.init(options: nil)
        let bitmapImage = context.createCGImage(ciImage, from: integral)
        
        bitmapRef?.interpolationQuality = CGInterpolationQuality.none
        bitmapRef?.scaleBy(x: scale, y: scale)
        bitmapRef?.draw(bitmapImage!, in: integral)
        let image = bitmapRef?.makeImage()
        return UIImage(cgImage: image!)
    }
    
    private class func syntheticImage(image : UIImage, centerImage: UIImage , size : CGSize) -> UIImage{
        UIGraphicsBeginImageContext(image.size)
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))
        let x = (image.size.width - size.width) * 0.5
        let y = (image.size.height - size.height) * 0.5
        centerImage.draw(in: CGRect(x: x, y: y, width: size.width, height: size.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        if let newImage = newImage {
            return newImage
        }
        return UIImage()
    }
}





