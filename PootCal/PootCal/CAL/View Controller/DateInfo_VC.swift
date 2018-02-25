//
//  Date_Info_VC.swift
//  PootCal
//
//  Created by Danny Navarro on 2/21/18.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class DateInfo_VC: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var outerView: UIView?
    
    // Google Map Location Manager
    var location_manager = CLLocationManager()
    var current_location = CLLocation()
    
    // Google Maps parameters
    @IBOutlet weak var gmvNib: UIView!
    var gmv: GMSMapView? = nil

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Google Map Camera and Marker setup
        location_manager.delegate = self
        location_manager.startUpdatingLocation()
        let camera = GMSCameraPosition.camera(withLatitude: current_location.coordinate.latitude, longitude: current_location.coordinate.longitude, zoom: 7.0)
        gmv = GMSMapView.map(withFrame: gmvNib!.bounds, camera: camera)
        //self.gmv!.delegate = self
        
        // Google Map Camera
        gmv!.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        gmv!.mapType = GMSMapViewType.normal
        gmv!.settings.myLocationButton = true
        gmv!.isMyLocationEnabled = true
        
        gmvNib!.addSubview(gmv!)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        if touch?.view == outerView {
            self.view.removeFromSuperview()
            self.location_manager.stopUpdatingLocation()
        }
    }
}

