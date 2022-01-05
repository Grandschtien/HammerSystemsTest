//
//  ContactsPresenter.swift
//  test
//
//  Created by Егор Шкарин on 05.01.2022.
//  
//

import Foundation

final class ContactsPresenter {
	weak var view: ContactsViewInput?
    weak var moduleOutput: ContactsModuleOutput?
    
	private let router: ContactsRouterInput
	private let interactor: ContactsInteractorInput
    
    init(router: ContactsRouterInput, interactor: ContactsInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension ContactsPresenter: ContactsModuleInput {
}

extension ContactsPresenter: ContactsViewOutput {
}

extension ContactsPresenter: ContactsInteractorOutput {
}
