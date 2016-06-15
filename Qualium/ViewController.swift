//
//  ViewController.swift
//  Qualium
//
//  Created by ATSUSHI on 2016/06/13.
//  Copyright © 2016年 ATSUSHI. All rights reserved.
//

import UIKit

let UserID = "ATUSHI_MIYAKE"

class ViewController: UIViewController {

    var qualiumView: QualiumView!
    var qualias = [Qualia]() {
        didSet {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor.redColor()
        
        self.qualiumView = QualiumView(frame: self.view.frame)
        self.qualiumView.delegate   = self
        self.qualiumView.dataSource = self
        self.view.addSubview(self.qualiumView)
        
        [Int](0...10).forEach({
            let qualia = Message(ID: (UserID, NSUUID().UUIDString))
            qualia.message = ""
            if $0 % 2 == 0 {
                qualia.ID.user = "PEER"
            }
            self.qualias.append(qualia)
        })
        
        self.qualiumView.syncQualias(self.qualias)
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            NSThread.sleepForTimeInterval(3)
            dispatch_async(dispatch_get_main_queue(), {
                let qualia = Message(ID: ("PEER", NSUUID().UUIDString))
                qualia.message = "new qualia"
                self.qualias.append(qualia)
                self.qualiumView.newQualia(qualia)
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
        let cell = qualiumView.dequeueReusableCell(indexPath: indexPath)
        
        let qualia = self.qualias[indexPath.row] as! Message
        cell.qualia = qualia
        cell.text   = qualia.message
        cell.icon.image = UIImage(named: "icon_0")
        
        return cell
    }
    
}

class Message: Qualia, QualiaMessage {
    var message: String! = ""
}
