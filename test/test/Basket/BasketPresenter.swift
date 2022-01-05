//
//  BasketPresenter.swift
//  test
//
//  Created by Егор Шкарин on 05.01.2022.
//  
//

import Foundation

final class BasketPresenter {
	weak var view: BasketViewInput?
    weak var moduleOutput: BasketModuleOutput?
    
	private let router: BasketRouterInput
	private let interactor: BasketInteractorInput
    
    init(router: BasketRouterInput, interactor: BasketInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension BasketPresenter: BasketModuleInput {
}

extension BasketPresenter: BasketViewOutput {
}

extension BasketPresenter: BasketInteractorOutput {
}
