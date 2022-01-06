//
//  HeaderView.swift
//  test
//
//  Created by Егор Шкарин on 05.01.2022.
//

import UIKit

class HeaderView: UICollectionReusableView {
    static let reuseId = "HeaderView"

    @IBOutlet weak var collctionView: UICollectionView!
    private let categories = ["Пицца", "Комбо", "Напитки", "Десерты", "Закуски", "Соусы"]
    
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

extension HeaderView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderCell.reuseId,
                                                            for: indexPath) as? HeaderCell else { return UICollectionViewCell()}
        cell.configure(name: categories[indexPath.item])
        return cell
    }
}
extension HeaderView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 88, height: 32)
    }
}
