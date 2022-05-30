//
//  BottomPopupViewController.swift
//  KakaoMapPR
//
//  Created by 이건준 on 2022/05/30.
//

import UIKit

class BottomPopupViewController: UIViewController {
    
    private let dimmedView: UIView = {
       let vw = UIView()
        vw.backgroundColor = .gray.withAlphaComponent(0.7)
        return vw
    }()
    
    private let bottomSheetView: UIView = {
       let vw = UIView()
        vw.backgroundColor = .white
        vw.layer.cornerRadius = 10
        vw.clipsToBounds = true
        return vw
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(dimmedView)
        dimmedView.translatesAutoresizingMaskIntoConstraints = false
        dimmedView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        dimmedView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        dimmedView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        dimmedView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        view.addSubview(bottomSheetView)
        bottomSheetView.translatesAutoresizingMaskIntoConstraints = false
        bottomSheetView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        bottomSheetView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        bottomSheetView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        bottomSheetView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -180).isActive = true
    }
}
