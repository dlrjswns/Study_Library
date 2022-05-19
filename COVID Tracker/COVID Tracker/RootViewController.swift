//
//  RootViewController.swift
//  COVID Tracker
//
//  Created by 이건준 on 2022/05/16.
//

import Charts
import UIKit

class RootViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    static let numberFormatter: NumberFormatter = {
       let formatter = NumberFormatter()
        formatter.locale = .current
        formatter.usesGroupingSeparator = true
        formatter.groupingSeparator = ","
        formatter.formatterBehavior = .default
        return formatter
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private var dayData: [DayData] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.createGraph()
            }
        }
    }
    
    private var scope: APICaller.DataScope = .national
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.prefersLargeTitles = true
        title = "Covid Cases"
        configureTable()
        createFilterButton()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func createGraph() {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.width/1.5))
        headerView.clipsToBounds = true
        
        var entries: [BarChartDataEntry] = []
        for index in 0..<dayData.count {
            let data = dayData[index]
            entries.append(.init(x: Double(index), y: Double(data.count)))
        }
        
        let dataSet = BarChartDataSet(entries: entries)
        
        let data: BarChartData = BarChartData(dataSet: dataSet)
        
        let chart = BarChartView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.width/1.5))
        chart.data = data
        headerView.addSubview(chart)
        tableView.tableHeaderView = headerView
    }
    
    private func configureTable() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func fetchData() {
        APICaller.shared.getCovidData(for: scope) { [weak self] result in
            switch result {
            case .success(let dayData):
                self?.dayData = dayData
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dayData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = dayData[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = createText(with: data)
        return cell
    }
    
    private func createText(with model: DayData) -> String? {
        let dateString = DateFormatter.prettyformatter.string(from: model.date)
        let total = Self.numberFormatter.string(from: NSNumber(value: model.count))
        return "\(dateString): \(total ?? "\(model.count)")"
    }
}
