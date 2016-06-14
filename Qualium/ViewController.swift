//
//  ViewController.swift
//  Qualium
//
//  Created by ATSUSHI on 2016/06/13.
//  Copyright © 2016年 ATSUSHI. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var qualiumView: QualiumView!
    var qualias = [Qualia]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.qualiumView = QualiumView(frame: self.view.frame)
        self.qualiumView.delegate   = self
        self.qualiumView.dataSource = self
        self.view.addSubview(self.qualiumView)
        
        [Int](0...5).forEach({
            let qualia = Message(vector: .Me, ID: "")
            qualia.message = "こんにちは、関数型言語！！ Mr.\($0) SwiftもScalaを最高だぜ！こんにちは、関数型言語！！ Mr.\($0) SwiftもScalaを最高だぜ！こんにちは、関数型言語！！ Mr.\($0) SwiftもScalaを最高だぜ！こんにちは、関数型言語！！ Mr.\($0) SwiftもScalaを最高だぜ！こんにちは、関数型言語！！ Mr.\($0) SwiftもScalaを最高だぜ！こんにちは、関数型言語！！ Mr.\($0) SwiftもScalaを最高だぜ！こんにちは、関数型言語！！ Mr.\($0) SwiftもScalaを最高だぜ！こんにちは、関数型言語！！ Mr.\($0) SwiftもScalaを最高だぜ！こんにちは、関数型言語！！ Mr.\($0) SwiftもScalaを最高だぜ！こんにちは、関数型言語！！ Mr.\($0) SwiftもScalaを最高だぜ！こんにちは、関数型言語！！ Mr.\($0) SwiftもScalaを最高だぜ！"
            if $0 % 2 == 0 {
                qualia.vector = .Peer
            }
            self.qualias.append(qualia)
        })
        
        self.qualiumView.qualias = self.qualias
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: QualiumViewDelegate {
    func qualiumView(qualiumView: QualiumView, didSelectQualiaAtIndexPath indexPath: NSIndexPath) {
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
        
        return cell
    }
    
}

class Message: Qualia, QualiaMessage {
    var message: String! = ""
}
