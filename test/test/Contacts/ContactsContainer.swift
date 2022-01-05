//
//  ContactsContainer.swift
//  test
//
//  Created by Егор Шкарин on 05.01.2022.
//  
//

import UIKit

final class ContactsContainer {
    let input: ContactsModuleInput
	let viewController: UIViewController
	private(set) weak var router: ContactsRouterInput!

	static func assemble(with context: ContactsContext) -> ContactsContainer {
        let router = ContactsRouter()
        let interactor = ContactsInteractor()
        let presenter = ContactsPresenter(router: router, interactor: interactor)
		let viewController = ContactsViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter

        return ContactsContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: ContactsModuleInput, router: ContactsRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct ContactsContext {
	weak var moduleOutput: ContactsModuleOutput?
}
