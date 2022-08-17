//
//  RootViewController.swift
//  DiffableDataSourcePR
//
//  Created by 이건준 on 2022/08/16.
//

import UIKit

// 섹션 이넘
enum Section {
    case feed, post, board
}

// 클래스
class Feed: Hashable {
    // 고유 아이디
    let uuid: UUID = UUID()
    var content: String
    init(content: String) {
        self.content = content
    }

    //
    static func == (lhs: Feed, rhs: Feed) -> Bool {
        lhs.uuid == rhs.uuid
    }
    
    //
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}

// 스트럭트
struct Post : Hashable {
    var content: String
}

class RootViewController: UIViewController {
    
    var dataSource: UITableViewDiffableDataSource<Section, Feed>!
    var snapShot: NSDiffableDataSourceSnapshot<Section, Feed>!
    
    let feedArray = [
            Feed(content: "simply dummy text of the printing and"),
            Feed(content: "um has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type "),
            Feed(content: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribestablished fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, co"),
            Feed(content: "ho loves pain itself, who seeks after it and wants to have it, simply because it is pai"),
            Feed(content: "established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, co"),
            Feed(content: "ho loves pain itself, who seeks after it and wants to have it, simply because it is pai"),
            Feed(content: "a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is thaai"),
            Feed(content: "ho loves pain ita reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is to have it, simply because it is pai"),
            Feed(content: "ho loves pain itself, who seeks after it and wants to have it, simplho loves pain ita reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is to have it, simply because it y because it is pai")
        ]
    
    private let tableView: UITableView = {
       let tableView = UITableView()
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        tableView.register(RootTableViewCell.self, forCellReuseIdentifier: RootTableViewCell.identifier)
        tableView.delegate = self
//        tableView.dataSource = self
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableView.automaticDimension
        
        //MARK: - 데이터 소스 설정
        dataSource = UITableViewDiffableDataSource<Section, Feed>(tableView: tableView, cellProvider: { (tableView: UITableView, indexPath: IndexPath, identifier: Feed) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: RootTableViewCell.identifier, for: indexPath) as? RootTableViewCell ?? RootTableViewCell()
            print("identifier = \(identifier)")
            cell.configureUI(with: self.feedArray[indexPath.row].content)
            return cell
        })
        
        snapShot = NSDiffableDataSourceSnapshot<Section, Feed>()
        snapShot.appendSections([.feed])
        snapShot.appendItems(feedArray, toSection: .feed)
        
//        tableView.dataSource = dataSource
            self.dataSource.apply(snapShot)
        
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension RootViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RootTableViewCell.identifier, for: indexPath) as? RootTableViewCell ?? RootTableViewCell()
        cell.configureUI(with: feedArray[indexPath.row].content)
        return cell
    }
}
