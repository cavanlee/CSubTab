//
//  CSubTab.swift
//  CSubTab
//
//  Created by Cavan on 2018/10/19.
//  Copyright © 2018年 cavanlee. All rights reserved.
//

import UIKit

class CSubTab: UIView {

    var scrollView = UIScrollView.init()
    var indicateLineLayer = CAShapeLayer.init()
    
    func commonInit() {
        addSubview(scrollView)
        layer.addSublayer(indicateLineLayer)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        // 底部分割线
        let bottomLinePath = UIBezierPath.init()
        bottomLinePath.move(to: CGPoint(x: 0, y: rect.height - 0.5))
        bottomLinePath.addLine(to: CGPoint(x: rect.width, y: rect.height - 0.5))
        UIColor.gray.setStroke()
        bottomLinePath.stroke()
        bottomLinePath.close()
    }

}
