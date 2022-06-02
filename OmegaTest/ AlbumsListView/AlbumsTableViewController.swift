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
        
        setupNavigationItem()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.albums?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "albumCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        guard let data = viewModel.albums?[indexPath.row] else { return cell }
        
        content.image = UIImage(data: viewModel.fetchImageData(from: data.artworkUrl60 ?? ""))
        content.text = data.collectionName
        content.secondaryText = "\(data.artistName) - \(data.trackCount) songs"
        cell.contentConfiguration = content
        
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let viewController = segue.destination as? AlbumInformationViewController else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        guard let album = viewModel.albums?[indexPath.row] else { return }
        
        viewController.viewModel.album = album
    }
    
    private func setupNavigationItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Sing Out",
            style: .plain,
            target: self,
            action: #selector(tapSingOutButton)
        )
    }
    
    @objc private func tapSingOutButton() {
        navigationController?.popToRootViewController(animated: true)
    }

}

extension AlbumsTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let text = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        guard let text = text else { return }
        
        if !text.isEmpty {
            viewModel.formSearchURL(text)
            viewModel.fetchData(from: viewModel.url ?? "") { [unowned self] albums in
                self.viewModel.albums = albums.results.sorted { $0.collectionName < $1.collectionName }
                self.tableView.reloadData()
            }
        }
    }
    
}
