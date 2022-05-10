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

class BeerListViewController: UIViewController {
    
    private let viewModel: BeerListViewModelType
    
    var coordinator: MainCoordinator?
    
    var disposeBag = DisposeBag()
    
    private let tableView: UITableView = {
       let tableView = UITableView()
        return tableView
    }()
    
    private let floatingButton: UIButton = {
       let button = UIButton()
        button.clipsToBounds = true
        button.layer.cornerRadius = 25
        button.isHidden = false
        button.backgroundColor = .systemMint
        button.setImage(UIImage(systemName: "arrow.up"), for: .normal)
        return button
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
        setNavigationBar()
        setTableView()
        bind()
        floatingButton.addTarget(self, action: #selector(didTappdFloatingButton), for: .touchUpInside)
    }
    
    @objc private func didTappdFloatingButton() {
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
    
    private func setNavigationBar() {
        title = "Beer List"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = .systemPink
    }
    
    private func setTableView() {
        tableView.register(BeerListCell.self, forCellReuseIdentifier: BeerListCell.identifier)
        tableView.delegate = self
    }
    
    private func bind() {
        viewModel.beerListModelOutput.asObservable().bind(to: tableView.rx.items(cellIdentifier: BeerListCell.identifier, cellType: BeerListCell.self)) { index, item, cell in
            cell.configureCell(with: item)
        }.disposed(by: disposeBag)
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(tableView)
        view.addSubview(floatingButton)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        floatingButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-70)
            make.right.equalToSuperview().offset(-20)
            make.width.height.equalTo(50)
        }
        
        
    }
}

extension BeerListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let cell = tableView.cellForRow(at: indexPath) as? BeerListCell,
              let beer = cell.currentBeer else {
            return
        }
        let detailVC = BeerDetailViewController(dependency: .init(selectedBeer: beer))
        self.navigationController?.pushViewController(detailVC, animated: true)
//        coordinator?.cellTapped(where: self, with: beer)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("cell = \(cell)")
        print("indexpath = \(indexPath)")
    }
}
