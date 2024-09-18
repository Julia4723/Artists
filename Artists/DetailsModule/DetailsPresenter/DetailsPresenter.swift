//
//  DetailsPresenter.swift
//  Artists
//
//  Created by user on 16.09.2024.
//

import UIKit


protocol DetailsViewControllerProtocol: AnyObject {
    func setArtist(artist: Artist?)
}


protocol DetailsPresenterProtocol: AnyObject {
    init(view: DetailsViewControllerProtocol, networkService: NetworkServiceProtocol, artist: Artist?)
    func setArtist()
}

class DetailsPresenter: DetailsPresenterProtocol {
    
    weak var view: DetailsViewControllerProtocol?
    let networkService: NetworkServiceProtocol!
    var artist: Artist?
    
    required init(view: any DetailsViewControllerProtocol, networkService: any NetworkServiceProtocol, artist: Artist?) {
        self.view = view
        self.networkService = networkService
        self.artist = artist
    }
    
    public func setArtist() {
        self.view?.setArtist(artist: artist)
    }
    
    
}
