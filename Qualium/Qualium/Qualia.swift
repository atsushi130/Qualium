//
//  Qualia.swift
//  Qualium
//
//  Created by ATSUSHI on 2016/06/13.
//  Copyright © 2016年 ATSUSHI. All rights reserved.
//

import Foundation
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
}

protocol QualiaObject {
    var vector: QualiaVactor { get set }
    var type: QualiaTypes { get set }
    var ID: String! { get set }
    init(vector: QualiaVactor, ID: String)
}

protocol QualiaMessage: QualiaObject {
    var message: String! { get set }
}

extension QualiaMessage {
    var type: QualiaTypes {
        get { return .Message }
        set {}
    }
}

protocol QualiaMovie: QualiaObject {
    var movie: NSData { get set }
}

extension QualiaMovie {
    var type: QualiaTypes {
        get { return .Movie }
        set {}
    }
}

protocol QualiaImage: QualiaObject {
    var image: UIImage { get set }
}

extension QualiaImage {
    var type: QualiaTypes {
        get { return .Image }
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
    var choices: [Choice] { get set }
}

extension QualiaQuestion {
    var type: QualiaTypes {
        get { return .Question }
        set {}
    }
}

class Qualia: NSObject, QualiaObject {
    
    var vector: QualiaVactor = .Me
    var ID: String!          = ""
    var type: QualiaTypes = .Message
    
    override init() {
        super.init()
    }
    
    required init(vector: QualiaVactor, ID: String) {
        super.init()
        self.vector = vector
        self.ID     = ID
    }
    
}
