//
//  MenuViewController.swift
//  test
//
//  Created by Егор Шкарин on 05.01.2022.
//  
//

import UIKit

final class MenuViewController: UIViewController {
    private let output: MenuViewOutput
    private var collectionView: UICollectionView?
    
    init(output: MenuViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "backColor")
        setupNavigationBar()
        setupCollectionView()
    }
}

//MARK: - Create layout
extension MenuViewController {
    private func setupNavigationBar() {
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor =  UIColor(named: "backColor")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "leftBarButton"), style: .plain, target: nil, action: nil)
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        guard let collectionView = collectionView else { return }
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor(named: "backColor")
        collectionView.register(UINib(nibName: "AdvsCell", bundle: nil),
                                forCellWithReuseIdentifier: AdvsCell.reuseId)
        collectionView.register(UINib(nibName: "DishCell", bundle: nil),
                                forCellWithReuseIdentifier: DishCell.reuseId)
        collectionView.register(UINib(nibName: "HeaderView", bundle: nil),
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: HeaderView.reuseId)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {[weak self](sectionIndex: Int,
                                                                      layoutEnvironment: NSCollectionLayoutEnvironment)
            -> NSCollectionLayoutSection? in
            
            switch sectionIndex {
            case 0:
                return self?.createAdvSection()
            case 1:
                return self?.createDishSection()
            default:
                print("There is no needed item")
                return nil
            }
        }
        layout.register(DishDecorationView.self, forDecorationViewOfKind: DishDecorationView.sectionBackgroundDecorationElementKind)
        return layout
    }
    
    private func createAdvSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets.init(top: 0,
                                                                leading: 0,
                                                                bottom: 0,
                                                                trailing: 8)
        
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .estimated(300),
                                                     heightDimension: .estimated(112))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize,
                                                             subitems: [layoutItem])
        
        let section = NSCollectionLayoutSection(group: layoutGroup)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 20, leading: 8, bottom: 10, trailing: 0)
        return section
    }
    
    private func createDishSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        let header = createHeader()
        header.pinToVisibleBounds = true
        section.boundarySupplementaryItems = [header]
        let sectionBackgroundDecoration = NSCollectionLayoutDecorationItem.background(elementKind: DishDecorationView.sectionBackgroundDecorationElementKind)
        sectionBackgroundDecoration.contentInsets = NSDirectionalEdgeInsets(top: 65, leading: 0, bottom: 0, trailing: 0)
        section.decorationItems = [sectionBackgroundDecoration]
        return section
    }
    
    private func createHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                heightDimension: .estimated(60))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                 elementKind: UICollectionView.elementKindSectionHeader,
                                                                 alignment: .top)
        return header
    }
}
//MARK: - Create datasource
extension MenuViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return output.numberOfSections
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return output.numberOfCellsInAdvSection
        case 1:
            return output.numberOfCellsInDishSection
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AdvsCell.reuseId,
                                                                for: indexPath) as? AdvsCell else {
                return UICollectionViewCell()
            }
            cell.configure(nameOfPhoto: output.advPhoto)
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DishCell.reuseId,
                                                                for: indexPath) as? DishCell else {
                return UICollectionViewCell()
            }
            cell.configure()
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        switch indexPath.section {
        case 1:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                                   withReuseIdentifier: "HeaderView",
                                                                                   for: indexPath) as? HeaderView else {
                return UICollectionReusableView()
            }
            return headerView
            
        default:
            return UICollectionReusableView()
        }
    }
}

extension MenuViewController: MenuViewInput {
    
}
