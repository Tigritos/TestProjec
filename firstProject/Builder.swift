//
//  Builder.swift
//  firstProject
//
//  Created by Tigran Oganisyan on 05.10.2022.
//

import Foundation
import UIKit

protocol Builder {
    func createMain(router: PhotoRouterProtocol) -> UIViewController
    func createDetail(model: PhotoDomainModel) -> UIViewController
}

class ModuleBuilder: Builder {
    func createMain(router: PhotoRouterProtocol) -> UIViewController {
        let model = PhotoModel()
        let view = ViewController()
        let presenter = PhotoPresenter(view: view, model: model, router: router)
        view.presenter = presenter
        return view
    }
    func createDetail(model: PhotoDomainModel) -> UIViewController {
        let view = DetailViewController()
        let presenter = DetailPresenter(view: view, model: model)
        view.presenter = presenter
        return view
    }
}
