//
//  RootViewController.swift
//  NMPR
//
//  Created by 이건준 on 2022/05/08.
//

import UIKit
import NMapsMap

class RootViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        
        let mapView = NMFMapView(frame: view.frame)
        view.addSubview(mapView)
        
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: 37.5666102, lng: 126.9783881)) // 첫 지도 위치초기화
        cameraUpdate.reason = 3
        cameraUpdate.animation = .fly
        cameraUpdate.animationDuration = 2
        mapView.moveCamera(cameraUpdate, completion: { (isCancelled) in // 지정해준 좌표로 카메라 이동, 성공 & 실패 여부 확인
            if isCancelled {
                print("카메라 이동 취소")
            } else {
                print("카메라 이동 성공")
            }
        })
        
        let marker = NMFMarker(position: NMGLatLng(lat: 37.5670135, lng: 126.9783740)) // NMFMarker에 대한 좌표를 초기화
        marker.touchHandler = { (overlay) in // NMFMarker를 클릭했을때의 액션 코드
            print("마커 클릭됨")
            return true
        }
        marker.mapView = mapView; // 지정해준 NMFMarker를 NJFMapView에 찍어주는 코드
        mapView.mapType = .basic
        mapView.mapType = .hybrid
        mapView.mapType = .navi
        mapView.mapType = .none
        mapView.mapType = .satellite
        mapView.mapType = .terrain
        
        let mv = NMFNaverMapView(frame: view.frame)
//        marker.mapView = mv
        
//        marker.mapView = mv
        
//        marker.mapView = NMFNaverMapView()
        
    }
}
