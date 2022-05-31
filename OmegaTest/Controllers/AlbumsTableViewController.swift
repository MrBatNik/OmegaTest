//
//  AlbumsTableViewController.swift
//  OmegaTest
//
//  Created by Nikita Batrakov on 30.05.2022.
//

import UIKit

class AlbumsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Sing Out",
            style: .plain,
            target: self,
            action: #selector(tapSingOutButton)
        )
    }
    
    @objc func tapSingOutButton() {
        navigationController?.popToRootViewController(animated: true)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "albumCell", for: indexPath)

        // Configure the cell...

        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
