//
//  ProductProtocols.swift
//  test
//
//  Created by Егор Шкарин on 11.01.2022.
//  
//

import Foundation
import UIKit

protocol ProductModuleInput: AnyObject {
	var moduleOutput: ProductModuleOutput? { get }
    func reciveDish(viewModel: DishesViewModel)
}

protocol ProductModuleOutput: AnyObject {

}

protocol ProductViewInput: AnyObject {
    func updateWithDish(viewModel: DishesViewModel) 
}

protocol ProductViewOutput: AnyObject {
    func viewDidLoad()
    func back()
}

protocol ProductInteractorInput: AnyObject {
}

protocol ProductInteractorOutput: AnyObject {
    
}

protocol ProductRouterInput: AnyObject {
    func back()
}
