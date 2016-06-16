//
//  File.swift
//  Qualium
//
//  Created by ATSUSHI on 2016/06/13.
//  Copyright © 2016年 ATSUSHI. All rights reserved.
//

import Foundation
import UIKit

protocol QualiumViewDelegate {
    func qualiumView(qualiumView: QualiumView, didSelectQualiaAtIndexPath indexPath: NSIndexPath)
    func qualiumView(willSendQualia qualia: Qualia)
}

protocol QualiumViewDataSource {
    func numberOfSectionInQualiumView(qualiumView: QualiumView) -> Int
    func qualiumView(qualiumView: QualiumView, numberOfQualiasInSection section: Int) -> Int
    func qualiumView(qualiumView: QualiumView, cellForQualiaAtIndexPath indexPath: NSIndexPath) -> QualiaCell
}

private let kMinimumLineSpacing: CGFloat        = 0.0
private let kMinimumInterQualiaSpacing: CGFloat = 0.0

private let kBarViewHeight: CGFloat    = 50.0
private let kTextViewHeight: CGFloat   = 35.0

private let kCornerRadius: CGFloat = 5.0

private let Font = "HelveticaNeue-Thin"

private struct kSendButton {
    static let Width: CGFloat  = 30.0
    static let Height: CGFloat = kTextViewHeight - 15
}

private struct Margin {
    static let Left: CGFloat   = 5.0
    static let Right: CGFloat  = 5.0
    static let Top: CGFloat    = 7.5
    static let Bottom: CGFloat = 7.5
    
    static let Width: CGFloat  = Margin.Left + Margin.Right
    static let Height: CGFloat = Margin.Top + Margin.Bottom
}

internal let CellIdentifier = "QualiaCell"

class QualiumView: UIView {
    
    private var collectionView: UICollectionView!
    private var barView: UIView!
    private var textView: UITextView!
    private var sendButton: UIButton!
    private var gestureRecognizer = UITapGestureRecognizer()
    
    private var layout    = UICollectionViewFlowLayout()
    private var qualias   = [Qualia]()
    private var cellSizes = [CGSize]()
    private var collectionViewRect          = CGRectZero
    var delegate: QualiumViewDelegate!      = nil
    var dataSource: QualiumViewDataSource!  = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    private func setup() {
        self.collectionViewFlowLayoutSetup()
        self.collectionViewSetup()
        self.barViewSetup()
        self.textViewSetup()
        self.sendButtonSetup()
        self.observerSetup()
        self.gestureRecognizerSetup()
    }
    
