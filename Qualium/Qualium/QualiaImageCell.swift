//
//  QualiaImageCell.swift
//  Qualium
//
//  Created by ATSUSHI on 2016/06/23.
//  Copyright © 2016年 ATSUSHI. All rights reserved.
//

import Foundation
import UIKit

private let kCornerRadius: CGFloat = 5.0

class QualiaImageCell: QualiaCell {
    
    let imageView = UIImageView(frame: CGRectMake(0, 0, ImageSize.Width, ImageSize.Height))
    
    var image: UIImage {
        get {
            return self.imageView.image!
        }
        set {
            self.imageView.image = newValue
            self.sizeFit()
        }
    }
    
    private func imageViewSetup() {
        self.imageView.removeFromSuperview()
        self.view.addSubview(self.imageView)
        self.imageView.layer.cornerRadius = kCornerRadius
    }

    func sizeFit() {
        
        //icon
        switch self.qualia.vector(UserID) {
        case .Me:   self.icon.frame = CGRectMake(Margin.Left, 0, kIconDiameter, kIconDiameter)
        case .Peer: self.icon.frame = CGRectMake(self.frame.size.width - Margin.Right - kIconDiameter, 0, kIconDiameter, kIconDiameter)
        }
        
        //view
        let margin = self.icon.frame.size.width + Margin.Width
        switch self.qualia.vector(UserID) {
        case .Me:
            self.imageViewSetup()
            self.view.frame = CGRectMake(margin, 0, self.imageView.frame.size.width, self.imageView.frame.size.height)
            self.view.backgroundColor = UIColor.clearColor()
        
        case .Peer:
            self.imageViewSetup()
            let width = self.imageView.frame.size.width
            let x     = self.frame.size.width - margin - width
            self.view.frame = CGRectMake(x, 0, width, self.imageView.frame.size.height)
            self.view.backgroundColor = UIColor.clearColor()
            
        }
        
    }
    
}