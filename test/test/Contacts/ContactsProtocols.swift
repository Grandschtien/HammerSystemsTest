//
//  ContactsProtocols.swift
//  test
//
//  Created by Егор Шкарин on 05.01.2022.
//  
//

import Foundation

protocol ContactsModuleInput {
	var moduleOutput: ContactsModuleOutput? { get }
}

protocol ContactsModuleOutput: AnyObject {
}

protocol ContactsViewInput: AnyObject {
}

protocol ContactsViewOutput: AnyObject {
}

protocol ContactsInteractorInput: AnyObject {
}

protocol ContactsInteractorOutput: AnyObject {
}

protocol ContactsRouterInput: AnyObject {
}
