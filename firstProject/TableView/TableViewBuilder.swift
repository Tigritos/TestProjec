//
//  TableViewBuilder.swift
//  firstProject
//
//  Created by Tigran Oganisyan on 08.09.2022.
//

import Foundation
import UIKit

struct Configuration : UIContentConfiguration {
    let image: UIImage

    func makeContentView() -> UIView & UIContentView {
        let c = MyContentView(configuration: self)
        return c
    }
    func updated(for state: UIConfigurationState) -> Configuration {
        return self
    }
}

class MyContentView: UIView, UIContentView {
    var configuration: UIContentConfiguration {
        didSet {
            self.configure()
        }
    }
    private let imageView = UIImageView()
    init(configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
        self.configure()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configure() {
        guard let config = self.configuration as? Configuration else { return }
        self.imageView.image = config.image
    }
}


class TableViewBuilder: NSObject {
    
    weak var tableView: UITableView?
    var cellModels: [CellModel] = [] {
        didSet {
            tableView?.reloadData()
        }
    }
    
    var photoItems: [PhotoDomainModel] = []
    
    private func setupTableView() {
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.tableFooterView = UIView()
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func cellModel(indexPath: IndexPath) -> CellModel {
        return cellModels[indexPath.row]
    }
    
    init(tableView: UITableView) {
        super.init()
        self.tableView = tableView
        setupTableView()
    }
    
}

extension TableViewBuilder: UITableViewDataSource, UITableViewDelegate {

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = cellModel(indexPath: indexPath)
        let setupClosure = cellModel.onFill
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellModel.identifier),
              let url = photoItems[indexPath.row].imageURL
        else { return UITableViewCell() }
        setupClosure(cell, url)
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        let model = photoItems[indexPath.row]
        cellModel(indexPath: indexPath).onSelect?(cell, model)
        
    }
    
}
