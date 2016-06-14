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

private let kIconDiameter: CGFloat = 20.0
private let kCornerRadius: CGFloat = 10.0

class QualiaCell: UICollectionViewCell {
    
    private let textView = UITextView()
    private let view     = UIView()
    let icon             = UIImageView()
    var qualia           = Qualia()
    
    var text: String {
        get {
            return self.text
        }
        set {
            self.text = newValue
            self.textView.text = self.text
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
        self.viewSetup()
        self.textViewSetup()
        self.iconSetup()
    }
    
    private func viewSetup() {
        self.addSubview(self.view)
    }
    
    private func textViewSetup() {
        self.textView.frame = CGRectMake(Margin.Left, Margin.Top, 0, 0)
        self.view.addSubview(self.textView)
    }
    
    private func iconSetup() {
        self.icon.layer.cornerRadius  = kCornerRadius
        self.icon.layer.masksToBounds = true
        self.addSubview(self.icon)
    }

    private func sizeFit() {
        
        //icon
        switch self.qualia.vector {
        case .Me:   self.icon.frame = CGRectMake(Margin.Left, 0, kIconDiameter, kIconDiameter)
        case .Peer: self.icon.frame = CGRectMake(self.frame.size.width - Margin.Right - kIconDiameter, 0, kIconDiameter, kIconDiameter)
        }
        
        //textView
        let dummyTextView  = UITextView()
        dummyTextView.font = self.textView.font
        dummyTextView.text = self.textView.text
        let maxSize        = CGSizeMake(200, 10000000)
        
        // textView in maxSize
        let size = (dummyTextView.text as NSString).boundingRectWithSize(maxSize,
                                                                         options: NSStringDrawingOptions.UsesLineFragmentOrigin,
                                                                         attributes: [NSFontAttributeName: self.textView.font!],
                                                                         context: NSStringDrawingContext())
        
        let origin = self.textView.frame.origin
        self.textView.frame = CGRectMake(origin.x, origin.y, size.width, size.height)
        
        //view
        let margin = self.icon.frame.size.width + Margin.Width
        switch self.qualia.vector {
        case .Me:
            let width = size.width + Margin.Width // equal view size width
            let x     = self.frame.size.width - margin - width  // view-icon-|
            self.view.frame           = CGRectMake(x, 0, width, size.height + Margin.Height)
            self.view.backgroundColor = UIColor.blackColor()
            
        case .Peer:
            // margin = |-icon-view
            self.view.frame           = CGRectMake(margin, 0, size.width + Margin.Width, size.height + Margin.Height)
            self.view.backgroundColor = UIColor.whiteColor()
        }
        
    }
    
}