    private func collectionViewSetup() {
        let rect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - kBarViewHeight)
        self.collectionView = UICollectionView(frame: rect, collectionViewLayout: self.layout)
        self.collectionView.delegate   = self
        self.collectionView.dataSource = self
        self.collectionViewRect        = self.collectionView.frame
        self.collectionView.backgroundColor = UIColor.clearColor()
        self.collectionView.registerNib(UINib(nibName: CellIdentifier, bundle: nil), forCellWithReuseIdentifier: CellIdentifier)
        self.addSubview(self.collectionView)
    }
    
    private func collectionViewFlowLayoutSetup() {
        self.layout.minimumLineSpacing      = kMinimumLineSpacing        // section - item margin
        self.layout.minimumInteritemSpacing = kMinimumInterQualiaSpacing // item - item margin
        self.layout.sectionInset            = UIEdgeInsetsMake(20, 0, 10, 0) // top, left, bottom, right
    }
    
    private func barViewSetup() {
        self.barView = UIView(frame: CGRectMake(0, self.frame.size.height - kBarViewHeight, self.frame.size.width, kBarViewHeight))
        self.barView.backgroundColor = UIColor(red: 37/255, green: 37/255, blue: 37/255, alpha: 1.0)
        self.addSubview(self.barView)
    }
    
    private func textViewSetup() {
        let width     = self.barView.frame.size.width - kSendButton.Width - Margin.Width - Margin.Left
        self.textView = UITextView(frame: CGRectMake(Margin.Left, Margin.Top, width, kTextViewHeight))
        self.textView.layer.cornerRadius  = kCornerRadius
        self.textView.layer.masksToBounds = true
        self.textView.font = UIFont(name: Font, size: 18)
        self.barView.addSubview(self.textView)
    }
    
    private func sendButtonSetup() {
        let x           = Margin.Left + self.textView.frame.size.width + Margin.Left
        self.sendButton = UIButton(frame: CGRectMake(x, Margin.Top + 8.25, kSendButton.Width, kSendButton.Height))
        self.sendButton.backgroundColor = UIColor.clearColor()
        self.sendButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        self.sendButton.addTarget(self, action: #selector(QualiumView.qualiaSend(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.sendButton.setImage(UIImage(named: "airplane"), forState: UIControlState.Normal)
        self.barView.addSubview(self.sendButton)
    }
    
    private func observerSetup() {
        let notification = NSNotificationCenter.defaultCenter()
        notification.addObserver(self, selector: #selector(QualiumView.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        notification.addObserver(self, selector: #selector(QualiumView.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    private func gestureRecognizerSetup() {
        self.gestureRecognizer.addTarget(self, action: #selector(QualiumView.tappedWithKeyboardWillHide(_:)))
    }
    
    @objc private func qualiaSend(sender: UIButton) {
        if self.checkText() {
            self.animateAirPlane()
            let qualia     = Message(ID: (UserID, ""))
            qualia.message = self.textView.text
            self.textView.text = ""
            self.delegate.qualiumView(willSendQualia: qualia)
        }
    }
    
    private func animateAirPlane() {
        self.sendButton.userInteractionEnabled = false
        UIView.animateWithDuration(0.5, animations: {
            self.sendButton.transform = CGAffineTransformTranslate(self.sendButton.transform, -3, 2)
            }, completion: { (finished: Bool) -> Void in
                UIView.animateWithDuration(0.2, animations: {
                    self.sendButton.transform = CGAffineTransformTranslate(self.sendButton.transform, 300, -200)
                    }, completion: { (finished: Bool) -> Void in
                        self.sendButton.transform = CGAffineTransformIdentity
                        self.sendButton.transform = CGAffineTransformScale(self.sendButton.transform, 0.1, 0.1)
                        self.sendButton.alpha     = 0.0
                        UIView.animateWithDuration(0.5, delay: 0.75, usingSpringWithDamping: 0.75, initialSpringVelocity: 10,
                            options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                                self.sendButton.transform = CGAffineTransformIdentity
                                self.sendButton.alpha     = 1.0
                            }, completion: { (finished: Bool) -> Void in
                                self.sendButton.userInteractionEnabled = true
                        })
                })
        })
    }
    
    private func checkText() -> Bool {
        return self.textView.text != "" ? true : false
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        let userInfo = notification.userInfo!
        let keyboardRect = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey]!.doubleValue
        self.barView.transform = CGAffineTransformIdentity
        self.collectionView.frame = self.collectionViewRect
        self.collectionView.addGestureRecognizer(self.gestureRecognizer)
        
        UIView.animateWithDuration(duration, animations: {
            self.barView.transform = CGAffineTransformTranslate(self.barView.transform, 0, -keyboardRect.height)
        
            if (Double(self.collectionView.contentSize.height) |-| Double(self.collectionView.frame.height + self.collectionView.contentOffset.y)) <= 100 {
                self.collectionView.setContentOffset(CGPointMake(0, self.collectionView.contentOffset.y + keyboardRect.height), animated: false)
            }
            
            }, completion: { (finished: Bool) -> Void in
                let rect = self.collectionView.frame
                self.collectionView.frame = CGRectMake(rect.origin.x, rect.origin.y, rect.width, self.collectionView.frame.height - keyboardRect.height)
        })
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        let duration = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey]!.doubleValue
        self.collectionView.frame = self.collectionViewRect
        
        UIView.animateWithDuration(duration, animations: {
            self.barView.transform = CGAffineTransformIdentity
            }, completion: {(finished: Bool) -> Void in
                self.collectionView.removeGestureRecognizer(self.gestureRecognizer)
        })
    }
    
    @objc private func tappedWithKeyboardWillHide(sender: UIGestureRecognizer) {
        self.textView.resignFirstResponder()
    }
    
}

extension QualiumView {
    
    func syncQualias(qualias: [Qualia]) {
        self.qualias = qualias
    }
    
    func newQualia(qualia: Qualia) {
        self.qualias.append(qualia)
        self.reloadData {
            // implement function call in time of completed reloadData
            self.collectionViewScrollToBottomAnimated(animated: true)
        }
    }
    
    func reloadData(completionHandler: (() -> Void)?) {
        self.collectionView.reloadData {
            completionHandler?()
        }
    }
    
    private func collectionViewScrollToBottomAnimated(animated animated: Bool) {
        let count = self.dataSource.qualiumView(self, numberOfQualiasInSection: 0)
        if count > 0 {
            self.collectionView.scrollToItemAtIndexPath(NSIndexPath(forRow: count - 1, inSection: 0), atScrollPosition: .Bottom, animated: animated)
        }
    }
    
    func dequeueReusableCell(indexPath indexPath: NSIndexPath) -> QualiaCell {
        return self.collectionView.dequeueReusableCellWithReuseIdentifier(CellIdentifier, forIndexPath: indexPath) as! QualiaCell
    }
    
}

extension QualiumView: UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.delegate.qualiumView(self, didSelectQualiaAtIndexPath: indexPath)
    }
    
}

extension QualiumView: UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return self.dataSource.numberOfSectionInQualiumView(self)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.qualiumView(self, numberOfQualiasInSection: section)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = self.dataSource.qualiumView(self, cellForQualiaAtIndexPath: indexPath)
        self.cellSizes.append(cell.cellSize)
        return cell
    }
    
}

extension QualiumView: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let dummyTextView  = UITextView()
        dummyTextView.font = UIFont(name: Font, size: 15.0)
        dummyTextView.text = (self.qualias[indexPath.row] as! Message).message
        let size = dummyTextView.sizeThatFits(CGSize(width: self.frame.size.width * 0.8, height: CGFloat.infinity))

        return CGSizeMake(self.frame.width, size.height + Margin.Height)
    }
}

extension QualiumView: UITextFieldDelegate {
    
}

private extension UICollectionView {
    func reloadData(complateHandler completionHandler: (() -> Void)?) {
        self.reloadData()
        completionHandler?()
    }
}