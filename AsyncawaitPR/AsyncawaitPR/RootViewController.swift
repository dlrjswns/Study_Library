//
//  RootViewController.swift
//  AsyncawaitPR
//
//  Created by 이건준 on 2022/10/08.
//

import UIKit

struct User: Codable {
    let name: String
}

class RootViewController: UIViewController {
    
    let url = URL(string: "https://jsonplacehm/user")
    
    private var users = [User]()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.dataSource = self
        
        Task {
            do {
                try await fetchUsers()
            } catch {
                print("catch = \(error)")
            }
        }
            
    }
    
    func fetchUsers() async throws {
        guard let url = url else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let json = try JSONSerialization.jsonObject(with: data)
        
        print("json = \(json)")
        
    }
}

extension RootViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row].name
        return cell
    }
}
