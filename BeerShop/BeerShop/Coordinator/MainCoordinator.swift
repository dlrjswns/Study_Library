//
//  MainCoordinator.swift
//  BeerShop
//
//  Created by 이건준 on 2022/05/02.
//

import UIKit

class MainCoordinator: Coordinator {
    
    var navigationController: UINavigationController?
    var tabbarController: MainTabbarController?
    
    struct Dependency {
        let beerListViewControllerFactory: () -> BeerListViewController
        let beerViewControllerFactory: () -> BeerViewController
    }
    
    init(dependency: Dependency) {
        beerListViewControllerFactory = dependency.beerListViewControllerFactory
        beerViewControllerFactory = dependency.beerViewControllerFactory
    }
    
    let beerListViewControllerFactory: () -> BeerListViewController
    let beerViewControllerFactory: () -> BeerViewController
    
    func start() {
        let beerListVC = beerListViewControllerFactory()
        let beerVC = beerViewControllerFactory()
        let navBeerListVC = UINavigationController(rootViewController: beerListVC)
        let navBeerVC = UINavigationController(rootViewController: beerVC)
//        navBeerListVC.title = "Beer List"
        navBeerListVC.navigationItem.largeTitleDisplayMode = .always
//        navBeerVC.title = "Search Beer"
        navBeerVC.navigationItem.largeTitleDisplayMode = .always
        tabbarController?.setViewControllers([navBeerListVC, navBeerVC], animated: true)
    }
    
}
