//
//  RRRCountDownMethod.swift
//  RRRMethod-SwiftDemo
//
//  Created by 任敬 on 2019/8/26.
//  Copyright © 2019 任敬. All rights reserved.
//

import UIKit

public class RRRCountDownMethod: NSObject {

    private var seconds : Int!
    private var totalSeconds : Int!
    private var start : String!
    private var wait : String!
    private var end : String!
    private var button : UIButton!
    private var timer : DispatchSourceTimer!
    
    init(button:UIButton! , start:String! , wait:String! , end:String! , time:Int? = 60){
        self.button = button
        self.start = start;
        self.wait = wait;
        self.end = end
        self.totalSeconds = time ?? 60
        self.button.setTitle(self.start, for: UIControl.State.normal)
    }
    
    public func send(){
        self.button.isEnabled = false
        self.button.setTitle(self.wait, for: UIControl.State.disabled)
    }
    
    public func sending(){
        self.timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
        self.timer.schedule(deadline: .now(), repeating: .seconds(1))
        self.seconds = self.totalSeconds
        
        self.timer.setEventHandler(handler: {
            let title = "\(String(self.seconds))s"
            DispatchQueue.main.async {
                self.button.setTitle(title, for: UIControl.State.disabled)
                self.button.isEnabled = false
                if self.seconds < 0 {
                    self.resend()
                }
            }
            self.seconds -= 1
        })
        self.timer.resume()
       
    }
    
    public func resend(){
        self.timer.cancel()
        self.button.isEnabled = true
        self.button.setTitle(self.end, for: UIControl.State.normal)
    }
    
}
