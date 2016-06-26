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

private let kCornerRadius: CGFloat = 5.0

class QualiaLocationCell: QualiaCell {
    
    // Width = Height
    var mapImageView        = UIImageView(frame: CGRectMake(Margin.Left, Margin.Left, MapImageSize.Width, MapImageSize.Height))
    var annotationImageView = UIImageView(frame: CGRectMake(10, -17.5, 37, 35))
    var tappedLocationCellHandler: (() -> Void)?
    let gestureRecognizer = UITapGestureRecognizer()
    
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
        self.mapImageView.removeGestureRecognizer(self.gestureRecognizer)
        self.mapImageView.layer.cornerRadius  = kCornerRadius
        self.mapImageView.layer.masksToBounds = true
        self.mapImageView.clipsToBounds       = false
        self.mapImageView.image               = UIImage(named: "map2")
        self.gestureRecognizer.addTarget(self, action: #selector(QualiaLocationCell.tapped(_:)))
        self.view.addSubview(self.mapImageView)
        self.annotationImageViewSetup()
    }
    
    private func annotationImageViewSetup() {
        self.annotationImageView.removeFromSuperview()
        self.mapImageView.addSubview(self.annotationImageView)
        self.annotationImageView.image = UIImage(named: "annotation")
    }
    
    @objc private func tapped(sender: UIGestureRecognizer) {
        self.tappedLocationCellHandler?()
    }
    
    func sizeFit() {
        
        //icon
        switch self.qualia.vector(UserID) {
        case .Me:   self.icon.frame = CGRectMake(Margin.Left, 0, kIconDiameter, kIconDiameter)
        case .Peer: self.icon.frame = CGRectMake(self.frame.size.width - Margin.Right - kIconDiameter, 0, kIconDiameter, kIconDiameter)
        }
        
        self.clipsToBounds      = false
        self.view.clipsToBounds = false
        
        //view
        let margin = self.icon.frame.size.width + Margin.Width
        switch self.qualia.vector(UserID) {
        case .Me:
            self.mapImageViewSetup()
            self.view.frame = CGRectMake(margin, 0, MapImageSize.Width + Margin.Width, self.mapImageView.frame.size.height + Margin.Width)
            self.view.layer.cornerRadius = kCornerRadius
            self.view.backgroundColor    = UIColor(red: 59/255, green: 89/255, blue: 152/255, alpha: 1.0)
            
        case .Peer:
            self.mapImageViewSetup()
            let width       = MapImageSize.Width + Margin.Width
            let x           = self.frame.size.width - margin - width
            self.view.frame = CGRectMake(x, 0, width, MapImageSize.Height + Margin.Width)
            self.view.layer.cornerRadius   = kCornerRadius
            self.view.backgroundColor      = UIColor(red: 37/255, green: 37/255, blue: 37/255, alpha: 1.0)
            
        }
        
    }
    
}