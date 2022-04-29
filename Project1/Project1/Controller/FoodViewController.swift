//
//  FoodViewController.swift
//  Project1
//
//  Created by 이건준 on 2022/04/28.
//

import UIKit
import RxSwift
import SnapKit

class FoodViewController: UIViewController {
    
    private let viewModel: FoodViewModelType
    
    private var disposeBag = DisposeBag()
    
    private let tableView: UITableView = {
        $0.register(FoodCell.self, forCellReuseIdentifier: FoodCell.identifier)
        $0.backgroundColor = .red
        return $0
    }(UITableView())
    
    init(viewModel: FoodViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        tableView.delegate = self
        bind()
        
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//            make.top.equalTo(view.safeAreaLayoutGuide)
            make.width.height.equalTo(200)
            make.top.equalToSuperview().offset(30)
        }
        
//        tableView.dataSource = self

        
    }
    
    private func bind() {
//        viewModel.foodMockOutput.asObservable().bind(onNext: { mock in
//            print("mock = \(mock)")
//        }).disposed(by: disposeBag)
        viewModel.foodMockOutput.asObservable().bind(to: tableView.rx.items(cellIdentifier: FoodCell.identifier, cellType: FoodCell.self)) { index, item, cell in
            cell.textLabel?.text = item.resionName
        }.disposed(by: disposeBag)
        
    
    }
}

extension FoodViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
//
//extension FoodViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 10
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: FoodCell.identifier, for: indexPath) as! FoodCell
//        return cell
//    }
//
//
//}
