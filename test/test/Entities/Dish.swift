//
//  Dish.swift
//  test
//
//  Created by Егор Шкарин on 07.01.2022.
//

import Foundation
struct Dish: Codable {
    let id: Int
    let title: String
    let image: String
    let dishTypes: [String]
    let extendedIngredients: [String]
    let instructions: String
    
    init?(dict: [String: Any], index: Int) {
        guard let id = dict["id"] as? Int,
              let title = dict["title"] as? String,
              let image = dict["image"] as? String,
              let dishTypes = dict["dishTypes"] as? [String],
              let extendedIngredientsArray = dict["extendedIngredients"] as? [[String: Any]],
              let instructions = dict["instructions"] as? String
        else {
            return nil
        }
        self.id = id
        self.title = title
        self.image = image
        self.dishTypes = dishTypes
        self.extendedIngredients = extendedIngredientsArray.compactMap({ dict in
            return dict["name"] as? String
        })
        self.instructions = instructions
    }
}


