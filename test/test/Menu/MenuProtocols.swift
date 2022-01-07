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
    func updateViewWithDishes(dishes: [DishesViewModel])
}

protocol MenuViewOutput: AnyObject {
    var numberOfSections: Int { get }
    var numberOfCellsInAdvSection: Int { get }
    var numberOfCellsInDishSection: Int { get }
    var advPhoto: String { get }
    func viewDidLoad()
}

protocol MenuInteractorInput: AnyObject {
    func loadData()
}

protocol MenuInteractorOutput: AnyObject {
    func didLoadData(dishes: [Dish])
}

protocol MenuRouterInput: AnyObject {
}

