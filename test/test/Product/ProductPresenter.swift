//
//  ProductPresenter.swift
//  test
//
//  Created by Егор Шкарин on 11.01.2022.
//  
//

import Foundation

final class ProductPresenter {
	weak var view: ProductViewInput?
    weak var moduleOutput: ProductModuleOutput?
    
    private var viewModel: DishesViewModel?
    
	private let router: ProductRouterInput
	private let interactor: ProductInteractorInput
    
    init(router: ProductRouterInput, interactor: ProductInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension ProductPresenter: ProductModuleInput {
    func reciveDish(viewModel: DishesViewModel) {
        self.viewModel = viewModel
    } 
}

extension ProductPresenter: ProductViewOutput {
    func viewDidLoad() {
        view?.updateWithDish(viewModel: viewModel ?? DishesViewModel(title: "", image: nil, resource: nil, extendedIngredients: "", instructions: ""))
    }
    func back() {
        router.back()
    }
}

extension ProductPresenter: ProductInteractorOutput {
}
