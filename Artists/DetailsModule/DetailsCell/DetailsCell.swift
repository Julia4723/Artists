//
//  DetailsCell.swift
//  Artists
//
//  Created by user on 20.09.2024.
//

import UIKit
import Kingfisher

class DetailsCell: UICollectionViewCell {
    
    static let reusedId = "Details Cell"
    var completion: (() -> Void)?
    
    
    lazy var cellImage: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        [cellImage].forEach { view in
            addSubview(view)
        }
        
        layer.cornerRadius = 20
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(works: Work?) {
        
        if let imageName = works?.image {
            cellImage.image = UIImage(named: imageName)
        } else {
            cellImage.image = UIImage(named: "placeholderImageName") // Fallback if no image found
        }
    }
}
