//
//  Helpers.swift
//  CloseUp
//
//  Created by Maksim Torburg on 02.03.2020.
//  Copyright © 2020 Maksim Torburg. All rights reserved.
//

import Foundation
import  UIKit

func setBackground(for sender: UIViewController) {
    let view = sender.view
    let gradient = Background().gradient
    gradient.frame = view?.bounds ?? CGRect()
    view?.layer.insertSublayer(gradient, at: 0)
}
