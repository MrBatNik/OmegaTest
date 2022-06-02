//
//  UserInfoViewController.swift
//  OmegaTest
//
//  Created by Nikita Batrakov on 31.05.2022.
//

import UIKit

class UserInfoViewController: UIViewController {
    
    @IBOutlet weak var userInfoLabel: UILabel!
    
    private let viewModel = UserInformationViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLabelText()
    }

    @IBAction func topeDoneButton() {
        dismiss(animated: true)
    }
    
    private func setupLabelText() {
        userInfoLabel.text = viewModel.retrieveUser()
    }
    
}
