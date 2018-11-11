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
    
    var itemWidth: CGFloat = UIScreen.main.bounds.width / 5
    let indicateLineHeight: CGFloat = 2.0
    let indicateWidthRate: CGFloat = 0.4 // 相对于Item width 的比例
    
    var selectedBtn = UIButton.init(type: .custom)
    
    var items: [String] = [] {
        didSet {
            
            if items.count > 0 {
                itemWidth = items.count > 4 ? itemWidth : UIScreen.main.bounds.width / CGFloat(items.count)
                scrollView.contentSize = CGSize(width: itemWidth * CGFloat(items.count), height: scrollView.frame.height)
                for i in 0..<items.count {
                    let itemBtn = UIButton.init(type: .custom)
                    itemBtn.setTitle(items[i], for: .normal)
                    itemBtn.setTitleColor(UIColor.init(red: 192.0 / 255.0, green: 192.0 / 255.0, blue: 192.0 / 255.0, alpha: 1), for: .normal)
                    itemBtn.setTitleColor(UIColor.red, for: .selected)
                    itemBtn.isSelected = i==0
                    itemBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
                    itemBtn.frame = CGRect(x: CGFloat(i) * itemWidth, y: 0, width: itemWidth, height: frame.height - indicateLineHeight)
                    itemBtn.addTarget(self, action: #selector(itemBtnAction(sender:)), for: .touchUpInside)
                    scrollView.addSubview(itemBtn)
                
                    if i == 0 {
                        selectedBtn = itemBtn
                    }
                }

                
            }
            
        }
    }
    
    private func commonInit() {
        backgroundColor = UIColor.white
        
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        addSubview(scrollView)
        
        indicateLineLayer.backgroundColor = UIColor.red.cgColor
        scrollView.layer.addSublayer(indicateLineLayer)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    override var frame: CGRect {
        didSet {
            super.frame = CGRect(x: 0, y: isIPhoneX() ? 88 : 64, width: frame.width, height: 36)
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        scrollView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height - 0.5)
        indicateLineLayer.frame = CGRect(x: 0, y: scrollView.frame.height - indicateLineHeight, width: itemWidth * indicateWidthRate, height: indicateLineHeight)
        indicateLineLayer.position.x = itemWidth * 0.5

    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var fitSize = super.sizeThatFits(size)
        fitSize.height = 36.0
        return fitSize
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
        UIColor.init(red: 245.0 / 255.0, green: 245.0 / 255.0, blue: 245.0 / 255.0, alpha: 1).setStroke()
        bottomLinePath.stroke()
        bottomLinePath.close()
    }
    
    func isIPhoneX() -> Bool {
        return UIScreen.main.bounds.height == 812.0
    }
    
    @objc func itemBtnAction(sender: UIButton) {
        
        var offset = sender.center.x - frame.size.width * 0.5
        let offset_max = scrollView.contentSize.width - frame.size.width
        
        if offset < 0 {
            offset = 0
        }
        if (offset > offset_max){
            offset = offset_max
        }
        
        scrollView.setContentOffset(CGPoint(x: offset, y: 0), animated: true)
        
        selectedBtn.isSelected = false
        let toSmallAnim = CABasicAnimation.init(keyPath: "transform.scale")
        toSmallAnim.fromValue = 1.2
        toSmallAnim.toValue = 1.0
        toSmallAnim.isRemovedOnCompletion = false
        toSmallAnim.repeatCount = 1
        toSmallAnim.autoreverses = false
        toSmallAnim.duration = 0.3
        toSmallAnim.fillMode = .forwards
        selectedBtn.titleLabel?.layer.add(toSmallAnim, forKey: "toSmallAnim")
        
        sender.isSelected = !sender.isSelected
        let toBigAnim = CABasicAnimation.init(keyPath: "transform.scale")
        toBigAnim.fromValue = 1
        toBigAnim.toValue = 1.2
        toBigAnim.isRemovedOnCompletion = false
        toBigAnim.repeatCount = 1
        toBigAnim.autoreverses = false
        toBigAnim.duration = 0.3
        toBigAnim.fillMode = .forwards
        sender.titleLabel?.layer.add(toBigAnim, forKey: "toBigAnim")
        
        indicateLineLayer.position.x = sender.center.x
        

        
        selectedBtn = sender
    }
    

}
