//
//  RootViewController.swift
//  COVID Tracker
//
//  Created by 이건준 on 2022/05/16.
//

import UIKit

class RootViewController: UIViewController {
    
    private var scope: APICaller.DataScope = .national
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.prefersLargeTitles = true
        title = "Covid Cases"
        createFilterButton()
        
    }
    
    private func fetchData() {
        APICaller.shared.getCovidData(for: scope) { result in
            switch result {
            case .success(let states):
                break
            case .failure(let error):
                print("error = \(error)")
            }
        }
    }
    
    private func createFilterButton() {
        let buttonTitle: String = {
            switch scope {
                case .national: return "National"
                case .state(let state): return state.name
            }
        }()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: buttonTitle,
            style: .done,
            target: self,
            action: #selector(didTapFilter))
    }
    
    @objc private func didTapFilter() {
        let vc = FilterViewController()
        vc.completion = { [weak self] (state) in
            self?.scope = .state(state)
            self?.fetchData()
            self?.createFilterButton()
        }
        let navVC = UINavigationController(rootViewController: vc)
        present(navVC, animated: true)
    }
}
