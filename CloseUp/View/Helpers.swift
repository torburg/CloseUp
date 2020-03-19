//
//  Helpers.swift
//  CloseUp
//
//  Created by Maksim Torburg on 02.03.2020.
//  Copyright © 2020 Maksim Torburg. All rights reserved.
//

import Foundation
import  UIKit

func setBackgroubd(for sender: UIView) {
    let gradient = Background().gradient
    gradient.frame = sender.bounds
    sender.layer.insertSublayer(gradient, at: 0)

    sender.backgroundColor = .clear
    sender.backgroundColor = .clear
}
