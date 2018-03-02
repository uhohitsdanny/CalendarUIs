//
//  test_VCViewController.swift
//  PootCal
//
//  Created by Danny Navarro on 2/16/18.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit

class test_ViewController: UIViewController {
    
    @IBAction func goToCal() {
        
        let sb = UIStoryboard(name: "CAL", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "CAL_MV") as! CAL_MV
        vc.cal_sts = .display_sts
        
        //vc.preferredContentSize = CGSize(width: 343, height: 411.5)
        self.present(vc, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
}
