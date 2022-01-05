//
//  MenuProtocols.swift
//  test
//
//  Created by Егор Шкарин on 05.01.2022.
//  
//

import Foundation

protocol MenuModuleInput {
	var moduleOutput: MenuModuleOutput? { get }
}

protocol MenuModuleOutput: AnyObject {
}

protocol MenuViewInput: AnyObject {
}

protocol MenuViewOutput: AnyObject {
}

protocol MenuInteractorInput: AnyObject {
}

protocol MenuInteractorOutput: AnyObject {
}

protocol MenuRouterInput: AnyObject {
}
