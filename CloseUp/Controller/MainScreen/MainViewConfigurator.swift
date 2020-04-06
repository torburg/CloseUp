//
//  MainViewConfigurator.swift
//  CloseUp
//
//  Created by Maksim Torburg on 05.04.2020.
//  Copyright © 2020 Maksim Torburg. All rights reserved.
//

import Foundation

protocol MainViewConfigurator {
    func configure(viewController: MainViewController)
}

class MainViewConfiguratorImplementation: MainViewConfigurator {
    func configure(viewController: MainViewController) {
        let dataManager = CoreDataManager.instance
        let presenter = MainViewPresenterImplementation(view: viewController, dataManager: dataManager)
        viewController.presenter = presenter
    }
}
