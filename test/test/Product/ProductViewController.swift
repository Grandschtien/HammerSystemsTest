//
//  ProductViewController.swift
//  test
//
//  Created by Егор Шкарин on 11.01.2022.
//  
//

import UIKit
import SwiftUI

final class ProductViewController: UIViewController {
    private let output: ProductViewOutput
    private var viewModel: DishesViewModel?
    
    private let image = UIImageView(frame: .zero)
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let name = UILabel()
    private let ingredients = UILabel()
    private let instructions = UILabel()
    private let tableView = ParalaxTableView()
    private var headerView: UIView?
    
    var imageHeightConstraint: NSLayoutConstraint?
    var imageBottomConstraint: NSLayoutConstraint?
    var imageLeadingConstraint: NSLayoutConstraint?
    var imageTrailingConstraint: NSLayoutConstraint?
    
    init(output: ProductViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        output.viewDidLoad()
        setupConstraints()
        setupUI()
    }
}

extension ProductViewController: ProductViewInput {
    func updateWithDish(viewModel: DishesViewModel) {
        self.viewModel = viewModel
    }
}
extension ProductViewController {
    func setupConstraints() {
        
        headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 200))
        image.translatesAutoresizingMaskIntoConstraints = false
        headerView?.addSubview(image)
        tableView.tableHeaderView = headerView
        
        imageBottomConstraint = NSLayoutConstraint(item: headerView ?? UIView(),
                                                   attribute: .bottom,
                                                   relatedBy: .equal,
                                                   toItem:  image,
                                                   attribute: .bottom,
                                                   multiplier: 1,
                                                   constant: 0)
        
        imageHeightConstraint = NSLayoutConstraint(item: image,
                                                   attribute: .height,
                                                   relatedBy: .equal,
                                                   toItem: nil,
                                                   attribute: .notAnAttribute,
                                                   multiplier: 1,
                                                   constant: 200)
        
        imageLeadingConstraint = NSLayoutConstraint(item: headerView ?? UIView(),
                                                    attribute: .leading,
                                                    relatedBy: .equal,
                                                    toItem: image,
                                                    attribute: .leading,
                                                    multiplier: 1,
                                                    constant: 0)
        
        imageTrailingConstraint = NSLayoutConstraint(item: headerView ?? UIView(),
                                                     attribute: .trailing,
                                                     relatedBy: .equal,
                                                     toItem: image,
                                                     attribute: .trailing,
                                                     multiplier: 1,
                                                     constant: 0)
        
        imageHeightConstraint?.isActive = true
        imageBottomConstraint?.isActive = true
        imageLeadingConstraint?.isActive = true
        imageTrailingConstraint?.isActive = true
        
        imageBottomConstraint?.identifier = "imageBottomConstraint"
        imageHeightConstraint?.identifier = "imageHeightConstraint"
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    func setupUI() {
        tabBarController?.tabBar.isHidden = true
        tableView.dataSource = self
        tableView.register(TextCell.self)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.kf.setImage(with: viewModel?.resource,
                          placeholder: UIImage(named: "menu"),
                          options: [.cacheMemoryOnly])
        
        let leftBarButton = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(back))
        leftBarButton.tintColor = UIColor(named: "buttonsColor")
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationItem.leftBarButtonItem = leftBarButton
    }
}
//MARK: - Actions
extension ProductViewController {
    @objc
    func back() {
        output.back()
    }
}
//MARK: -
extension ProductViewController: UIGestureRecognizerDelegate {}

extension ProductViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(cellType: TextCell.self, for: indexPath)
        guard let viewModel = viewModel else {
            fatalError("Can't find view model")
        }
        cell.configure(viewModel: viewModel, section: indexPath.section)
        return cell
    }
}

