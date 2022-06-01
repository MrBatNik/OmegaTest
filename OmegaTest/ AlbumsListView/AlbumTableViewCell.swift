//
//  AlbumTableViewCell.swift
//  OmegaTest
//
//  Created by Nikita Batrakov on 31.05.2022.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {
    
    @IBOutlet weak var albumCover: UIImageView!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var albumLabel: UILabel!
    @IBOutlet weak var songsLabel: UILabel!
    
}

extension AlbumTableViewCell {
    
    func populateCellWithData() {
        albumCover.image = UIImage(systemName: "star.fill")
        artistLabel.text = "Test"
        albumLabel.text = "Test Name"
        songsLabel.text = "12 songs"
    }
    
}
