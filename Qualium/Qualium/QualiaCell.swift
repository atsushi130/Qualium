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
    static let Left: CGFloat   = 10.0
    static let Right: CGFloat  = 10.0
    static let Top: CGFloat    = 5.0
    static let Bottom: CGFloat = 5.0
    
    static let Width: CGFloat  = Margin.Left + Margin.Right
    static let Height: CGFloat = Margin.Top + Margin.Bottom
}

private let kIconDiameter: CGFloat     = 20.0
private let kIconCornerRadius: CGFloat = 10.0

private let kCornerRadius: CGFloat = 10.0

class QualiaCell: UICollectionViewCell {
    
    private let textView = UITextView()
    private let view     = UIVisualEffectView()
    let icon             = UIImageView()
    var qualia           = Qualia()
    
    var text: String {
        get {
            return self.text
        }
        set {
            self.textView.text = newValue
            self.sizeFit()
        }
    }
    
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
        self.textViewSetup()
        self.iconSetup()
    }
    
    private func viewSetup() {
        self.addSubview(self.view)
        
        self.view.layer.cornerRadius  = kCornerRadius
        self.view.layer.masksToBounds = true
    }
    
    private func textViewSetup() {
        self.textView.frame = CGRectMake(Margin.Left, Margin.Top, 0, 0)
        self.view.addSubview(self.textView)
        
        self.textView.scrollEnabled                = false
        self.textView.editable                     = false
        self.textView.showsVerticalScrollIndicator = false
        self.textView.contentInset                 = UIEdgeInsetsMake(-2.5, 0, 0, 0) // fource narrow the top margin
        self.textView.backgroundColor              = UIColor.clearColor()
    }
    
    private func iconSetup() {
        self.addSubview(self.icon)
        self.icon.layer.cornerRadius  = kIconCornerRadius
        self.icon.layer.masksToBounds = true
    }

    private func sizeFit() {
        
        //icon
        switch self.qualia.vector {
        case .Me:   self.icon.frame = CGRectMake(Margin.Left, 0, kIconDiameter, kIconDiameter)
        case .Peer: self.icon.frame = CGRectMake(self.frame.size.width - Margin.Right - kIconDiameter, 0, kIconDiameter, kIconDiameter)
        }

        self.textView.font       = UIFont(name: "HelveticaNeue-Thin", size: 15.0)
        self.textView.frame.size = self.textView.sizeThatFits(CGSize(width: self.frame.size.width * 0.8, height: CGFloat.infinity))
        
        //view
        let margin = self.icon.frame.size.width + Margin.Width
        switch self.qualia.vector {
        case .Me:
            let width = self.textView.frame.size.width + Margin.Width // equal view size width
            let x     = self.frame.size.width - margin - width  // view-icon-|
            self.view.frame  = CGRectMake(x, 0, width, self.textView.frame.size.height + Margin.Height)
            self.view.effect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
            
        case .Peer:
            // margin = |-icon-view
            self.view.frame  = CGRectMake(margin, 0, self.textView.frame.size.width + Margin.Width, self.textView.frame.size.height + Margin.Height)
            self.view.effect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        }
        
    }
    
}