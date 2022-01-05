//
//  ContactsViewController.swift
//  test
//
//  Created by Егор Шкарин on 05.01.2022.
//  
//

import UIKit

final class ContactsViewController: UIViewController {
	private let output: ContactsViewOutput

    init(output: ContactsViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
        view.backgroundColor = .darkGray
	}
}

extension ContactsViewController: ContactsViewInput {
}
