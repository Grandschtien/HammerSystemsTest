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
        return 10
    }
    
    var numberOfSections: Int {
        return 2
    }
    
}

extension MenuPresenter: MenuInteractorOutput {
    
}
