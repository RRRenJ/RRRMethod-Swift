//
//  RRRMethod-Confige.swift
//  RRRMethod-SwiftDemo
//
//  Created by 任敬 on 2019/8/26.
//  Copyright © 2019 任敬. All rights reserved.
//

import Foundation
import UIKit


let SCR_WIDTH = UIScreen.main.bounds.width
let SCR_HEIGHT = UIScreen.main.bounds.height

let StatusBarHeight = CGFloat(UIApplication.shared.statusBarFrame.size.height)

let IS_BANG = StatusBarHeight > CGFloat(20.0)

let NaviBarHeight = CGFloat(44.0)
let TabBarHeight = IS_BANG ? CGFloat(83.0) : CGFloat(49.0)
let BottomHeight = IS_BANG ? CGFloat(34.0) : CGFloat(0.0)
let TopHeight = StatusBarHeight + NaviBarHeight

let IS_IPAD = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad
let IS_IPHONE = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone

let SCREEN_MAX_LENGTH = max(SCR_WIDTH, SCR_HEIGHT)
let SCREEN_MIN_LENGTH = min(SCR_WIDTH, SCR_HEIGHT)

let IS_RETINA_2 = UIScreen.main.scale == 2.0
let IS_RETINA_3 = UIScreen.main.scale == 3.0

let iPhone35 = IS_IPHONE && (SCREEN_MAX_LENGTH == 480.0)
let iPhone40 = IS_IPHONE && (SCREEN_MAX_LENGTH == 568.0)
let iPhone47 = IS_IPHONE && (SCREEN_MAX_LENGTH == 667.0)
let iPhone55 = IS_IPHONE && (SCREEN_MAX_LENGTH == 736.0)
let iPhone58 = IS_IPHONE && (SCREEN_MAX_LENGTH == 812.0)
let iPhone61 = IS_IPHONE && (SCREEN_MAX_LENGTH == 896.0) && IS_RETINA_2
let iPhone65 = IS_IPHONE && (SCREEN_MAX_LENGTH == 896.0) && IS_RETINA_3

let BackgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9529411765, alpha: 1)
