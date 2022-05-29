//
//  RootViewController.swift
//  WaterFallCollectionView
//
//  Created by 이건준 on 2022/05/13.
//

import CHTCollectionViewWaterfallLayout
import UIKit

struct Model {
    let imageName: String
    let height: CGFloat
}

class RootViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 30, height: models[indexPath.row].height)
    }
    
    
    private var models: [Model] = []

    private let collection: UICollectionView = {
        let layout = CHTCollectionViewWaterfallLayout()
        layout.itemRenderDirection = .leftToRight
        layout.columnCount = 2
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        guard let data = UIImage(named: "image1")?.pngData() else { return }
//        let imageString = data.base64EncodedString(options: .endLineWithCarriageReturn)
//        print("imageString = \(imageString)")
        collection.delegate = self
        collection.dataSource = self
        collection.register(WaterCollectionViewCell.self, forCellWithReuseIdentifier: WaterCollectionViewCell.identifier)
        
        let imageNames = Array(1...7).compactMap { n in
            return "image\(n)"
        }
        
        models = imageNames.map({ imageName in
            return Model(imageName: imageName, height: CGFloat.random(in: 30...80))
        })
        
        view.addSubview(collection)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collection.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collection.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collection.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        print("count = \(imageNames.count)")
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WaterCollectionViewCell.identifier, for: indexPath) as! WaterCollectionViewCell
        print("name = \(models[indexPath.row])")
        cell.configureCell(with: models[indexPath.row])
        return cell
    }
}
