//
//  TableViewSectionModel.swift
//  firstProject
//
//  Created by Tigran Oganisyan on 08.09.2022.
//

import Foundation
import UIKit

struct TableViewSectionModel {
    var cellsModel: [CellModel]
    
    init(cellsModel: [CellModel]) {
        self.cellsModel = cellsModel
    }
}
