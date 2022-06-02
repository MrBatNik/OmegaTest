//
//  AlbumInformationViewController.swift
//  OmegaTest
//
//  Created by Nikita Batrakov on 30.05.2022.
//

import UIKit

class AlbumInformationViewController: UIViewController {
    
    @IBOutlet weak var albumCoverImage: UIImageView!
    @IBOutlet weak var albumLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var albumYearLabel: UILabel!
    
    @IBOutlet weak var tracksList: UITableView!
    
    let viewModel = AlbumInformationViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupImageView()
        setupLabelsText()
        viewModel.formSongsURL()
        viewModel.fetchData(from: viewModel.url ?? "") { [unowned self] songs in
            self.viewModel.songs = songs.results
            self.tracksList.reloadData()
        }
    }

}

extension AlbumInformationViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.songs?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "trackCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        guard let data = viewModel.songs?[indexPath.row] else { return cell }
        
        content.text = data.trackName
        cell.contentConfiguration = content
        
        return cell
    }
    
}

extension AlbumInformationViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension AlbumInformationViewController {
    
    private func setupImageView() {
        albumCoverImage.image = UIImage(
            data: viewModel.fetchImageData(
                from: viewModel.album?.artworkUrl100 ?? ""
            )
        )
    }
    
    private func setupLabelsText() {
        albumLabel.text = viewModel.album?.collectionName
        artistLabel.text = viewModel.album?.artistName
        albumYearLabel.text = viewModel.getDateFromText(
            viewModel.album?.releaseDate ?? ""
        )
    }
    
}
