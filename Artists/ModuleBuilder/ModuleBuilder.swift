//
//  ModuleBuilder.swift
//  Artists
//
//  Created by user on 16.09.2024.
//

import UIKit

protocol Builder {
    static func createMainModule() -> UIViewController
    static func createDetailModule(artist: Artist?, works: [Work]?) -> UIViewController
}

class ModuleBuilder: Builder {
    
    static func createMainModule() -> UIViewController {
        let view = MainViewController()
        let networkService = NetworkService()
        let presenter = MainPresenter(view: view, networkService: networkService)
        view.presenter = presenter
        return view
    }
    
    static func createDetailModule(artist: Artist?, works: [Work]?) -> UIViewController {
        let view = DetailsViewController()
        let networkService = NetworkService()
        let presenter = DetailsPresenter(view: view, networkService: networkService, artist: artist, works: works)
        view.presenter = presenter
        return view
    }
}
