//
//  MainPresenter.swift
//  Artists
//
//  Created by user on 16.09.2024.
//

import Foundation
import UIKit


protocol MainViewControllerProtocol: AnyObject {
    
}


protocol MainPresenterProtocol: AnyObject {
    init(view: MainViewControllerProtocol)
}

class MainPresenter: MainPresenterProtocol {
    
    weak var view: MainViewControllerProtocol?
    
    required init(view: any MainViewControllerProtocol) {
        self.view = view
    }
    
    
}
