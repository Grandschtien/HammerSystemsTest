//
//  DishDecorationView.swift
//  test
//
//  Created by Егор Шкарин on 06.01.2022.
//

import UIKit

class DishDecorationView: UICollectionReusableView {
    
    static let reuseId = "DishDecorationView"
    static let sectionBackgroundDecorationElementKind = "background-element-kind"
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DishDecorationView {
    func configure() {
        self.backgroundColor = #colorLiteral(red: 0.974973079, green: 1, blue: 0.9689972778, alpha: 1)
        layer.cornerRadius = 30
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
}
