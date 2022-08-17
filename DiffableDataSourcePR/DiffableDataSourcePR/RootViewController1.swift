//
//  RootViewController1.swift
//  DiffableDataSourcePR
//
//  Created by 이건준 on 2022/08/17.
//

import UIKit

class RootTableViewCell1: UITableViewCell {
    
    static let identifier = "RootTableViewCell1"
    
    private let label: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        label.widthAnchor.constraint(lessThanOrEqualTo: contentView.widthAnchor).isActive = true
    }
    
    public func configureUI(with model: String) {
        label.text = model
    }
    
}

class RootViewController1: UIViewController {
    
    private var model = [
        "ㄴㅇ러;ㅁㄴ얼ㄴㅁㅇㄹㄴㅇㅁㄹㄴㅁㅇㄹㄴㅇㅁㄹ",
        "ㅁㄴㅇㄹㄴㅇㅁㄹㄴㅁㅇㄹ",
        "ㅁㄴㅇㄹㄴㅁㅇㄹ",
        "ㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴ",
        "ㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㄹ",
    ]
    
    private let tableView: UITableView = {
       let tableView = UITableView()
        tableView.backgroundColor = .systemBlue
        return tableView
    }()
    
    private let button: UIButton = {
       let button = UIButton()
        button.setTitle("추가", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: tableView.bottomAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        tableView.register(RootTableViewCell1.self, forCellReuseIdentifier: RootTableViewCell1.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        button.addTarget(self, action: #selector(didTappedButton), for: .touchUpInside)
    }
    
    @objc func didTappedButton() {
        tableView.performBatchUpdates {
            model.append("추가합니당 :)")
            tableView.insertRows(at: [.init(row: 2, section: 0)], with: .top)
            
//            tableView.insertSections(.init(integer: 1), with: .top)
        }
    }
    
}

extension RootViewController1: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RootTableViewCell1.identifier, for: indexPath) as? RootTableViewCell1 ?? RootTableViewCell1()
        cell.configureUI(with: model[indexPath.row])
        return cell
    }
}
