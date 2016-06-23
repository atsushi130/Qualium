//
//  QualiaQuestionCell.swift
//  Qualium
//
//  Created by ATSUSHI on 2016/06/23.
//  Copyright © 2016年 ATSUSHI. All rights reserved.
//

import Foundation
import UIKit

struct QuestionViewPositon {
    static let Header = 0
    static let Left   = 1
    static let Right  = 2
}

struct QuestionViewSize {
    static let HeaderHeight: CGFloat = 30.0
    static let LeftHeight: CGFloat   = 50.0
    static let RightHeight: CGFloat  = 50.0
    
    static let QuestionViewHeight: CGFloat = QuestionViewSize.HeaderHeight + Margin.Between + QuestionViewSize.LeftHeight
}

class QualiaQuestionCell: QualiaCell {
    
    let textView = UITextView()
    let questionView = [UIView(), UIView(), UIView(), UIView()]
    
    var question: String {
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
    
    private func questionViewSetup() {
        self.questionView.forEach {
            $0.removeFromSuperview()
            self.view.addSubview($0)
        }
        
        //|Margin.Left|header|Margin.Right| = |header|Margin.Width|
        let headerRect = CGRectMake(0, 0, self.frame.size.width * 0.8 + Margin.Width, self.textView.frame.size.height + Margin.Height)
        self.questionView[QuestionViewPositon.Header].frame = headerRect
        let rect = CGRectMake(0, headerRect.size.height + Margin.Between, ((self.frame.size.width * 0.8) + Margin.Between) * 0.5, QuestionViewSize.LeftHeight)
        
        let left       = self.questionView[QuestionViewPositon.Left]
        left.frame     = CGRectMake(0, rect.origin.y, rect.size.width, rect.size.height)
        let leftButton = UIButton(frame: CGRectMake(0, 0, left.frame.size.width, left.frame.size.height))
        leftButton.tag = 0
        leftButton.titleLabel?.font = UIFont(name: Font, size: 18)!
        leftButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        leftButton.setTitle("YES", forState: UIControlState.Normal)
        leftButton.addTarget(self, action: #selector(QualiaQuestionCell.selectedAnswer(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        left.addSubview(leftButton)
        
        let right       = self.questionView[QuestionViewPositon.Right]
        right.frame     = CGRectMake(rect.size.width + Margin.Between, rect.origin.y, rect.size.width, rect.size.height)
        let rightButton = UIButton(frame: CGRectMake(0, 0, right.frame.size.width, right.frame.size.height))
        rightButton.tag = 1
        rightButton.titleLabel?.font = UIFont(name: Font, size: 18)!
        rightButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        rightButton.setTitle("NO", forState: UIControlState.Normal)
        rightButton.addTarget(self, action: #selector(QualiaQuestionCell.selectedAnswer(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        right.addSubview(rightButton)
    }
    
    @objc private func selectedAnswer(sender: UIButton) {
        if sender.tag == 0 {
            print("YES")
        } else if sender.tag == 1 {
            print("NO")
        }
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
            self.textViewSetup(self.questionView[QuestionViewPositon.Header])
            self.questionViewSetup()
            let headerRect  = self.questionView[QuestionViewPositon.Header].frame
            self.view.frame = CGRectMake(margin, 0, headerRect.size.width, headerRect.size.height + Margin.Between + QuestionViewSize.LeftHeight)
            self.view.backgroundColor = UIColor.clearColor()
            self.questionView[QuestionViewPositon.Header].backgroundColor = UIColor(red: 59/255, green: 89/255, blue: 152/255, alpha: 1.0)
            self.questionView[QuestionViewPositon.Left].backgroundColor   = UIColor.whiteColor()
            self.questionView[QuestionViewPositon.Right].backgroundColor  = UIColor.whiteColor()
            self.textView.textColor = UIColor.whiteColor()
            
        case .Peer:
            self.textViewSetup(self.questionView[QuestionViewPositon.Header])
            self.questionViewSetup()
            let width = self.questionView[QuestionViewPositon.Header].frame.size.width
            let x     = self.frame.size.width - margin - width
            self.view.frame = CGRectMake(x, 0, width, QuestionViewSize.QuestionViewHeight)
            self.view.backgroundColor = UIColor.clearColor()
            self.questionView[QuestionViewPositon.Header].backgroundColor = UIColor(red: 37/255, green: 37/255, blue: 37/255, alpha: 1.0)
            self.questionView[QuestionViewPositon.Left].backgroundColor   = UIColor.whiteColor()
            self.questionView[QuestionViewPositon.Right].backgroundColor  = UIColor.whiteColor()
            self.textView.textColor = UIColor.whiteColor()
            
        }
        
    }
    
}