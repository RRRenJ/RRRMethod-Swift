//
//  RRRMethod-Confige.swift
//  RRRMethod-SwiftDemo
//
//  Created by 任敬 on 2019/8/26.
//  Copyright © 2019 任敬. All rights reserved.
//

import Foundation
import UIKit


public let SCR_WIDTH = UIScreen.main.bounds.width
public let SCR_HEIGHT = UIScreen.main.bounds.height

public let StatusBarHeight = CGFloat(UIApplication.shared.statusBarFrame.size.height)

public let IS_BANG = StatusBarHeight > CGFloat(20.0)

public let NaviBarHeight = CGFloat(44.0)
public let TabBarHeight = IS_BANG ? CGFloat(83.0) : CGFloat(49.0)
public let BottomHeight = IS_BANG ? CGFloat(34.0) : CGFloat(0.0)
public let TopHeight = StatusBarHeight + NaviBarHeight

public let IS_IPAD = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad
public let IS_IPHONE = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone

public let SCREEN_MAX_LENGTH = max(SCR_WIDTH, SCR_HEIGHT)
public let SCREEN_MIN_LENGTH = min(SCR_WIDTH, SCR_HEIGHT)

public let IS_RETINA_2 = UIScreen.main.scale == 2.0
public let IS_RETINA_3 = UIScreen.main.scale == 3.0

public let iPhone35 = IS_IPHONE && (SCREEN_MAX_LENGTH == 480.0)
public let iPhone40 = IS_IPHONE && (SCREEN_MAX_LENGTH == 568.0)
public let iPhone47 = IS_IPHONE && (SCREEN_MAX_LENGTH == 667.0)
public let iPhone55 = IS_IPHONE && (SCREEN_MAX_LENGTH == 736.0)
public let iPhone58 = IS_IPHONE && (SCREEN_MAX_LENGTH == 812.0)
public let iPhone61 = IS_IPHONE && (SCREEN_MAX_LENGTH == 896.0) && IS_RETINA_2
public let iPhone65 = IS_IPHONE && (SCREEN_MAX_LENGTH == 896.0) && IS_RETINA_3

public let BackgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9529411765, alpha: 1)
