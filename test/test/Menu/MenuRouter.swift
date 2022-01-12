//
//  MenuRouter.swift
//  test
//
//  Created by Егор Шкарин on 05.01.2022.
//  
//

import UIKit

final class MenuRouter {
    var viewController: UIViewController?
}

extension MenuRouter: MenuRouterInput {
    func gotToProductScreen(viewModel: DishesViewModel) {
        let productContext = ProductContext(moduleOutput: nil)
        let productContainer =  ProductContainer.assemble(with: productContext)
        productContainer.input.reciveDish(viewModel: viewModel)
        viewController?.navigationController?.pushViewController(productContainer.viewController, animated: true)
    }
}
