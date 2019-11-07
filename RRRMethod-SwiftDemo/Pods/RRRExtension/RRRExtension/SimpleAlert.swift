//
//  SimpleAlert.swift
//  RRRExtensionDemo
//
//  Created by 任敬 on 2019/8/27.
//  Copyright © 2019 任敬. All rights reserved.
//

import UIKit

public extension UIAlertController {

  class func create(_ title:String?, _ message:String?, style:UIAlertController.Style, actions:[(UIAlertAction.Style, String)], hander:@escaping (Int) -> ()) -> UIAlertController{
        let alert  = UIAlertController.init(title: title, message: message, preferredStyle: style)
    
        for (index, item) in actions.enumerated() {
            let (actionStyle, actionTitle) = item
            let action = UIAlertAction.init(title: actionTitle, style: actionStyle) { (action) in
                hander(index)
            }
            alert.addAction(action)
        }
        return alert
    }

}
