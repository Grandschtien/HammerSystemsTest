//
//  BasketProtocols.swift
//  test
//
//  Created by Егор Шкарин on 05.01.2022.
//  
//

import Foundation

protocol BasketModuleInput {
	var moduleOutput: BasketModuleOutput? { get }
}

protocol BasketModuleOutput: AnyObject {
}

protocol BasketViewInput: AnyObject {
}

protocol BasketViewOutput: AnyObject {
}

protocol BasketInteractorInput: AnyObject {
}

protocol BasketInteractorOutput: AnyObject {
}

protocol BasketRouterInput: AnyObject {
}
