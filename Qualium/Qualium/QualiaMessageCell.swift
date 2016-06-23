//
//  QualiaMessageCell.swift
//  Qualium
//
//  Created by ATSUSHI on 2016/06/23.
//  Copyright © 2016年 ATSUSHI. All rights reserved.
//

import Foundation
import UIKit

class QualiaMessageCell: QualiaCell {
    
    let textView = UITextView()
    
    var text: String {
        get {
            return self.textView.text
        }
        set {
            self.textView.text = newValue
            self.sizeFit()
        }
    }
    
    private func textViewSetup(view: UIView) {
        self.textView.removeFromSuperview()
        self.textView.frame = CGRectMake(Margin.Left, Margin.Top, 0, 0)
        view.addSubview(self.textView)
        
        self.textView.scrollEnabled                = false
        self.textView.editable                     = false
        self.textView.showsVerticalScrollIndicator = false
        self.textView.backgroundColor              = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.0)
        self.textView.contentInset                 = UIEdgeInsetsMake(-2.25, 0, 0, 0) // fource narrow the top margin
        
        self.textView.font       = UIFont(name: "HelveticaNeue-Thin", size: 15.0)
        self.textView.frame.size = self.textView.sizeThatFits(CGSize(width: self.frame.size.width * 0.8, height: CGFloat.infinity))
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
            self.textViewSetup(self.view)
            // margin = |-icon-view
            self.view.frame  = CGRectMake(margin, 0, self.textView.frame.size.width + Margin.Width, self.textView.frame.size.height + Margin.Height)
            self.view.backgroundColor = UIColor(red: 59/255, green: 89/255, blue: 152/255, alpha: 1.0)
            self.textView.textColor   = UIColor.whiteColor()
            
        case .Peer:
            self.textViewSetup(self.view)
            let width = self.textView.frame.size.width + Margin.Width // equal view size width
            let x     = self.frame.size.width - margin - width  // view-icon-|
            self.view.frame  = CGRectMake(x, 0, width, self.textView.frame.size.height + Margin.Height)
            self.view.backgroundColor = UIColor(red: 37/255, green: 37/255, blue: 37/255, alpha: 1.0)
            self.textView.textColor   = UIColor.whiteColor()
                        
        }
        
    }
    
}