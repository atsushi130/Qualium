//
//  ViewController.swift
//  Qualium
//
//  Created by ATSUSHI on 2016/06/13.
//  Copyright © 2016年 ATSUSHI. All rights reserved.
//

import UIKit

let UserID = "ATUSHI_MIYAKE"
let TestTexts = ["The Dance of Eternity\nMetropolis part 2", "Bridges In the Sky\nA Dramatic Turn Of Events", "Constant Motion\nSystematic Chaos", "Panic Attack\nOctavarium", "Octavarium", "Metropolis\nImages and Words", "Illmination Theory\nDream Theater", "Enigma Machine", "Hell's Kitchin\nFalling Into Infinity", "The Count of Tascany\nBlack Clouds & Silver Linings", "Cought In a Web\nAwake", "Moment Of Betrayal\nThe Astonshing", "Stream Of Consciousness", "Endless Sacrifice", "New Millennium", "Overture 1928", "Strange Deja vu"]

let NavigationBarHeight: CGFloat = 64.0

struct CellIdentifier {
    static let Message  = "QualiaMessageCell"
    static let Image    = "QualiaImageCell"
    static let Question = "QualiaQuestionCell"
    static let Location = "QualiaLocationCell"
    static let Movie    = "QualiaMovieCell"
}

class ViewController: UIViewController {

    var qualiumView: QualiumView!
    var qualias = [Qualia]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 37/255, green: 37/255, blue: 37/255, alpha: 1.0)
        self.navigationController?.navigationBar.translucent  = false
        
        self.qualiumView = QualiumView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height - NavigationBarHeight))
        self.qualiumView.delegate   = self
        self.qualiumView.dataSource = self
        self.view.addSubview(self.qualiumView)
        
        [Int](0...TestTexts.count-1).forEach({
            let qualia = Message(ID: (UserID, NSUUID().UUIDString))
            qualia.message = TestTexts[$0]
            if $0 % 2 == 0 {
                qualia.ID.user = "PEER"
            }
            self.qualias.append(qualia)
        })
        
        self.qualiumView.syncQualias(self.qualias)
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            NSThread.sleepForTimeInterval(1)
            dispatch_async(dispatch_get_main_queue(), {

                 /*
                let image = Image(ID: ("PEER", NSUUID().UUIDString))
                image.image = UIImage(named: "icon_0")!
                image.type = .Image
                self.qualias.append(image)
                self.qualiumView.newQualia(image)
                */
                let question = Question(ID: (UserID, NSUUID().UUIDString))//Message(ID: ("PEER", NSUUID().UUIDString))
                question.question = "Did you resolve this trouble ?"
                question.type = .Question
                self.qualias.append(question)
                self.qualiumView.newQualia(question)
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                    NSThread.sleepForTimeInterval(1)
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        let image = Image(ID: ("PEER", NSUUID().UUIDString))
                        image.image = UIImage(named: "icon_0")!
                        image.type = .Image
                        self.qualias.append(image)
                        self.qualiumView.newQualia(image)
                     
                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                            NSThread.sleepForTimeInterval(1)
                            dispatch_async(dispatch_get_main_queue(), {
                                
                                let qualia = Message(ID: (UserID, NSUUID().UUIDString))
                                qualia.message = "I'm looking for Tokyo Station"
                                self.qualias.append(qualia)
                                self.qualiumView.newQualia(qualia)
                            })
                        })
                    })
                })
            })
        })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: QualiumViewDelegate {
    
    func qualiumView(qualiumView: QualiumView, didSelectQualiaAtIndexPath indexPath: NSIndexPath) {
    }
    
    func qualiumView(willSendQualia qualia: Qualia) {
        // will send
        self.qualias.append(qualia)
        self.qualiumView.newQualia(qualia)
    }
}

extension ViewController: QualiumViewDataSource {
    
    func numberOfSectionInQualiumView(qualiumView: QualiumView) -> Int {
        return 1
    }
    
    func qualiumView(qualiumView: QualiumView, numberOfQualiasInSection section: Int) -> Int {
        return self.qualias.count
    }
    
    func qualiumView(qualiumView: QualiumView, cellForQualiaAtIndexPath indexPath: NSIndexPath) -> QualiaCell {
        
        let qualia = self.qualias[indexPath.row]
        
        switch qualia.type {
        case .Message:
            let cell        = qualiumView.dequeueReusableCellWithReuseIdentifier(CellIdentifier.Message, indexPath: indexPath) as! QualiaMessageCell
            cell.qualia     = qualia
            cell.icon.image = UIImage(named: "icon_0")
            cell.text       = (qualia as! Message).message
            return cell
            
        case .Image:
            let cell        = qualiumView.dequeueReusableCellWithReuseIdentifier(CellIdentifier.Image, indexPath: indexPath) as! QualiaImageCell
            cell.qualia     = qualia
            cell.icon.image = UIImage(named: "icon_0")
            cell.image      = (qualia as! Image).image
            return cell
            
        case .Question:
            let cell        = qualiumView.dequeueReusableCellWithReuseIdentifier(CellIdentifier.Question, indexPath: indexPath) as! QualiaQuestionCell
            cell.qualia     = qualia
            cell.icon.image = UIImage(named: "icon_0")
            cell.question   = (qualia as! Question).question
            return cell
            
        case .Movie: break
            
        }
        
        return QualiaCell()
    }
    
}

class Message: Qualia, QualiaMessage {
    var message: String! = ""
}

class Image: Qualia, QualiaImage {
    var image: UIImage = UIImage()
}

class Question: Qualia, QualiaQuestion {
    var question: String = ""
}
