//
//  PhotoPresenter.swift
//  firstProject
//
//  Created by Tigran Oganisyan on 03.10.2022.
//

import Foundation
import UIKit

protocol PhotoViewProtocol: AnyObject {
    func reloadData(items: [PhotoDomainModel])
}

protocol PhotoViewPresenterProtocol: AnyObject {
    init(view: PhotoViewProtocol, model: PhotoModel, router: PhotoRouterProtocol)
    func loadData()
    func cellTapped(model: PhotoDomainModel)
}

class PhotoPresenter: PhotoViewPresenterProtocol {
    
    let view: PhotoViewProtocol
    let model: PhotoModel
    let router: PhotoRouterProtocol
    
    required init(view: PhotoViewProtocol, model: PhotoModel, router: PhotoRouterProtocol) {
        self.view = view
        self.model = model
        self.router = router
    }
    
    func cellTapped(model: PhotoDomainModel) {
        router.showDetail(model: model)
    }
    
    func loadData() {
        model.fetch() { [weak self] (result: Result<[Photo], Error>) in
            switch result {
            case .success(let model):
                let items = model.map {
                    PhotoDomainModel(
                        id: $0.id,
                        imageURL: URL(string: $0.urls.regular),
                        width: $0.width,
                        height: $0.height,
                        likes: $0.likes
                    )
                }
                self?.view.reloadData(items: items)
            case .failure(let error):
                print(error)
            }
        }
    }
}
