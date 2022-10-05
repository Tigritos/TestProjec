//
//  CellModel.swift
//  firstProject
//
//  Created by Tigran Oganisyan on 08.09.2022.
//

import Foundation
import UIKit

struct CellModel {
    var identifier: String
    var onFill: (UITableViewCell, URL) -> ()
    var onSelect: ((UITableViewCell, PhotoDomainModel) -> ())?
}
