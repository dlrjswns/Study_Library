//
//  ViewController.swift
//  KakaoMapPR
//
//  Created by 이건준 on 2022/05/22.
//

import UIKit

class ViewController: UIViewController {

    let mapView: MTMapView = {
       let vw = MTMapView()
        return vw
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(mapView)
        mapView.frame = view.bounds
    }


}

