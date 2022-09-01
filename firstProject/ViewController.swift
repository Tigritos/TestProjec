//
//  ViewController.swift
//  firstProject
//
//  Created by Tigran Oganisyan on 29.08.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Nice!"
        label.font = label.font.withSize(32)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(label)
        setupLayout()
    }

    private func setupLayout() {
        let labelConstraints = [
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
        NSLayoutConstraint.activate(labelConstraints)
    }

}

