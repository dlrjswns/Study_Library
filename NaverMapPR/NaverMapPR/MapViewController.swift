//
//  MapViewController.swift
//  NaverMapPR
//
//  Created by 이건준 on 2022/05/06.
//

import UIKit
import NMapsMap

class MapViewController: UIViewController {
    
//    let mapView = NMFNaverMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
//        let mapView = NMFMapView(frame: view.frame)
        let mapView = NMFNaverMapView(frame: view.frame)
            view.addSubview(mapView)
    }
}
