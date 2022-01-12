//
//  ProductRouter.swift
//  test
//
//  Created by Егор Шкарин on 11.01.2022.
//  
//

import UIKit

final class ProductRouter {
    var viewController: UIViewController?
}

extension ProductRouter: ProductRouterInput {
    func back() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
