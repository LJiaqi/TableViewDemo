//
//  JQDemoSectionFooterItem.swift
//  MVCDemo
//
//  Created by lijiaqi on 2017/11/12.
//  Copyright © 2017年 lijiaqi. All rights reserved.
//

import UIKit

class JQDemoSectionFooterItem: JQTableListSectionItem {
    var title: String?
    
    override func viewType() -> JQTableSectionView.Type {
        return JQSectionFooterView.self
    }
}
