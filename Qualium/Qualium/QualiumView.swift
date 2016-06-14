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
class QualiumView: UIView {
    
    private var collectionView: UICollectionView!
    private var layout  = UICollectionViewFlowLayout()
    private var qualias = [Qualia]()
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
        return self.dataSource.qualiumView(self, cellForQualiaAtIndexPath: indexPath)
    }
    
}

private extension UICollectionView {
    func reloadData(complateHandler completionHandler: (() -> Void)?) {
        self.reloadData()
        completionHandler?()
    }
}