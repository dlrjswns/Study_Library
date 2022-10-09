//
//  RootViewController.swift
//  TabmanPR
//
//  Created by 이건준 on 2022/10/03.
//

import UIKit
import Tabman
import Pageboy

class RootViewController: TabmanViewController {
    
    private var viewControllers = [UIViewController]()
    
    private let tabView: UIView = {
       let vw = UIView()
        return vw
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        configureUI()
        
        let vc = UIViewController()
        vc.view.backgroundColor = .red
        
        let vc1 = UIViewController()
        vc1.view.backgroundColor = .blue
        
        let vc2 = UIViewController()
        vc2.view.backgroundColor = .orange
        
        let vc3 = UIViewController()
        vc3.view.backgroundColor = .systemPink
        
        let vc4 = UIViewController()
        vc4.view.backgroundColor = .green
        
//        viewControllers.append(contentsOf: [vc, vc1, vc2, vc3, vc4])
        viewControllers.append(vc)
        viewControllers.append(vc1)
        viewControllers.append(vc2)
        viewControllers.append(vc3)
        viewControllers.append(vc4)
        
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(tabView)
        tabView.translatesAutoresizingMaskIntoConstraints = false
        tabView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        tabView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tabView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
//        tabView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        self.dataSource = self
        let tabbar = TMBar.ButtonBar()
        tabbar.layout.alignment = .centerDistributed
        tabbar.buttons.customize { button in
            button.backgroundColor = .systemMint
        }
//        tabbar.dataSource = self
        
        addBar(tabbar, dataSource: self, at: .custom(view: tabView, layout: nil))
//        view.addSubview(tabBar)
//        tabBar.translatesAutoresizingMaskIntoConstraints = false
//        tabBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        tabBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
//        tabBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}

extension RootViewController: TMBarDataSource, PageboyViewControllerDataSource {
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        switch index {
        case 0:
            return TMBarItem(title: "전체")
        case 1:
            return TMBarItem(title: "프로젝트")
        case 2:
            return TMBarItem(title: "스터디")
        case 3:
            return TMBarItem(title: "학습")
        case 4:
            return TMBarItem(title: "이미지")
        default:
            return TMBarItem(title: "전체")
        }
    }
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
    
    
}
