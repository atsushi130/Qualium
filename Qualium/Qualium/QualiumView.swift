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
}

protocol QualiumViewDataSource {
    func numberOfSectionInQualiumView(qualiumView: QualiumView) -> Int
    func qualiumView(qualiumView: QualiumView, numberOfQualiasInSection section: Int) -> Int
    func qualiumView(qualiumView: QualiumView, cellForQualiaAtIndexPath indexPath: NSIndexPath) -> QualiaCell
}

private let kMinimumLineSpacing: CGFloat        = 15.0
private let kMinimumInterQualiaSpacing: CGFloat = 15.0

internal let CellIdentifier = "QualiaCell"

class QualiumView: UIView {
    
    private var collectionView: UICollectionView!
    private var layout    = UICollectionViewFlowLayout()
    var qualias   = [Qualia]()
    private var cellSizes = [CGSize]()
    var delegate: QualiumViewDelegate!     = nil
    var dataSource: QualiumViewDataSource! = nil
    
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
    }
    
    private func collectionViewSetup() {
        self.collectionView = UICollectionView(frame: self.frame, collectionViewLayout: self.layout)
        self.collectionView.delegate   = self
        self.collectionView.dataSource = self
        self.collectionView.backgroundColor = UIColor.clearColor()
        self.collectionView.registerNib(UINib(nibName: CellIdentifier, bundle: nil), forCellWithReuseIdentifier: CellIdentifier)
        self.addSubview(self.collectionView)
    }
    
    private func collectionViewFlowLayoutSetup() {
        self.layout.minimumLineSpacing      = kMinimumLineSpacing
        self.layout.minimumInteritemSpacing = kMinimumInterQualiaSpacing
    }
    
    func newQualia(qualia: Qualia) {
        self.qualias.append(qualia)
        self.reloadData {
            // implement function call in time of completed reloadData
        }
    }
    
    func reloadData(completionHandler: (() -> Void)?) {
        self.collectionView.reloadData {
            completionHandler?()
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
        dummyTextView.font = UIFont(name: "HelveticaNeue-Thin", size: 20.0)
        dummyTextView.text = (self.qualias[indexPath.row] as! Message).message
        dummyTextView.attributedText = NSAttributedString(string: (self.qualias[indexPath.row] as! Message).message)
        let size = dummyTextView.sizeThatFits(CGSize(width: self.frame.size.width, height: CGFloat.infinity))

        return CGSizeMake(self.frame.width, size.height + Margin.Height)
    }
}

private extension UICollectionView {
    func reloadData(complateHandler completionHandler: (() -> Void)?) {
        self.reloadData()
        completionHandler?()
    }
}