//
//  NightMode.swift
//  Bubble
//
//  Created by Andrey Maslennikov on 6/5/18.
//  Copyright © 2018 Andrey Maslennikov. All rights reserved.
//

import UIKit

let nightMode = ""

enum NightMode : Int{
    case Light, Night
    
    var mainColour: UIColor {
        switch self {
        case .Light:
            return UIColor(red: 87.0/255.0, green: 188.0/255.0, blue: 95.0/255.0, alpha: 1.0)
        case .Night:
            return UIColor(red: 242.0/255.0, green: 101.0/255.0, blue: 34.0/255.0, alpha: 1.0)
        }
    }
}

struct NightSwitch {
    func currentMode() -> NightMode {
        if let mode = UserDefaults.standard.value(forKey: nightMode) {
            return NightMode(rawValue: mode as! Int)!
        } else {
            return .Light
        }
    }
}
