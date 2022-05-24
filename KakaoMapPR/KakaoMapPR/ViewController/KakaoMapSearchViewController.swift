//
//  KakaoMapSearchViewController.swift
//  KakaoMapPR
//
//  Created by 이건준 on 2022/05/23.
//

import UIKit
import RxSwift
import RxCocoa

class KakaoMapSearchViewController: UIViewController {
    
    private let viewModel: KakaoMapViewModelType
    
    var disposeBag = DisposeBag()
    
    let tabLabelNames = ["My Home", "My School", "My GYM", "Jamsil Station"]
    
    let tabMapLocations = [
        MapLocation(latitude: 37.50129, longitude: 127.12865),
        MapLocation(latitude: 37.64816, longitude: 127.06216),
        MapLocation(latitude: 37.66641, longitude: 127.07222),
        MapLocation(latitude: 37.51491, longitude: 127.10408)
    ]
    
    init(viewModel: KakaoMapViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let highlightView: UIView = {
       let vw = UIView()
        vw.backgroundColor = .black
        return vw
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(KakaoMapTabViewCell.self, forCellWithReuseIdentifier: KakaoMapTabViewCell.identifier)
        return collectionView
    }()
    
    private let searchBar: UISearchBar = {
       let searchBar = UISearchBar()
        searchBar.placeholder = "장소를 검색"
        searchBar.backgroundColor = .systemBackground
        return searchBar
    }()
    
    private let mapView: MTMapView = {
       let vw = MTMapView()
        return vw
    }()
    
    private let myPoint: MTMapPOIItem = {
       let point = MTMapPOIItem()
        point.itemName = "건준이의 집입니당핡"
        point.markerType = MTMapPOIItemMarkerType.customImage
        point.customImage = UIImage(systemName: "heart.fill")
        
        return point
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        mapView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10).isActive = true
        mapView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        mapView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(view.frame.height / 3)).isActive = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
//        view.addSubview(highlightView)
//        highlightView.translatesAutoresizingMaskIntoConstraints = false
        
        myPoint.mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude: 37.50129, longitude: 127.12865))
        mapView.addPOIItems([myPoint])
        mapView.setMapCenter(MTMapPoint(geoCoord: MTMapPointGeo(latitude: 40.50129, longitude: 127.12865)), zoomLevel: 4, animated: true)
    
        self.navigationItem.titleView = searchBar
        collectionView.delegate = self
        collectionView.dataSource = self
        initialTappdCollectionView()
        bind()
    }
    
    private func setMarker(markerName: String, mapLocation: MapLocation) {
        myPoint.itemName = markerName
        mapView.setMapCenter(MTMapPoint(geoCoord: .init(latitude: mapLocation.latitude, longitude: mapLocation.longitude)), animated: true)
    }
    
    private func initialTappdCollectionView() {
        let indexPath = IndexPath(item: 0, section: 0) // First Tab
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        setMarker(markerName: tabLabelNames[0], mapLocation: tabMapLocations[0])
    }
    
    private func bind() {
        searchBar.rx.text.orEmpty.debounce(.seconds(1), scheduler: ConcurrentDispatchQueueScheduler.init(qos: .default)).bind(to: viewModel.querySearch)
            .disposed(by: disposeBag)
        
        viewModel.searchResultOutput.drive(onNext: { result in
            print("result = \(result)")
        }).disposed(by: disposeBag)
    }
}

extension KakaoMapSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabLabelNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KakaoMapTabViewCell.identifier, for: indexPath) as! KakaoMapTabViewCell
        
        let model = tabLabelNames[indexPath.row]
        cell.configureCell(with: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return collectionView.frame.width / 5 / 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 5, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: collectionView.frame.width / 5 / 6, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mapLocation = tabMapLocations[indexPath.row]
        let markerName = tabLabelNames[indexPath.row]
        setMarker(markerName: markerName, mapLocation: mapLocation)
//        let mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude: mapLocation.latitude, longitude: mapLocation.longitude))
//        mapView.setMapCenter(mapPoint, animated: true)
    }
}


