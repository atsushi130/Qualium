 //
//  Qualia.swift
//  Qualium
//
//  Created by ATSUSHI on 2016/06/13.
//  Copyright © 2016年 ATSUSHI. All rights reserved.
//

import Foundation
import MapKit
import UIKit

enum QualiaVactor {
    case Me
    case Peer
}

enum QualiaTypes {
    case Message
    case Movie
    case Question
    case Image
    case Location
}

protocol QualiaObject {
    var type: QualiaTypes { get set }
    var ID: (user: String!, qualia: String!) { get set }
    init(ID: (user: String!, qualia: String!))
    func vector(ID: String) -> QualiaVactor
}

extension QualiaObject {
    final func vector(ID: String) -> QualiaVactor {
        return ID == self.ID.user ? .Peer : .Me
    }
}

protocol QualiaMessage: QualiaObject {
    var message: String! { get set }
}
 
extension QualiaMessage {
    var type: QualiaTypes {
        return .Message
    }
}

protocol QualiaMovie: QualiaObject {
    var movie: NSData { get set }
}
 
extension QualiaMovie {
    var type: QualiaTypes {
        return .Movie
    }
}

protocol QualiaImage: QualiaObject {
    var image: UIImage { get set }
}
 
extension QualiaImage {
    var type: QualiaTypes {
        return .Image
    }
}

class Choice: NSObject {
    private var vote = 0
    var question     = ""
    
    var count: Int {
        return self.vote
    }
    
    func bet() {
        self.vote += 1
    }
}

protocol QualiaQuestion: QualiaObject {
    var question: String { get set }
}
 
extension QualiaQuestion {
    var type: QualiaTypes {
        return .Question
    }
}
 
protocol QualiaLocation: QualiaObject {
    var coordinate: CLLocationCoordinate2D { get set }
}
 
extension QualiaLocation {
    var type: QualiaTypes {
        return .Location
    }
}

class Qualia: NSObject, QualiaObject {
    
    var ID: (user: String!, qualia: String!) = ("", "")
    var type: QualiaTypes = .Message
    
    override init() {
        super.init()
    }
    
    required init(ID: (user: String!, qualia: String!)) {
        super.init()
        self.ID = ID
    }
    
}
