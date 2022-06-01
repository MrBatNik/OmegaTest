//
//  AlbumInformationViewController.swift
//  OmegaTest
//
//  Created by Nikita Batrakov on 30.05.2022.
//

import UIKit

class AlbumInformationViewController: UIViewController {
    
    @IBOutlet weak var albumCoverImage: UIImageView!
    @IBOutlet weak var labelsStackView: UIStackView!
    @IBOutlet weak var tracksList: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension AlbumInformationViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "trackCell", for: indexPath)
        
        return cell
    }
    
}

extension AlbumInformationViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension AlbumInformationViewController {
    
}
