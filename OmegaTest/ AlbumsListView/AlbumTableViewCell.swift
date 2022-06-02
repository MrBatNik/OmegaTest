//
//  AlbumTableViewCell.swift
//  OmegaTest
//
//  Created by Nikita Batrakov on 31.05.2022.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {
    
    @IBOutlet weak var albumCover: UIImageView!
    @IBOutlet weak var albumLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var songsLabel: UILabel!
    
}

extension AlbumTableViewCell {
    
    func populateCellWithData(with data: SearchResult) {
        albumCover.image = UIImage(systemName: "star.fill")
        albumLabel.text = data.collectionName
        artistLabel.text = data.artistName
        songsLabel.text = "\(data.trackCount) songs"
    }
    
}
