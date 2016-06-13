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

class QualiumView: UIView {
   
}