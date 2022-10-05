//
//  ViewController.swift
//  firstProject
//
//  Created by Tigran Oganisyan on 29.08.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var presenter: PhotoViewPresenterProtocol?
    
    lazy var tableViewBuilder: TableViewBuilder? = TableViewBuilder(tableView: tableView)
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.loadData()
        self.view.backgroundColor = .white
        self.view.addSubview(tableView)
        setupLayout()
    }
    
    private func setupLayout() {
        
        let tableViewConstraints = [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(tableViewConstraints)
    }
}

extension ViewController: PhotoViewProtocol {
    func reloadData(items: [PhotoDomainModel]) {
        
        let onFill: (UITableViewCell, URL) -> Void = { (cell, url) in
            URLSession.shared.dataTask(with: url) { [weak cell] data, _ , error in
                guard
                    let data = data,
                    error == nil
                else { return }
                DispatchQueue.main.async {
                    guard let cell = cell,
                          let image = UIImage(data: data)
                    else { return }
                    cell.contentConfiguration = Configuration(image: image)
                }
            }
            .resume()
        }
        
        let onSelect: (UITableViewCell, PhotoDomainModel) -> Void = { [weak self] (cell, model) in
            self?.presenter?.cellTapped(model: model)
            
        }
        
        tableViewBuilder?.photoItems = items
        let cellModels = items.map{ _ in
            CellModel(identifier: "cell", onFill: onFill, onSelect: onSelect)
        }

        tableViewBuilder?.cellModels = cellModels
    }
}

struct Photo: Codable {
    let id: String
    let urls: URLS
    let width: Int
    let height: Int
    let likes: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case urls
        case width
        case height
        case likes
    }
}

struct URLS: Codable {
    let regular: String
    
    enum CodingKeys: String, CodingKey {
        case regular
    }
}


