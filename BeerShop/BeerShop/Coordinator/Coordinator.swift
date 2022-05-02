//
//  Coordinator.swift
//  BeerShop
//
//  Created by 이건준 on 2022/05/02.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController? { get set }
    func start()
}
