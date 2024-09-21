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
    var works: [Work]?
    
    private lazy var labelTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24)
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(tableView)
       
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}


extension DetailsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return presenter.works?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let data = presenter.works else {
            fatalError("Application error no cell data available")
        }
       
        let cellData = presenter.works?[indexPath.row]
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = cellData?.title
        cell.detailTextLabel?.text = cellData?.info
        
        if let imageName = cellData?.image {
            cell.imageView?.image = UIImage(named: imageName)
        } else {
            cell.imageView?.image = UIImage(named: "placeholderImageName")
        }
        
        return cell
    }
}



extension DetailsViewController: DetailsViewControllerProtocol {
    
    
    func success() {
        tableView.reloadData()
    }
    
    func failure(error: any Error) {
        print(error.localizedDescription)
    }
    
}


