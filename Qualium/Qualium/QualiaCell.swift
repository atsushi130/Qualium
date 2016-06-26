//
//  QualiaCell.swift
//  Qualium
//
//  Created by ATSUSHI on 2016/06/13.
//  Copyright © 2016年 ATSUSHI. All rights reserved.
//

import Foundation
import UIKit

struct Margin {
    static let Left: CGFloat    = 5.0
    static let Right: CGFloat   = 5.0
    static let Top: CGFloat     = 0.0
    static let Bottom: CGFloat  = 0.0
    static let Between: CGFloat = 5.0
    
    static let Width: CGFloat   = Margin.Left + Margin.Right
    static let Height: CGFloat  = Margin.Top + Margin.Bottom
}

struct ImageSize {
    static let Width: CGFloat  = 300.0
    static let Height: CGFloat = 350.0
}

struct MapImageSize {
    static let Width: CGFloat  = 200.0
    static let Height: CGFloat = 70.0
}

let kIconDiameter: CGFloat     = 30.0
let kIconCornerRadius: CGFloat = 15.0

private let kCornerRadius: CGFloat = 5.0

class QualiaCell: UICollectionViewCell {
    
    let view   = UIView()
    let icon   = UIImageView()
    var qualia = Qualia()
    
    var cellSize: CGSize {
        return CGSizeMake(self.frame.width, self.view.frame.height)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setup()
    }
    
    private func setup() {
        self.backgroundColor = UIColor.clearColor()
        
        // call for each setup
        self.viewSetup()
        self.iconSetup()
    }
    
    private func viewSetup() {
        self.addSubview(self.view)
        
        self.view.layer.cornerRadius  = kCornerRadius
        self.view.layer.masksToBounds = true
    }
    
    private func iconSetup() {
        self.addSubview(self.icon)
        self.icon.layer.cornerRadius  = kIconCornerRadius
        self.icon.layer.masksToBounds = true
    }

}