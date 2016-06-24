//
//  QualiaLocationCell.swift
//  Qualium
//
//  Created by ATSUSHI on 2016/06/23.
//  Copyright © 2016年 ATSUSHI. All rights reserved.
//

import Foundation
import MapKit
import UIKit

private let kCornerRadius: CGFloat = 25.0

class QualiaLocationCell: QualiaCell {
    
    // Width = Height
    var mapImageView = UIImageView(frame: CGRectMake(Margin.Left, Margin.Left, MapImageSize.Height, MapImageSize.Height))
    
    var latitude: Double  = 0.0
    var longitude: Double = 0.0
    var coordinate: CLLocationCoordinate2D {
        get {
            return CLLocationCoordinate2DMake(self.latitude, self.longitude)
        }
        set {
            self.latitude  = newValue.latitude
            self.longitude = newValue.longitude
            self.sizeFit()
        }
    }
    
    private func mapImageViewSetup() {
        self.mapImageView.removeFromSuperview()
        self.view.addSubview(self.mapImageView)
        self.mapImageView.layer.cornerRadius = kCornerRadius
        self.mapImageView.layer.masksToBounds = true
        self.mapImageView.contentMode        = UIViewContentMode.ScaleAspectFit
        self.mapImageView.image = UIImage(named: "mapImageView")
        //self.mapSnapshot()
    }
    
    func mapSnapshot() {
        
        let center     = CLLocationCoordinate2D(latitude: self.coordinate.latitude, longitude: self.coordinate.longitude)
        let span       = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let options    = MKMapSnapshotOptions()
        options.region = MKCoordinateRegion(center: center, span: span)
        options.scale  = UIScreen.mainScreen().scale
        options.size   = CGSize(width: MapImageSize.Width, height: MapImageSize.Height)
        
        MKMapSnapshotter(options: options).startWithCompletionHandler({ snapshot, error in
            if let snapshot = snapshot {
                self.mapImageView.image = snapshot.image
            }
        })
        
    }
    
    func sizeFit() {
        
        //icon
        switch self.qualia.vector(UserID) {
        case .Me:   self.icon.frame = CGRectMake(Margin.Left, 0, kIconDiameter, kIconDiameter)
        case .Peer: self.icon.frame = CGRectMake(self.frame.size.width - Margin.Right - kIconDiameter, 0, kIconDiameter, kIconDiameter)
        }
        
        //view
        let margin = self.icon.frame.size.width + Margin.Width
        switch self.qualia.vector(UserID) {
        case .Me:
            self.mapImageViewSetup()
            self.view.frame = CGRectMake(margin, 0, self.mapImageView.frame.size.width + Margin.Width, self.mapImageView.frame.size.height + Margin.Width)
            self.view.layer.cornerRadius = kCornerRadius + Margin.Width/2
            self.view.backgroundColor    = UIColor(red: 59/255, green: 89/255, blue: 152/255, alpha: 1.0)
            
        case .Peer:
            self.mapImageViewSetup()
            let width       = MapImageSize.Width
            let x           = self.frame.size.width - margin - width
            self.view.frame = CGRectMake(x, 0, MapImageSize.Width, MapImageSize.Height + Margin.Width)
            self.view.layer.cornerRadius   = kCornerRadius + Margin.Width/2
            self.view.backgroundColor      = UIColor(red: 37/255, green: 37/255, blue: 37/255, alpha: 1.0)
            
        }
        
    }
    
}