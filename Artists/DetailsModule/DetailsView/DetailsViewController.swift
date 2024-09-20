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
    var works: Work?
    
    private lazy var labelTitle: UILabel = {
        let label = UILabel()
        label.text = artist?.name
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
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}


extension DetailsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.works?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if let work = presenter.works?[indexPath.row] {
                   cell.textLabel?.text = work.title
                   cell.detailTextLabel?.text = work.info
            if let imageName = work.image {
                       cell.imageView?.image = UIImage(named: imageName)
                   } else {
                       cell.imageView?.image = UIImage(named: "placeholderImageName")
                   }
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


