//
//  MainPresenter.swift
//  Artists
//
//  Created by user on 16.09.2024.
//

import Foundation
import UIKit
import Alamofire


protocol MainViewControllerProtocol: AnyObject {
    func success()
    func failure(error: Error)
}


protocol MainPresenterProtocol: AnyObject {
    init(view: MainViewControllerProtocol, networkService: NetworkServiceProtocol)
    func getArtists()
    var artists: [Artist]? {get set}
}

class MainPresenter: MainPresenterProtocol {
    weak var view: MainViewControllerProtocol?
    let networkService: NetworkServiceProtocol!
    var artists: [Artist]?
    
    required init(view: any MainViewControllerProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
        getArtists()
    }
    
    func getArtists() {
        networkService.fetchAF { [weak self] result in
            guard let self = self else { return}
            DispatchQueue.main.async {
                switch result {
                case .success(let artists):
                    self.artists = artists
                    self.view?.success()
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
