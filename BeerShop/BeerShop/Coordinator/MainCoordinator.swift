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
        let beerDetailViewControllerFactory: (Beer) -> BeerDetailViewController
    }
    
    init(dependency: Dependency) {
        beerListViewControllerFactory = dependency.beerListViewControllerFactory
        beerViewControllerFactory = dependency.beerViewControllerFactory
        beerDetailViewControllerFactory = dependency.beerDetailViewControllerFactory
    }
    
    let beerListViewControllerFactory: () -> BeerListViewController
    let beerViewControllerFactory: () -> BeerViewController
    let beerDetailViewControllerFactory: (Beer) -> BeerDetailViewController
    
    func start() {
        let beerListVC = beerListViewControllerFactory()
        let beerVC = beerViewControllerFactory()
        let navBeerListVC = UINavigationController(rootViewController: beerListVC)
        let navBeerVC = UINavigationController(rootViewController: beerVC)
        
        beerListVC.coordinator = self
        navBeerListVC.navigationItem.largeTitleDisplayMode = .always
        navBeerVC.navigationItem.largeTitleDisplayMode = .always
//        navigationController?.setViewControllers([beerListVC, beerVC], animated: true)
        tabbarController?.setViewControllers([navBeerListVC, navBeerVC], animated: true)
    }
    
    func cellTapped(with model: Beer) {
        let beerDetailVC = beerDetailViewControllerFactory(model)
        
        
    }
    
}
