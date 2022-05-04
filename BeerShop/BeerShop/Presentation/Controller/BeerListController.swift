//
//  BeerListController.swift
//  BeerShop
//
//  Created by 이건준 on 2022/05/02.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class BeerListController: UIViewController {
    
    private let viewModel: BeerListViewModelType
    
    var disposeBag = DisposeBag()
    
    private let tableView: UITableView = {
       let tableView = UITableView()
        return tableView
    }()
    
    init(viewModel: BeerListViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(BeerListCell.self, forCellReuseIdentifier: BeerListCell.identifier)
        tableView.delegate = self
        bind()
    }
    
    private func bind() {
        viewModel.beerListModelOutput.asObservable().bind(to: tableView.rx.items(cellIdentifier: BeerListCell.identifier, cellType: BeerListCell.self)) { index, item, cell in
            cell.configureCell(with: item)
        }.disposed(by: disposeBag)
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension BeerListController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
