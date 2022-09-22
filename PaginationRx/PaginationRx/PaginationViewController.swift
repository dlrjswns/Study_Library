//
//  PaginationViewController.swift
//  PaginationRx
//
//  Created by 이건준 on 2022/09/22.
//

import UIKit
import RxSwift
import RxCocoa

class PaginationViewController: UIViewController {
    
    private var disposeBag = DisposeBag()
    private let viewModel = PaginationViewModel()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: UITableViewCell.description())
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.refreshControl = refreshControl
        tableView.tableFooterView = UIView(frame: .zero)
        //        tableView.delegate = self
        //        tableView.dataSource = self
        return tableView
    }()
    
    private lazy var viewSpinner: UIView = {
        let view = UIView(frame: CGRect(
            x: 0,
            y: 0,
            width: view.frame.size.width,
            height: 100)
        )
        let spinner = UIActivityIndicatorView()
        spinner.center = view.center
        view.addSubview(spinner)
        spinner.startAnimating()
        return view
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        return refreshControl
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bind()
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            self.viewModel.fetchMoreDatas.onNext(())
        }
        refreshControl.addTarget(self, action: #selector(refreshControlTriggered), for: .valueChanged)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func bind() {
        
        tableViewBind()
        
        viewModel.isLoadingSpinnerAvaliable.subscribe { [weak self] isAvaliable in
            guard let isAvaliable = isAvaliable.element,
                  let self = self else { return }
            self.tableView.tableFooterView = isAvaliable ? self.viewSpinner : UIView(frame: .zero)
        }
        .disposed(by: disposeBag)
        
        viewModel.refreshControlCompelted.subscribe { [weak self] _ in
            guard let self = self else { return }
            self.refreshControl.endRefreshing()
        }
        .disposed(by: disposeBag)
    }
    
    private func tableViewBind() {
        
        viewModel.items.bind(to: tableView.rx.items) { tableView, _, item in
            let cell = tableView
                .dequeueReusableCell(withIdentifier: UITableViewCell.description())
            cell?.selectionStyle = .none
            cell?.textLabel?.text = item
            return cell ?? UITableViewCell()
        }
        .disposed(by: disposeBag)
        
        tableView.rx.didScroll.subscribe { [weak self] _ in
            guard let self = self else { return }
            let offSetY = self.tableView.contentOffset.y
            let contentHeight = self.tableView.contentSize.height
            
            print("contentHeight = \(self.tableView.contentSize.height)")
            print("frameHeight = \(self.tableView.frame.size.height)")
            print("offsetY = \(self.tableView.contentOffset.y)")
            
            if offSetY > (contentHeight - self.tableView.frame.size.height - 100) {
                self.viewModel.fetchMoreDatas.onNext(())
            }
        }
        .disposed(by: disposeBag)
    }
    
    @objc private func refreshControlTriggered() {
        viewModel.refreshControlAction.onNext(())
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        refreshControl.addTarget(self, action: #selector(refreshControlTriggered), for: .valueChanged)
    }
}

extension PaginationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
