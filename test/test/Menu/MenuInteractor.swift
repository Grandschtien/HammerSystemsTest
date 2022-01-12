//
//  MenuInteractor.swift
//  test
//
//  Created by Егор Шкарин on 05.01.2022.
//  
//

import Foundation

final class MenuInteractor {
	weak var output: MenuInteractorOutput?
    private var networkManager = NetworkManager()
}

extension MenuInteractor: MenuInteractorInput {
    func loadData() {
        networkManager.getData {[weak self] result in
            switch result {
            case .success(let data):
                guard let dataDict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                        let newData =  dataDict["recipes"] as? [[String: Any]]
                else {
                    return
                }
//                print(newData.first?["instructions"] as? String)
                var dishes = [Dish]()
                for (index, value) in newData.enumerated() {
                    guard let dish = Dish(dict: value, index: index) else { continue }
                    dishes.append(dish)
                }
                self?.output?.didLoadData(dishes: dishes)
                break
            case .failure(let error):
                self?.output?.catchedError(error: error)
            }
        }
    }
}
