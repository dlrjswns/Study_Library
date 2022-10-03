//
//  RootViewController.swift
//  StackView&ContainerView
//
//  Created by 이건준 on 2022/10/03.
//

import UIKit

class RootViewCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "RootViewCollectionViewCell"
    
    private let imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    public func configureUI(with model: String) {
        imageView.image = UIImage(systemName: model)
    }
}

class RootViewController: UIViewController {
    
    private let imageNames = [
        "heart.fill",
        "heart.",
        "person.fill",
        "person",
        "heart.fill"
    ]
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 5
        pageControl.backgroundColor = .systemRed
        pageControl.pageIndicatorTintColor = .blue
        return pageControl
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height - 100)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setCollectionView(collectionView)
        
        pageControl.addTarget(self, action: #selector(pageControlChanged), for: .valueChanged)
    }
    
    @objc private func pageControlChanged(_ sender: UIPageControl) {
        print("currnetPage = \(sender.currentPage)")
        let currentPage = sender.currentPage
        collectionView.setContentOffset(CGPoint(x: currentPage * Int(view.frame.width), y: 0), animated: true)
//        collectionView.scrollToItem(at: IndexPath(row: sender.currentPage, section: 0), at: .left, animated: true)
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        pageControl.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        pageControl.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: view.frame.height - 100).isActive = true
    }
    
    private func setCollectionView(_ collectionView: UICollectionView) {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(RootViewCollectionViewCell.self, forCellWithReuseIdentifier: RootViewCollectionViewCell.identifier)
    }
}

extension RootViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        guard let index = collectionView.indexPathForItem(at: scrollView.contentOffset) else {
//            return
//        }
//        print("row = \(index.row)")
//        pageControl.currentPage = index.row
        
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        // 이건 해당 셀의 크기가 view.frame.width일때
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RootViewCollectionViewCell.identifier, for: indexPath) as? RootViewCollectionViewCell ?? RootViewCollectionViewCell()
        cell.configureUI(with: imageNames[indexPath.row])
        return cell
    }
}
