//
//  MenuPresenter.swift
//  test
//
//  Created by Егор Шкарин on 05.01.2022.
//  
//

import Foundation

final class MenuPresenter {
	weak var view: MenuViewInput?
    weak var moduleOutput: MenuModuleOutput?
    
	private let router: MenuRouterInput
	private let interactor: MenuInteractorInput
    private var numberOfDishCells: Int?
    
    init(router: MenuRouterInput, interactor: MenuInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension MenuPresenter: MenuModuleInput {
}

extension MenuPresenter: MenuViewOutput {
    
    var advPhoto: String {
        return "photo2"
    }
    
    var numberOfCellsInAdvSection: Int {
        return 5
    }
    
   var numberOfCellsInDishSection: Int {
        return numberOfDishCells ?? 0
    }
    
    var numberOfSections: Int {
        return 2
    }
    
    func viewDidLoad() {
        interactor.loadData()
    }
    
}

extension MenuPresenter: MenuInteractorOutput {
    func didLoadData(dishes: [Dish]) {
        let viewModels = makeViewModels(dishes: dishes)
        numberOfDishCells = viewModels.count
        view?.updateViewWithDishes(dishes: viewModels)
    }
  
}

private extension MenuPresenter {
    func makeViewModels(dishes: [Dish]) -> [DishesViewModel] {
        return dishes.map { dish in
            let nameOfDish = dish.title.capitalized
            let imageUrl = URL(string: dish.image)
            let ingredients = dish.extendedIngredients.joined(separator: ", ")
            let resource = KingFisherManager.setupResourceForCache(url: imageUrl)
            return DishesViewModel(title: nameOfDish, image: imageUrl, resource: resource, extendedIngredients: ingredients)
        }
    }
}
