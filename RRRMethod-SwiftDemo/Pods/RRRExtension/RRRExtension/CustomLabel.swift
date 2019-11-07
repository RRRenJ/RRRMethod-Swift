//
//  CustomLabel.swift
//  RRRMethod-SwiftDemo
//
//  Created by 任敬 on 2019/8/26.
//  Copyright © 2019 任敬. All rights reserved.
//

import UIKit

public extension UILabel{

    convenience init( title:String, color:UIColor, font:UIFont, _ textAlignment:NSTextAlignment?, _ frame:CGRect?) {
        self.init()
        self.text = title
        self.textColor = color
        self.font = font
        self.textAlignment = textAlignment ?? NSTextAlignment.left
        if let _ = frame {
            self.frame = frame!
        }
    }
    
    

}
