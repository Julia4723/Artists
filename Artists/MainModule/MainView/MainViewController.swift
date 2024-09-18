//
//  ViewController.swift
//  Artists
//
//  Created by user on 16.09.2024.
//

import UIKit


class MainViewController: UIViewController {

    
    // MARK: - Presenter
    var presenter: MainPresenterProtocol!
   
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        
//        presenter = ModuleBuilder.createMainModule() as? MainPresenterProtocol
//           guard presenter != nil else {
//               fatalError("Presenter is nil!")
//           }
           
        
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





extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return presenter.artists?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let artist = presenter.artists?[indexPath.row]
        cell.textLabel?.text = artist?.name
        return cell
    }
}

extension MainViewController: MainViewControllerProtocol {
    func success() {
        tableView.reloadData()
    }
    
    func failure(error: any Error) {
        print(error.localizedDescription)
    }
}
