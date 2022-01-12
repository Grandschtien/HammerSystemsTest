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
    private var activityIndicator = UIActivityIndicatorView()
    
    //Views для обработки потери сети
    private let noConnectionLabel = UILabel()
    private let errorLabel = UILabel()
    private let errorButton = UIButton(type: .roundedRect)
    private let errorStackView = UIStackView()
    
    private var viewModels = [DishesViewModel]()
    
    init(output: MenuViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewDidLoad()
        setupNavigationBar()
        setupCollectionView()
        collectionView?.isHidden = true
        setupWaitingIndicator()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
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
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor(named: "backColor")
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(UINib(nibName: AdvsCell.nibName, bundle: nil),
                                forCellWithReuseIdentifier: AdvsCell.reuseIdentifier)
        collectionView.register(UINib(nibName: DishCell.nibName, bundle: nil),
                                forCellWithReuseIdentifier: DishCell.reuseIdentifier)
        collectionView.register(UINib(nibName: HeaderView.nibName, bundle: nil),
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: HeaderView.reuseIdentifier)
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
    //MARK: - Создание секции рекламы
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
    //MARK: - Создание секции блюд
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
    //MARK: - Создание заголовка секции блюд
    private func createHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                heightDimension: .estimated(60))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                 elementKind: UICollectionView.elementKindSectionHeader,
                                                                 alignment: .top)
        return header
    }
    //MARK: - Создание индикатора загрузки
    private func setupWaitingIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        activityIndicator.style = UIActivityIndicatorView.Style.large
        activityIndicator.startAnimating()
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        activityIndicator.isHidden = false
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
            let cell = collectionView.dequeueCell(cellType: AdvsCell.self, for: indexPath)
            cell.configure(nameOfPhoto: output.advPhoto)
            return cell
        case 1:
            let cell = collectionView.dequeueCell(cellType: DishCell.self, for: indexPath)
            cell.configure(viewModel: viewModels[indexPath.row])
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
            headerView.selectedCategory = self
            return headerView
            
        default:
            return UICollectionReusableView()
        }
    }
}
// MARK: - MenuViewInput
extension MenuViewController: MenuViewInput {
    func makeErrorNotification(error: String) {
        DispatchQueue.main.async {[self] in
            activityIndicator.isHidden = true
            errorStackView.translatesAutoresizingMaskIntoConstraints = false
            errorLabel.translatesAutoresizingMaskIntoConstraints = false
            errorButton.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(errorStackView)
            errorStackView.addArrangedSubview(errorLabel)
            errorStackView.addArrangedSubview(errorButton)
            
            NSLayoutConstraint.activate([
                errorStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                errorStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                errorStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
                errorStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                errorLabel.trailingAnchor.constraint(equalTo: errorStackView.trailingAnchor),
                errorLabel.leadingAnchor.constraint(equalTo: errorStackView.leadingAnchor),
                errorButton.trailingAnchor.constraint(equalTo: errorStackView.trailingAnchor),
                errorButton.leadingAnchor.constraint(equalTo: errorStackView.leadingAnchor)

            ])
            
            errorLabel.text = error
            
            errorLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
            errorLabel.textAlignment = .center
            errorLabel.textColor = .black
            errorLabel.numberOfLines = 2
            
            errorButton.setTitle("Обновить", for: .normal)
            errorButton.setTitleColor(UIColor(named: "buttonsColor"), for: .normal)
            errorButton.layer.cornerRadius = 10
            errorButton.layer.borderWidth = 1
            errorButton.layer.borderColor = UIColor(named: "buttonsColor")?.cgColor
            errorStackView.axis = .vertical
            errorStackView.spacing = 30
            errorStackView.distribution = .fill
            errorStackView.alignment = .center
            errorButton.addTarget(self, action: #selector(reloadView), for: .touchUpInside)
            errorStackView.isHidden = false
            errorLabel.isHidden = false
            errorButton.isHidden = false
        }
    }
    func updateViewWithDishes(dishes: [DishesViewModel]) {
        viewModels = dishes
        DispatchQueue.main.async {
            self.collectionView?.isHidden = false
            self.activityIndicator.isHidden = true
            self.collectionView?.reloadData()
        }
    }
    
}
//MARK: - Метод делегата для пролистывания коллекции
extension MenuViewController: SelectCategoryProtocol {
    func selectedCategory(indexPath: IndexPath) {
        let indexPath = IndexPath(item: indexPath.item * 7, section: 1)
        collectionView?.scrollToItem(at: indexPath, at: .top, animated: true)
    }
}
//MARK: - Actions
extension MenuViewController {
    @objc
    func reloadView() {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        output.viewDidLoad()
        errorStackView.isHidden = true
        errorLabel.isHidden = true
        errorButton.isHidden = true
    }
}

extension MenuViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        output.goToProduct(viewModel: viewModels[indexPath.item])
    }
}
