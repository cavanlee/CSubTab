//
//  ViewController.swift
//  CSubTab
//
//  Created by Cavan on 2018/10/19.
//  Copyright © 2018年 cavanlee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let subTab = CSubTab.init(frame: CGRect(x: 0, y: 64, width: UIScreen.main.bounds.width, height: 0))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "导航栏"
        
        navigationController?.navigationBar.setBackgroundImage(UIImage.init(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage.init()
        
        subTab.items = ["Item01", "Item02", "Item03", "Item04", "Item05"]
        subTab.sizeToFit()
        navigationController?.view.addSubview(subTab)
    }


}

