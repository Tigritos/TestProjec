//
//  PhotoRouter.swift
//  firstProject
//
//  Created by Tigran Oganisyan on 04.10.2022.
//

import Foundation
import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? {get set}
    var moduleBuilder: Builder? {get set}
}

protocol PhotoRouterProtocol: RouterMain {
    func initialViewController()
    func showDetail(model: PhotoDomainModel)
    
}

class PhotoRouter: PhotoRouterProtocol {
    
    var navigationController: UINavigationController?
    var moduleBuilder: Builder?
    
    init(navigationController: UINavigationController, moduleBuilder: Builder?) {
        self.navigationController = navigationController
        self.moduleBuilder = moduleBuilder
    }
    
    func initialViewController() {
        if let navigationController = navigationController {
            guard let mainViewController = moduleBuilder?.createMain(router: self) else {return}
            navigationController.viewControllers = [mainViewController]
        }
    }
    
    func showDetail(model: PhotoDomainModel) {
        if let navigationController = navigationController {
            guard let detailViewController = moduleBuilder?.createDetail(model: model) else {return}
            navigationController.pushViewController(detailViewController, animated: true)
                    
        }
    }
}
