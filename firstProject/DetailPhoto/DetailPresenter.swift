//
//  DetailPresenter.swift
//  firstProject
//
//  Created by Tigran Oganisyan on 05.10.2022.
//

import Foundation

protocol DetailPhotoViewProtocol: AnyObject {
    func updateModel(model: PhotoDomainModel)
}

protocol DetailPhotoViewPresenterProtocol: AnyObject {
    init(view: DetailPhotoViewProtocol, model: PhotoDomainModel)
    func setModel()

}

class DetailPresenter: DetailPhotoViewPresenterProtocol {
    
    weak var view: DetailPhotoViewProtocol?
    let model: PhotoDomainModel
    
    required init(view: DetailPhotoViewProtocol, model: PhotoDomainModel) {
        self.view = view
        self.model = model
    }
    
    func setModel() {
        self.view?.updateModel(model: model)
    }
    
}
