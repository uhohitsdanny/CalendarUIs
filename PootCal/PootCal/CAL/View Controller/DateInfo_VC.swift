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

class DateInfo_VC: UIViewController {
    
    @IBOutlet weak var outerView: UIView?
    
    // Google Map Location Manager
    
    // Google Maps parameters
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Google Map Camera and Marker setup
        let camera = GMSCameraPosition.camera(withLatitude: <#T##CLLocationDegrees#>, longitude: <#T##CLLocationDegrees#>, zoom: <#T##Float#>)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        if touch?.view == outerView {
            self.view.removeFromSuperview()
        }
    }
}
