//
//  MenuProtocols.swift
//  test
//
//  Created by Егор Шкарин on 05.01.2022.
//  
//

import Foundation

protocol MenuModuleInput {
	var moduleOutput: MenuModuleOutput? { get }
}

protocol MenuModuleOutput: AnyObject {
}

protocol MenuViewInput: AnyObject {
}

protocol MenuViewOutput: AnyObject {
    var numberOfSections: Int { get }
    var numberOfCellsInAdvSection: Int { get }
    var numberOfCellsInDishSection: Int { get }
    var advPhoto: String { get }
}

protocol MenuInteractorInput: AnyObject {
}

protocol MenuInteractorOutput: AnyObject {
}

protocol MenuRouterInput: AnyObject {
}

protocol CellProtocol {
    associatedtype AnyData
    static var reuseId: String { get }
    func configure(with data: AnyData)
}
