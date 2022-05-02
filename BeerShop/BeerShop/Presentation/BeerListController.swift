//
//  BeerListController.swift
//  BeerShop
//
//  Created by 이건준 on 2022/05/02.
//

import UIKit

class BeerListController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let rp = BeerRepositoryImpl()
        rp.fetchOneBeer()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
    }
}
