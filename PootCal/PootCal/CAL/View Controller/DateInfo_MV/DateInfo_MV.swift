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

protocol DateInfoPar {
    var sts: Status { get }
    var date: String { get }
}

protocol DateInfo_API {
    func mSetup()
}

//
// The DateInfo View Controller controls the view for displaying statuses on dates
// Status: Confirmed | Pending | Unavailable
//
class DateInfo_MV: UIViewController, CLLocationManagerDelegate, DateInfoPar {
    
    // Protocol Parameters
    var dSts: Status?
    var cdate: String?
    
    var sts: Status {
        return self.dSts!
    }
    var date: String {
        return self.cdate!
    }
    // Status color
    var stsColor: UIColor?
    
    // View Objs
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var stsNotationLabel: UIView!
    @IBOutlet weak var stsLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    // Google Map Location Manager
    var location_manager = CLLocationManager()
    var current_location = CLLocation()
    
    // Google Maps parameters
    @IBOutlet weak var gmvNib: UIView!
    var gmv: GMSMapView? = nil

    override func viewWillAppear(_ animated: Bool) {
        mSetup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    //
    // Dismisses popupview when user touches the area outside the popup view
    //
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        if touch?.view == outerView {
            self.view.removeFromSuperview()
            self.location_manager.stopUpdatingLocation()
        }
    }
}

extension DateInfo_MV: DateInfo_API {
    func mSetup() {
        // DateInfo Obj
        let dateInfoObj = DateInfo_MC(sts, date)
        setupView(diObj: dateInfoObj)
        
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
}


extension DateInfo_MV {
    func setupView(diObj: DateInfo_MC) {
        self.stsLabel.text = diObj.getSts()
        self.dateLabel.text = diObj.getDate()
    }
}

