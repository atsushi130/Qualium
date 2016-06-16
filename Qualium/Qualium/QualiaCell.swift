//
//  QualiaCell.swift
//  Qualium
//
//  Created by ATSUSHI on 2016/06/13.
//  Copyright © 2016年 ATSUSHI. All rights reserved.
//

import Foundation
import UIKit

private struct Margin {
    static let Left: CGFloat   = 5.0
    static let Right: CGFloat  = 5.0
    static let Top: CGFloat    = 0.0
    static let Bottom: CGFloat = 0.0
    
    static let Width: CGFloat  = Margin.Left + Margin.Right
    static let Height: CGFloat = Margin.Top + Margin.Bottom
}

private let kIconDiameter: CGFloat     = 30.0
private let kIconCornerRadius: CGFloat = 15.0

private let kCornerRadius: CGFloat = 5.0

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
        self.textView.backgroundColor              = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.0)
        self.textView.contentInset                 = UIEdgeInsetsMake(-2.25, 0, 0, 0) // fource narrow the top margin
    }
    
    private func iconSetup() {
        self.addSubview(self.icon)
        self.icon.layer.cornerRadius  = kIconCornerRadius
        self.icon.layer.masksToBounds = true
    }

    private func sizeFit() {
        
        //icon
        switch self.qualia.vector(UserID) {
        case .Me:   self.icon.frame = CGRectMake(Margin.Left, 0, kIconDiameter, kIconDiameter)
        case .Peer: self.icon.frame = CGRectMake(self.frame.size.width - Margin.Right - kIconDiameter, 0, kIconDiameter, kIconDiameter)
        }

        self.textView.font       = UIFont(name: "HelveticaNeue-Thin", size: 15.0)
        self.textView.frame.size = self.textView.sizeThatFits(CGSize(width: self.frame.size.width * 0.8, height: CGFloat.infinity))
        
        //view
        let margin = self.icon.frame.size.width + Margin.Width
        switch self.qualia.vector(UserID) {
        case .Me:
            // margin = |-icon-view
            self.view.frame  = CGRectMake(margin, 0, self.textView.frame.size.width + Margin.Width, self.textView.frame.size.height + Margin.Height)
            self.view.backgroundColor = UIColor(red: 59/255, green: 89/255, blue: 152/255, alpha: 1.0)
            self.textView.textColor   = UIColor.whiteColor()
            
        case .Peer:
            let width = self.textView.frame.size.width + Margin.Width // equal view size width
            let x     = self.frame.size.width - margin - width  // view-icon-|
            self.view.frame  = CGRectMake(x, 0, width, self.textView.frame.size.height + Margin.Height)
            self.view.backgroundColor = UIColor(red: 37/255, green: 37/255, blue: 37/255, alpha: 1.0)
            self.textView.textColor   = UIColor.whiteColor()
        }
        
    }
    
}