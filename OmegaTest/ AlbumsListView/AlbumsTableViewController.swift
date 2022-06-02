//
//  AlbumsTableViewController.swift
//  OmegaTest
//
//  Created by Nikita Batrakov on 30.05.2022.
//

import UIKit

class AlbumsTableViewController: UITableViewController {
    
    private let viewModel = AlbumsTableViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Sing Out",
            style: .plain,
            target: self,
            action: #selector(tapSingOutButton)
        )
        viewModel.formSearchURL("Maroon")
        viewModel.fetchData(from: viewModel.url ?? "") { [unowned self] albums in
            self.viewModel.albums = albums
            self.tableView.reloadData()
        }
    }
    
    @objc func tapSingOutButton() {
        navigationController?.popToRootViewController(animated: true)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.albums?.results.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "albumCell", for: indexPath) as! AlbumTableViewCell
        guard let data = viewModel.albums?.results[indexPath.row] else { return cell }
        
        cell.populateCellWithData(with: data)
        
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

}

extension AlbumsTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
}
