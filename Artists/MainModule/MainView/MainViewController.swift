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
    let searchController = UISearchController(searchResultsController: nil)
    
    
    private var filteredArtist = [Artist]()
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    
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
        
        //Setup search controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
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
        if isFiltering {
            return filteredArtist.count
        }
        return presenter.artists?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if cell != nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        }
        
        var artist: Artist?
        
        if isFiltering {
            artist = filteredArtist[indexPath.row]
        } else {
            artist = (presenter.artists?[indexPath.row])!
        }
        
        
        if let artist = artist {
            cell.textLabel?.text = artist.name // Set the main text (e.g., artist name)
            cell.detailTextLabel?.text = artist.bio  // Set the detail text (e.g., artist bio)
        } else {
            cell.textLabel?.text = "Unknown Artist"
            cell.detailTextLabel?.text = ""
        }
        if let imageName = artist?.image {
            cell.imageView?.image = UIImage(named: imageName)
        } else {
            cell.imageView?.image = UIImage(named: "placeholderImageName") // Fallback if no image found
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let artist: Artist
        
        if let indexPath = tableView.indexPathForSelectedRow {
            if isFiltering {
                artist = filteredArtist[indexPath.row]
                
            } else {
                artist = (presenter.artists?[indexPath.row])!
            }
            let works = artist.works
            let detailVc = ModuleBuilder.createDetailModule(artist: artist, works: works)
            navigationController?.pushViewController(detailVc, animated: true)
        }
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


extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        
        guard let artists = presenter.artists else { return }
        
        filteredArtist = artists.filter { (artist: Artist) -> Bool in
            return artist.name.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
}
