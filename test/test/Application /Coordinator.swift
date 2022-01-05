//
//  Coordinator.swift
//  test
//
//  Created by Егор Шкарин on 05.01.2022.
//

import Foundation
import UIKit

protocol CoordinatorProtocol {
    func start()
}

final class Coordinator: CoordinatorProtocol {
    private let window: UIWindow
    private lazy var tabBarController = UITabBarController()
    private lazy var navigationControllers = Coordinator.makeNavigationControllers()
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        setupMenu()
        setupContacts()
        setupProfile()
        setupBasket()
        
        let navigationControllers = NavControllerType.allCases.compactMap {
            self.navigationControllers[$0]
        }
        tabBarController.setViewControllers(navigationControllers, animated: true)
        tabBarController.tabBar.barTintColor = UIColor(named: "tabBarColor")
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
}

extension Coordinator {
    
    private func setupMenu() {
        guard let navController = navigationControllers[.menu] else {
            fatalError("No navController")
        }
        let menuContext = MenuContext(moduleOutput: nil)
        let menuContainer = MenuContainer.assemble(with: menuContext)
        navController.setViewControllers([menuContainer.viewController], animated: true)
    }
    
    private func setupBasket() {
        guard let navController = navigationControllers[.basket] else {
            fatalError("No navController")
        }
        let basketContext = BasketContext(moduleOutput: nil)
        let basketContainer = BasketContainer.assemble(with: basketContext)
        navController.setViewControllers([basketContainer.viewController], animated: true)
    }
    
    private func setupProfile() {
        guard let navController = navigationControllers[.profile] else {
            fatalError("No navController")
        }
        let profileContext = ProfileContext(moduleOutput: nil)
        let profileContainer = ProfileContainer.assemble(with: profileContext)
        navController.setViewControllers([profileContainer.viewController], animated: true)
    }
    
    private func setupContacts() {
        guard let navController = navigationControllers[.contacts] else {
            fatalError("No navController")
        }
        let contactsContext = ContactsContext(moduleOutput: nil)
        let contactContainer = ContactsContainer.assemble(with: contactsContext)
        navController.setViewControllers([contactContainer.viewController], animated: true)
    }
    
    fileprivate static func makeNavigationControllers() -> [NavControllerType: UINavigationController] {
        var result: [NavControllerType: UINavigationController] = [:]
        NavControllerType.allCases.forEach { navControllerKey in
            let navigationController = UINavigationController()
            let tabBarItem = UITabBarItem(title: navControllerKey.title,
                                          image: navControllerKey.image,
                                          tag: navControllerKey.rawValue)
            navigationController.tabBarItem = tabBarItem
            result[navControllerKey] = navigationController
            
            navigationController.isNavigationBarHidden = true
        }
        return result
    }
}

fileprivate enum NavControllerType: Int, CaseIterable {
    case menu, basket, profile, contacts
    
    var title: String {
        switch self {
        case .menu:
            return "Меню"
        case .basket:
            return "Избранное"
        case .profile:
            return "Профиль"
        case .contacts:
            return "Контакты"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .menu:
            return UIImage(named: "menu")
        case .basket:
            return UIImage(named: "basket")
        case .profile:
            return UIImage(named: "profile")
        case .contacts:
            return UIImage(named: "contacts")
        }
    }
}
