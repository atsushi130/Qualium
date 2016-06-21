//
//  Operator.swift
//  Qualium
//
//  Created by ATSUSHI on 2016/06/16.
//  Copyright © 2016年 ATSUSHI. All rights reserved.
//

import Foundation

infix operator |-| {}

func |-|(right: Double, left: Double) -> Double {
    let result = right - left
    return result < 0 ? -result : result
}