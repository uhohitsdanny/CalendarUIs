//
//  UIColors+Custom.swift
//  PootCal
//
//  Created by User on 1/31/18.
//  Copyright © 2018 User. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    struct PrimaryPootColor {
        // hex: 0x73D8EA
        static var OceanMist: UIColor {
            return UIColor(rgb: 0x73D8EA, a: 1.0)
        }
    }
    
    struct NotificationColors {
        // hex: 0xFFF652
        static var pending: UIColor {
            return UIColor(rgb: 0xFFF652, a: 1.0)
        }
        // hex: 0xFF630D
        static var unavailable: UIColor {
            return UIColor(rgb: 0xFF630D, a: 1.0)
        }
    }
}


