//
//  DetailsViewController.swift
//  Artists
//
//  Created by user on 16.09.2024.
//

import UIKit
import Kingfisher

class DetailsViewController: UIViewController {
    
    
    // MARK: - Presenter
    var presenter: DetailsPresenterProtocol!
    
    // MARK: - Properties
    var artist: Artist?
    
    private lazy var labelTitle: UILabel = {
        $0.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        $0.textColor = .black
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
        return $0
    }(UILabel())
    
    private lazy var labelDescription: UILabel = {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.textColor = .darkGray
        $0.numberOfLines = 0
        $0.lineBreakMode = .byTruncatingTail
        return $0
    }(UILabel())
    
    private lazy var imageView: UIImageView = {
        $0.layer.cornerRadius = 12
        return $0
    }(UIImageView())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        presenter.setArtist()
        setupView()
    }
}


//MARK: - Settings View
private extension DetailsViewController {
    func setupView() {
        addSubView()
        setupLayout()
    }
}

//MARK: - Setting
private extension DetailsViewController {
    func setupLayout() {
        [labelTitle, labelDescription, imageView].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func addSubView() {
        [labelTitle, labelDescription, imageView].forEach { subView in
            view.addSubview(subView)
        }
        
        NSLayoutConstraint.activate([
            labelTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            labelTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            labelTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            
            imageView.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            labelDescription.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            labelDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            labelDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
            
        ])
    }
}


extension DetailsViewController: DetailsViewControllerProtocol {
    func setArtist(artist: Artist?) {
        labelTitle.text = artist?.name
        labelDescription.text = artist?.bio
        
        if let image = UIImage(named: artist?.image ?? "") {
                imageView.image = image
            } else {
                imageView.image = UIImage(named: "placeholderImageName") // Default image if not found
            }
        
        //        if let imageUrl = URL(string: artist?.image ?? ""){
        //            let processor = DownsamplingImageProcessor(size: imageView.bounds.size)
        //            imageView.kf.indicatorType = .activity
        //            imageView.kf.setImage(
        //                with: imageUrl,
        //                options: [
        //                    .processor(processor),
        //                    .scaleFactor(UIScreen.main.scale),
        //                    .transition(.fade(1)),
        //                    .cacheOriginalImage
        //                ]
        //            ) { result in
        //                switch result {
        //                case .success:
        //                    break
        //                case .failure:
        //                    self.imageView.image = UIImage(named: "placeholderImageName")
        //                }
        //            }
        //        } else {
        //            imageView.image = UIImage(named: "placeholderImageName")
        //        }
        //    }
    }
}



