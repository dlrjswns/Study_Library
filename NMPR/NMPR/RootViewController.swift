//
//  RootViewController.swift
//  NMPR
//
//  Created by 이건준 on 2022/05/08.
//

import UIKit
import NMapsMap
import CoreLocation

enum Gu {
    case 강동구청(Int)
    case 송파구청
    case 성남구청
    
    var textString: String {
        switch self {
        case .강동구청(let count):
            return "강동구 \(count)명"
        case .송파구청:
            return "송파구"
        case .성남구청:
            return "성남"
        }
    }
}

class RootViewController: UIViewController {
    
    private lazy var label: UILabel = {
       let label = UILabel()
        label.text = "안녕하세요 카메라"
        label.font = .systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    private let mapView: NMFNaverMapView = {
       let mapView = NMFNaverMapView()
//        mapView.
        return mapView
    }()
    
    private let searchBar: UISearchBar = {
       let searchBar = UISearchBar()
        searchBar.placeholder = "안녕하세요"
        return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        var locationManager = CLLocationManager()
        let mapView = NMFMapView(frame: view.frame)
        view.addSubview(mapView)
        
//        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            print("위치 서비스 On 상태")
            locationManager.startUpdatingLocation()
            print(locationManager.location?.coordinate)
        } else {
            print("위치 서비스 Off 상태")
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        searchBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        searchBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
//        let mapView1 = NMFMapView(frame: view.frame)
//        let mapView = NMFNaverMapView(frame: view.frame)
        view.addSubview(mapView)
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        mapView.frame = view.frame
//        mapView.mapView.mov
        
        
//        NMFCameraUpdate.
        
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: 39.566103, lng: 127.9783881)) // 첫 지도 위치초기화
        cameraUpdate.reason = 3
        cameraUpdate.animation = .fly
        cameraUpdate.animationDuration = 2
        
        mapView.mapView.moveCamera(cameraUpdate, completion: { (isCancelled) in // 지정해준 좌표로 카메라 이동, 성공 & 실패 여부 확인
            if isCancelled {
                print("카메라 이동 취소")
            } else {
                print("카메라 이동 성공")
            }
        })
        
        let marker = NMFMarker(position: NMGLatLng(lat: 39.566103, lng: 127.9783881)) // NMFMarker에 대한 좌표를 초기화
//        marker.touchHandler = { (overlay) in // NMFMarker를 클릭했을때의 액션 코드
//            print("마커 클릭됨")
//            return true
//        }
        marker.iconImage = NMFOverlayImage(image: UIImage(systemName: "heart.fill")!)
//        marker.
//        marker.iconImage = NMFOverlayImage(name: "a.jpeg")
        let infoWindo = NMFInfoWindow()
        let dataSource = NMFInfoWindowDefaultTextSource.data()
        dataSource.title = "안녕하세요"
        infoWindo.dataSource = dataSource
        infoWindo.open(with: marker)
        
        infoWindo.userInfo = ["info": Gu.강동구청(3)]
        
        
        let marker1 = NMFMarker(position: NMGLatLng(lat: 37.5666103, lng: 126.9783881))
        let marker2 = NMFMarker(position: NMGLatLng(lat: 38.5666103, lng: 126.9783881))
        let marker3 = NMFMarker()
        marker3.position = NMGLatLng(lat: 39.566103, lng: 127.9783881)
        marker3.touchHandler = { _ in
            print("marker3 클릭됨")
            return true
        }
        
//        infoWindo.open(with: marker1)
//        infoWindo.open(with: marker2)
//        infoWindo.open(with: marker3)
        
//        let dataSource = NMFInfoWindowDefaultTextSource.data()
//        let dataSource1 = NMFInfoWindowDefaultTextSource.data()
//        let dataSource2 = NMFInfoWindowDefaultTextSource.data()
//        dataSource.title = "이건준"
//        dataSource1.title = "이1건준"
//        dataSource2.title = "이건3준"
//        let info = NMFInfoWindow()
//        let info1 = NMFInfoWindow()
//        let info2 = NMFInfoWindow()
//        let info3 = NMFInfoWindow()
//        info.dataSource = dataSource
//        info.userInfo = ["info": Gu.성남구청]
//        info.position = NMGLatLng(lat: 37.5666103, lng: 126.9783881)
//        info.open(with: mapView.mapView)
//
//        info1.dataSource = dataSource1
//        info1.userInfo = ["info": Gu.성남구청]
//        info1.position = NMGLatLng(lat: 38.5666103, lng: 126.9783881)
//        info1.open(with: mapView.mapView)
//
//        info2.dataSource = dataSource2
//        info2.userInfo = ["info": Gu.성남구청]
//        info2.position = NMGLatLng(lat: 39.5666103, lng: 126.9783881)
//        info2.open(with: mapView.mapView)
//
//        info3.dataSource = dataSource
//        info3.userInfo = ["info": Gu.성남구청]
//        info3.position = NMGLatLng(lat: 36.5666103, lng: 126.9783881)
//        info3.open(with: mapView.mapView)
        
        
//        let dataSource = NMFInfoWindowDefaultTextSource.data()
        
        
        
//        dataSource.title = "서초구청 (100명)"
//        infoWindo.dataSource = dataSource

        marker.mapView = mapView.mapView; // 지정해준 NMFMarker를 NJFMapView에 찍어주는 코드
        marker1.mapView = mapView.mapView
        marker2.mapView = mapView.mapView
        marker3.mapView = mapView.mapView
        
        infoWindo.open(with: marker3) // marker를 먼저 mapView에 뿌려준 이후에 코드를 작성해야 보여짐
//        infoWindo.position = NMGLatLng(lat: 37.5666102, lng: 126.9783881)
//        infoWindo.open(with: mapView)
//        view(with: infoWindo)

        mapView.mapView.mapType = .basic
        
        
    }
}

extension RootViewController: NMFOverlayImageDataSource {
    func view(with overlay: NMFOverlay) -> UIView {
        let vw = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        vw.backgroundColor = .systemPink
        return vw
//        guard let gu = overlay.userInfo["info"] as? Gu else { return UIView(frame: .zero) }
//
//        switch gu {
//            case .강동구청(_):
//            print("sdfasdf")
//                let label = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
//                label.backgroundColor = .systemPink
//                label.text = gu.textString
//                return GuView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
//            case .성남구청:
//                let vw = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
//            vw.backgroundColor = .systemPink
//                return vw
//            case .송파구청:
//                return UIView(frame: .zero)
//        }
        
    }
}

class GuView: UIView {
    
    private let label: UILabel = {
       let label = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        label.text = "강동구 1명"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = .systemRed
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
