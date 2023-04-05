//
//  ProfileViewController.swift
//  MainScreenDeliveryApp
//
//  Created by Артем Манасян on 05.04.2023.
//

import UIKit

class ProfileViewController: UIViewController {

    let label = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        view.backgroundColor = .white
        label.text = "No items in this section yet"
        label.textColor = .black
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        label.pin.hCenter().top(100).sizeToFit()
    }
}
