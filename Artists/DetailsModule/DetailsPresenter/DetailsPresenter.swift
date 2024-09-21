//
//  DetailsPresenter.swift
//  Artists
//
//  Created by user on 16.09.2024.
//

import UIKit


protocol DetailsViewControllerProtocol: AnyObject {
    func success()
    func failure(error: Error)
}


protocol DetailsPresenterProtocol: AnyObject {
    init(view: DetailsViewControllerProtocol, networkService: NetworkServiceProtocol, artist: Artist?, works: [Work]?)
    func didSelectArtist(_ artist: Artist, works: [Work])
    var works: [Work]? {get set}
    var artist: Artist? {get set}
    func setImg()
    
}

class DetailsPresenter: DetailsPresenterProtocol {
    func didSelectArtist(_ artist: Artist, works: [Work]) {
        self.artist = artist
        self.works = works
    }
   
    weak var view: DetailsViewControllerProtocol?
    let networkService: NetworkServiceProtocol!
    var artist: Artist?
   
    var works2: Work?
    var works: [Work]?
    
    
    required init(view: any DetailsViewControllerProtocol, networkService: NetworkServiceProtocol, artist: Artist?, works: [Work]?) {
        self.view = view
        self.networkService = networkService
        self.artist = artist
        self.works = works

        setImg()
        
    }
    
    public func setImg() {
        networkService.fetchWork { [weak self] result in
            guard let self = self else { return}
            DispatchQueue.main.async {
                switch result {
                case .success(let works):
                    self.works = works
                    self.view?.success()
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
}


