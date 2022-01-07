//
//  HeaderView.swift
//  test
//
//  Created by Егор Шкарин on 05.01.2022.
//

import UIKit

protocol SelectCategoryProtocol: AnyObject {
    func selectedCategory(indexPath: IndexPath)
}

class HeaderView: UICollectionReusableView {
    static let reuseId = "HeaderView"
    weak var selectedCategory: SelectCategoryProtocol?
    private var previousIndex: IndexPath?
    @IBOutlet weak var collctionView: UICollectionView!
    private let categories = ["Пицца", "Комбо", "Напитки", "Десерты", "Закуски", "Соусы", "Другое"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collctionView.dataSource = self
        collctionView.delegate = self
        collctionView.backgroundColor = UIColor(named: "backColor")
        collctionView.contentInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        collctionView.register(UINib(nibName: "HeaderCell", bundle: nil),
                               forCellWithReuseIdentifier: HeaderCell.reuseId)
    }
    
}
//MARK: - Datasource
extension HeaderView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderCell.reuseId,
                                                            for: indexPath) as? HeaderCell else { return UICollectionViewCell()}
        if indexPath.row == 0 {
            cell.isSelectedCell = true
        }
        cell.configure(name: categories[indexPath.item])
        return cell
    }
}
// MARK: - Layout
extension HeaderView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 88, height: 32)
    }
}
//MARK: - Delegate

extension HeaderView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCategory?.selectedCategory(indexPath: indexPath)
        guard let selectedCell = collectionView.cellForItem(at: indexPath) as? HeaderCell else {
            return
        }
        if let previousIndex = previousIndex, let previousCell = collectionView.cellForItem(at: previousIndex) as? HeaderCell {
            previousCell.isSelectedCell = false
        } else {
            previousIndex = indexPath
            selectedCell.isSelectedCell = !selectedCell.isSelectedCell
        }
    }
}
