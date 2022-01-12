//
//  ProductContainer.swift
//  test
//
//  Created by Егор Шкарин on 11.01.2022.
//  
//

import UIKit

final class ProductContainer {
    let input: ProductModuleInput
	let viewController: UIViewController
	private(set) weak var router: ProductRouterInput!

	static func assemble(with context: ProductContext) -> ProductContainer {
        let router = ProductRouter()
        let interactor = ProductInteractor()
        let presenter = ProductPresenter(router: router, interactor: interactor)
		let viewController = ProductViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput
        router.viewController = viewController
		interactor.output = presenter

        return ProductContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: ProductModuleInput, router: ProductRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct ProductContext {
	weak var moduleOutput: ProductModuleOutput?
}

