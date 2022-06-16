//
//  BottomPopupViewController.swift
//  KakaoMapPR
//
//  Created by 이건준 on 2022/05/30.
//

import UIKit

class BottomPopupViewController: UIViewController {
    
    let dimmedView: UIView = {
       let vw = UIView()
        vw.backgroundColor = .gray.withAlphaComponent(0.7)
        vw.alpha = 0
        return vw
    }()
    
    let bottomSheetView: UIView = {
       let vw = UIView()
        vw.backgroundColor = .white
        vw.layer.cornerRadius = 10
        vw.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
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
//        bottomSheetView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -180).isActive = true
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTappdDimmedView))
        dimmedView.addGestureRecognizer(tap)
        
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeBottomSheet))
        swipe.direction = .down
        bottomSheetView.addGestureRecognizer(swipe)
    }
    
    @objc func didSwipeBottomSheet() {
        UIView.animate(withDuration: 3, delay: 0) { [weak self] in
            self?.dimmedView.alpha = 0
            self?.bottomSheetView.topAnchor.constraint(equalTo: self!.view.bottomAnchor).isActive = true
            self?.dismiss(animated: true)
            self?.view.layoutIfNeeded()
        }
    }
    
    @objc func didTappdDimmedView() {
        self.dismiss(animated: true)
    }
}
