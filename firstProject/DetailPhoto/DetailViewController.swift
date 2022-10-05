//
//  DetailViewController.swift
//  firstProject
//
//  Created by Tigran Oganisyan on 05.10.2022.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    var presenter: DetailPhotoViewPresenterProtocol?
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var widthLabel: UILabel = {
        let label = UILabel()
        label.font = label.font?.withSize(12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var heightLabel: UILabel = {
        let label = UILabel()
        label.font = label.font?.withSize(12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var likesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = label.font?.withSize(15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detail Information"
        view.backgroundColor = .white
        presenter?.setModel()
        addSubviews()
        setupLayout()
    }
    
    func addSubviews() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(widthLabel)
        stackView.addArrangedSubview(heightLabel)
        stackView.addArrangedSubview(likesLabel)
    }
    func setupLayout() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.heightAnchor.constraint(equalToConstant: view.frame.height - 100),
            stackView.widthAnchor.constraint(equalToConstant: view.frame.width - 40),
        ])
        
    }
}

extension DetailViewController: DetailPhotoViewProtocol {
    func updateModel(model: PhotoDomainModel) {
        widthLabel.text = "Width: \(model.width)"
        heightLabel.text = "Height: \(model.height)"
        likesLabel.text = "Likes: \(model.likes)"
        
        guard let url = model.imageURL else { return }
        URLSession.shared.dataTask(with: url) {  data, _ , error in
            guard
                let data = data,
                error == nil
            else { return }
            DispatchQueue.main.async { [weak self] in
                guard let image = UIImage(data: data) else { return }
                self?.imageView.image = image
            }
        }
        .resume()
        
    }
    
    
}
