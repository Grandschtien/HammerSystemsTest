//
//  ProductInteractor.swift
//  test
//
//  Created by Егор Шкарин on 11.01.2022.
//  
//

import Foundation

final class ProductInteractor {
	weak var output: ProductInteractorOutput?
}

extension ProductInteractor: ProductInteractorInput {
}
