//
//  Date_Info_VC.swift
//  PootCal
//
//  Created by Danny Navarro on 2/21/18.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit

class DateInfo_VC: UIViewController {
    
    @IBOutlet weak var outerView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view = popupView!
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        if touch?.view == outerView {
            self.view.removeFromSuperview()
        }
    }
}
