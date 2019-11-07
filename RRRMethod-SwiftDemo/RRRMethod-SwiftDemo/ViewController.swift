//
//  ViewController.swift
//  RRRMethod-SwiftDemo
//
//  Created by 任敬 on 2019/8/26.
//  Copyright © 2019 任敬. All rights reserved.
//

import UIKit
import RRRExtension

var dataArray = [Item(title: "为何出现"),Item(title: "在彼此的生活"),Item(title: "又离开"),Item(title: "只留下在心里"),Item(title: "深深浅浅的表白"),Item(title: "曾经意外 他和她相爱 在不会 犹豫的时代 你的关怀 一直随身带 你的关怀 一直随身带")]

class ViewController: UIViewController {

    var method : RRRCountDownMethod!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
//        self.EqualLayout()
        self.CountDown()
//        let frame = CGRect(x: 100, y: 100, width: 100, height: 100)
//       let label = UILabel(title: "xxxx", color: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), font: UIFont.systemFont(ofSize: 15), NSTextAlignment.left, frame)
//        label.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
     
//        self.view.addSubview(label)
   
        
//        let bt = UIButton(title: "666", titleColor: #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1), btColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), nil, UIButton.ButtonType.system)
//        
//        bt.frame = frame
//        self.view.addSubview(bt)
        
        
    }
    
    func QR() {
        let imageView = UIImageView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        imageView.image = QRCreateMethod.createQR(QRString: "微服务微服务覅偶尔我和覅偶尔晚饭后威锋网费", QRWidth: 100, nil, nil)
        self.view.addSubview(imageView)
    }
    
    func EqualLayout()  {
        let layout : EqualSpaceLayout = EqualSpaceLayout.init(.left, 30)
        let collection = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collection.backgroundColor = BackgroundColor
        collection.delegate = self
        collection.dataSource = self
        collection.register(TitleCell.self, forCellWithReuseIdentifier: "cell")
        self.view.addSubview(collection)
    }
    
    func CountDown() {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 50)
        button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: UIControl.State.normal)
        button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: UIControl.State.disabled)
        button.titleLabel?.font =  UIFont.systemFont(ofSize: 15)
        button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        self.view.addSubview(button)
        
//        let send = UIButton(type: UIButton.ButtonType.custom)
//        send.frame = CGRect(x: 50, y: 200, width: 50, height: 50)
//        send.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: UIControl.State.normal)
//        send.setTitle("发送", for: UIControl.State.normal)
//        send.titleLabel?.font =  UIFont.systemFont(ofSize: 15)
//        send.backgroundColor = #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)
//        self.view.addSubview(send)
        
        let sendingBt = UIButton(type: UIButton.ButtonType.custom)
        sendingBt.frame = CGRect(x: 150, y: 200, width: 50, height: 50)
        sendingBt.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: UIControl.State.normal)
        sendingBt.setTitle("发送...", for: UIControl.State.normal)
        sendingBt.titleLabel?.font =  UIFont.systemFont(ofSize: 15)
        sendingBt.backgroundColor = #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)
        self.view.addSubview(sendingBt)
        
        let fail = UIButton(type: UIButton.ButtonType.custom)
        fail.frame = CGRect(x: 250, y: 200, width: 50, height: 50)
        fail.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: UIControl.State.normal)
        fail.setTitle("失败", for: UIControl.State.normal)
        fail.titleLabel?.font =  UIFont.systemFont(ofSize: 15)
        fail.backgroundColor = #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)
        self.view.addSubview(fail)
        
        self.method = RRRCountDownMethod(button: button,start: "发送验证码",wait: "正在发送...",end: "再次发送", time: nil)
        button.addTarget(self, action: #selector(send), for: UIControl.Event.touchUpInside)
        sendingBt.addTarget(self, action: #selector(sending), for: UIControl.Event.touchUpInside)
        fail.addTarget(self, action: #selector(resend), for: UIControl.Event.touchUpInside)
        
    }
    
    @objc func send() {
        PrivacyManager.default.canUsageBluetooth { status in
            print(status)
        }
//        self.method.send()
    }
    
   @objc func sending() {
        self.method.sending()
    }
   @objc func resend() {
        self.method.resend()
    }
    
    
    
   
}

extension UIViewController : UICollectionViewDataSource {

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TitleCell
        cell.titleLb.text = dataArray[indexPath.row].title
        return cell
    }
}




extension UIViewController : UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10;
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 30;
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return dataArray[indexPath.row].size
    }
}


extension UIViewController : UICollectionViewDelegate {
    
    
    
}

struct Item {
    var title : String!
    var size : CGSize!
    init(title : String) {
        self.title = title
        let titleSize = self.title.boundingRect(with: CGSize.init(width: SCR_WIDTH - 20, height: CGFloat.greatestFiniteMagnitude), font: UIFont.systemFont(ofSize: 15));
        self.size = CGSize(width: titleSize.width + 10, height: titleSize.height + 10)
    }
}

extension String {
    
    func boundingRect(with constrainedSize: CGSize, font: UIFont, lineSpacing: CGFloat? = nil) -> CGSize {
        let attritube = NSMutableAttributedString(string: self)
        let range = NSRange(location: 0, length: attritube.length)
        attritube.addAttributes([NSAttributedString.Key.font: font], range: range)
        if lineSpacing != nil {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = lineSpacing!
            attritube.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: range)
        }
        
        let rect = attritube.boundingRect(with: constrainedSize, options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
        var size = rect.size
        
        if let currentLineSpacing = lineSpacing {
            // 文本的高度减去字体高度小于等于行间距，判断为当前只有1行
            let spacing = size.height - font.lineHeight
            if spacing <= currentLineSpacing && spacing > 0 {
                size = CGSize(width: size.width, height: font.lineHeight)
            }
        }
        
        return size
    }
    
    func boundingRect(with constrainedSize: CGSize, font: UIFont, lineSpacing: CGFloat? = nil, lines: Int) -> CGSize {
        if lines < 0 {
            return .zero
        }
        
        let size = boundingRect(with: constrainedSize, font: font, lineSpacing: lineSpacing)
        if lines == 0 {
            return size
        }
        
        let currentLineSpacing = (lineSpacing == nil) ? (font.lineHeight - font.pointSize) : lineSpacing!
        let maximumHeight = font.lineHeight*CGFloat(lines) + currentLineSpacing*CGFloat(lines - 1)
        if size.height >= maximumHeight {
            return CGSize(width: size.width, height: maximumHeight)
        }
        
        return size
    }
}


class TitleCell: UICollectionViewCell {
    
    var titleLb : UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.titleLb = UILabel.init(frame: CGRect(x: 5, y: 5, width: self.contentView.frame.width - 10, height: self.contentView.frame.height - 10))
        self.titleLb.font = UIFont.systemFont(ofSize: 15)
        self.titleLb.textAlignment = .center
        self.titleLb.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.contentView.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
        self.contentView.addSubview(self.titleLb)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


