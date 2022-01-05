//
//  BasketContainer.swift
//  test
//
//  Created by Егор Шкарин on 05.01.2022.
//  
//

import UIKit

final class BasketContainer {
    let input: BasketModuleInput
	let viewController: UIViewController
	private(set) weak var router: BasketRouterInput!

	static func assemble(with context: BasketContext) -> BasketContainer {
        let router = BasketRouter()
        let interactor = BasketInteractor()
        let presenter = BasketPresenter(router: router, interactor: interactor)
		let viewController = BasketViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter

        return BasketContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: BasketModuleInput, router: BasketRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct BasketContext {
	weak var moduleOutput: BasketModuleOutput?
}
