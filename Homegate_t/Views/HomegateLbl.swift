//
//  HomegateLbl.swift
//  Homegate_t
//
//  Created by Pavle Mijatovic on 11.5.21..
//

import UIKit

class HomegateLbl: UILabel {
    
    private let padding: UIEdgeInsets
    
    required init?(coder aDecoder: NSCoder) {
        padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        super.init(coder: aDecoder)
        
        backgroundColor = .red
        alpha = 0.6
    }
    
    override var intrinsicContentSize: CGSize {
        let superContentSize = super.intrinsicContentSize
        let width = superContentSize.width + padding.left + padding.right
        let height = superContentSize.height + padding.top + padding.bottom
        return CGSize(width: width, height: height)
    }
}
