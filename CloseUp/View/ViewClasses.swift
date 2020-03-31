//
//  ViewClasses.swift
//  CloseUp
//
//  Created by Maksim Torburg on 02.03.2020.
//  Copyright © 2020 Maksim Torburg. All rights reserved.
//

import Foundation
import UIKit

class Background {
    
    let gradient = CAGradientLayer()
    
    init() {
        let topColor = UIColor(red: 4.0 / 255.0, green: 200.0 / 255.0, blue: 223.0 / 255.0, alpha: 1)
        let bottomColor = UIColor(red: 55 / 255.0, green: 113.0 / 255.0, blue: 209.0 / 255.0, alpha: 1)
        gradient.colors = [topColor.cgColor, bottomColor.cgColor]
    }
}
