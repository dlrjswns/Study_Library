//
//  DynamicScrollViewController.swift
//  DynamicScrollView
//
            //  Created by 이건준 on 2022/05/28.
//

import UIKit
import SnapKit

struct Student: Equatable {
    let name: String
    let age: Int
    
//    static func == (lhs: Self, rhs: Self) -> Bool {
//        if self.init(name: <#T##String#>, age: <#T##Int#>)
//        return true
//    }
}

enum Person: CaseIterable {
    case a, b, c, d, e
}

class DynamicScrollViewController: UIViewController {
    
    private var datas = ["이건준", "이상준", "문진우", "신범철"] {
        didSet {
            tableView.reloadData()
        }
    }
    
    
    
    private let scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = true
        scrollView.alwaysBounceVertical = true
        scrollView.backgroundColor = .systemBlue
        scrollView.contentInset = .init(top: 20, left: 20, bottom: 20, right: 20)
//        scrollView.contentOffset = CGPoint(x: 70, y: 70)
//        scrollView.setContentOffset(CGPoint(x: 70, y: 70), animated: true)
        return scrollView
    }()
    
    private let tableView: UITableView = {
       let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private let label: UILabel = {
       let label = UILabel()
        label.text = "Label"
        label.font = .systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    private let imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        let config = UIImage.SymbolConfiguration(pointSize: 200)
        imageView.image = UIImage(systemName: "heart.fill")?.withConfiguration(config)
        imageView.tintColor = .systemRed
        return imageView
    }()
    
    private let imageView1: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        let config = UIImage.SymbolConfiguration(pointSize: 40)
        imageView.image = UIImage(systemName: "heart.fill")?.withConfiguration(config)
        imageView.tintColor = .systemRed
        return imageView
    }()
    
    private let imageView2: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        let config = UIImage.SymbolConfiguration(pointSize: 40)
        imageView.image = UIImage(systemName: "heart.fill")?.withConfiguration(config)
        imageView.tintColor = .systemRed
        return imageView
    }()
    
    private let vw: UIView = {
       let vw = UIView()
        vw.backgroundColor = .systemRed
        return vw
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
//        view.addSubview(tableView)
//        tableView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//
//        tableView.dataSource = self
        
        view.addSubview(scrollView)
        scrollView.addSubview(vw)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        
//        scrollView.contentOffset = .init(x: 300, y: 300)
//        scrollView.contentOffset.y = newOffsetY + 500
        
        scrollView.delegate = self
        
//        view.addSubview(scrollView)
//        scrollView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//
//        scrollView.addSubview(label)
//        label.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
//            make.top.equalToSuperview().offset(10)
//        }
//
//        scrollView.addSubview(imageView)
//        imageView.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
//            make.top.equalTo(label.snp.bottom).offset(30)
//        }
//
//        scrollView.addSubview(imageView1)
//        imageView1.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
//            make.top.equalTo(imageView.snp.bottom).offset(30)
//        }
//
//        scrollView.addSubview(imageView2)
//        imageView2.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
//            make.top.equalTo(imageView1.snp.bottom).offset(400)
//            make.bottom.equalToSuperview().offset(-10)
//        }
        print("offset = \(self.scrollView.contentOffset)")
        tableView.delegate = self
//        UIView.animate(withDuration: 5) { [weak self] in
////            self?.scrollView.contentInset = UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50)
////            self?.scrollView.contentOffset = CGPoint(x: 50, y: 500)
//            self?.scrollView.setContentOffset(.init(x: 500, y: 500), animated: true)
//            print("offset = \(self?.scrollView.contentOffset)")
//        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        vw.snp.makeConstraints { make in
//            make.width.height.equalTo(100)
            make.edges.equalToSuperview()
        }
//        let newOffset = scrollView.contentOffset.y
//        scrollView.contentOffset = CGPoint(x: scrollView.contentOffset.x, y: newOffset + 100)
    }
}


extension DynamicScrollViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let name = datas[indexPath.row]
        cell.textLabel?.text = name
        return cell
    }
}

extension DynamicScrollViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("offset = \(scrollView.contentOffset)")
        if scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.bounds.height {
            // 이 경우는 스크롤이 다 되고나서 오버하러할때를 의미
//            scrollView.contentOffset.y += 1
            datas.append("안녕하세요")
            
        }
    }
}
