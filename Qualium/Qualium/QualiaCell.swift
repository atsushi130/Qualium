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
    
    static let Width  = Margin.Left + Margin.Right
    static let HeightMargin = Margin.Top + Margin.Bottom
}

class QualiaCell: UICollectionViewCell {
    
    @IBOutlet private var textView: UITextView!
    
    var qualia = Qualia()
    
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
        return self.frame.size
    }

    private func sizeFit() {
        let dummyTextView  = UITextView()
        dummyTextView.font = self.textView.font
        dummyTextView.text = self.textView.text
        let size   = dummyTextView.sizeThatFits(textView.frame.size)
        let origin = self.textView.frame.origin
        self.textView.frame = CGRectMake(origin.x, origin.y, size.width, size.height)
    }
    
}