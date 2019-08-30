//
//  EqualSpaceLayout.swift
//  RRRMethod-SwiftDemo
//
//  Created by 任敬 on 2019/8/26.
//  Copyright © 2019 任敬. All rights reserved.
//

import UIKit



public enum AlignType {
    case left
    case center
    case right
}

public class EqualSpaceLayout: UICollectionViewFlowLayout {

    var type : AlignType!
    var space : CGFloat = 10.0
    
    private var sumWith : CGFloat = 0
    
  
    
    init(_ type : AlignType! , _ space : CGFloat) {
        super.init()
        self.scrollDirection = .vertical
        self.minimumLineSpacing = 5
        self.minimumInteritemSpacing = 5
        self.sectionInset = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
        self.type = type
        self.space = space
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

public extension EqualSpaceLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttributes_t = super.layoutAttributesForElements(in: rect) ?? Array()
        var layoutAttributes = layoutAttributes_t
        var layoutAttributesTemp  = [UICollectionViewLayoutAttributes]()
        for i in 0..<layoutAttributes.count {
            let currentAttr = layoutAttributes[i]
            let previousAttr = (i == 0 ? nil : layoutAttributes[i - 1])
            let nextAttr = ((i + 1 == layoutAttributes.count) ? nil : layoutAttributes[i + 1])
            
            layoutAttributesTemp.append(currentAttr)
            self.sumWith += currentAttr.frame.width
            
            let previousY = previousAttr?.frame.maxY ?? 0
            let currentY = currentAttr.frame.maxY
            let nextY = nextAttr?.frame.maxY ?? 0
            
            if (currentY != previousY) && (currentY != nextY){
                if currentAttr.representedElementKind == UICollectionView.elementKindSectionHeader {
                    layoutAttributesTemp.removeAll()
                    self.sumWith = 0
                }else if currentAttr.representedElementKind == UICollectionView.elementKindSectionFooter {
                    layoutAttributesTemp.removeAll()
                    self.sumWith = 0
                }else{
                    self.setCellFrame(layoutAttr: &layoutAttributesTemp)
                }
            }else if currentY != nextY {
                self.setCellFrame(layoutAttr: &layoutAttributesTemp)
            }
        }
        return layoutAttributes
    }
}

public extension EqualSpaceLayout {
    
    func setCellFrame(layoutAttr : inout [UICollectionViewLayoutAttributes]) {
        
        var nowWidth : CGFloat = 0.0
        
        switch self.type! {
        case .left:
            nowWidth = self.sectionInset.left;
            for attr in layoutAttr {
                var nowFrame = attr.frame
                nowFrame.origin.x = nowWidth
                attr.frame = nowFrame
                nowWidth += nowFrame.width + self.space
            }
            self.sumWith = 0.0
            layoutAttr.removeAll()
            break
        case .center:
            nowWidth = (self.collectionView?.frame.width ?? SCR_WIDTH - self.sumWith - (CGFloat(layoutAttr.count) * self.space))/2
            for attr in layoutAttr {
                var nowFrame = attr.frame
                nowFrame.origin.x = nowWidth
                attr.frame = nowFrame
                nowWidth += nowFrame.width + self.space
            }
            self.sumWith = 0.0
            layoutAttr.removeAll()
            
            break
        case .right:
            nowWidth = self.collectionView?.frame.width ?? SCR_WIDTH - self.sectionInset.right
            for index in stride(from: layoutAttr.count - 1, to: 0, by: -1) {
                let attr = layoutAttr[index]
                var nowFrame = attr.frame
                nowFrame.origin.x = nowWidth
                attr.frame = nowFrame
                nowWidth += nowFrame.width + self.space
            }
            self.sumWith = 0.0
            layoutAttr.removeAll()
            break
        }
        
        
    }
    
    
}
