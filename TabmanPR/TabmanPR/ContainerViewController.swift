//
//  ContainerViewController.swift
//  TabmanPR
//
//  Created by 이건준 on 2022/10/04.
//

import UIKit

class FirstViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
    }
}

class SecondViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
    }
}

class ThirdViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
    }
}

class FourthViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemOrange
    }
}

class TabCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TabCollectionViewCell"
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
//        label.sizeToFit()
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
        contentView.backgroundColor = .systemBackground
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        label.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    public func configureUI(with model: String) {
        label.text = model
    }
}

class ContainerViewController: UIViewController {
    
    private var viewControllrs = [UIViewController]()
    private let tabLabelTexts = ["전체", "스터디", "프로젝트", "공부", "운동"]
    
    private let bottomView: UIView = {
        let vw = UIView()
        vw.backgroundColor = .blue
        return vw
    }()
    
    private lazy var tabCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: Int(view.frame.width) / tabLabelTexts.count, height: 50)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .orange
        return collectionView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
//        scrollView.
//        scrollView.contentSize = CGSize(width: view.frame.width * 5, height: view.frame.height - 60)
        return scrollView
    }()
    
    private let floatingButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setCollectionView(tabCollectionView)
        
        view.addSubview(bottomView)
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(floatingButton)
        floatingButton.translatesAutoresizingMaskIntoConstraints = false
        floatingButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        floatingButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        floatingButton.addTarget(self, action: #selector(didTappedButton), for: .touchUpInside)
        
    }
    
    @objc private func didTappedButton() {
        UIView.animate(withDuration: 1) { [weak self] in
            self?.bottomView.heightAnchor.constraint(equalToConstant: 100).isActive = true
            self?.bottomView.layoutIfNeeded()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for a in 0..<viewControllrs.count {
            print("d = \(scrollView.frame.width)")
            viewControllrs[a].view.frame = CGRect(x: CGFloat(a) * scrollView.frame.width, y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
        }
        
        bottomView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        bottomView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        bottomView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        let firstVC = FirstViewController()
        let secondVC = SecondViewController()
        let thirdVC = ThirdViewController()
        let fourthVC = FourthViewController()
        viewControllrs.append(firstVC)
        viewControllrs.append(secondVC)
        viewControllrs.append(thirdVC)
        viewControllrs.append(fourthVC)
        
//        for a in 0..<viewControllrs.count {
//            viewControllrs[a].view.frame = CGRect(x: CGFloat(a) * scrollView.frame.width, y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
//        }
        
        addChild(firstVC)
        addChild(secondVC)
        addChild(thirdVC)
        addChild(fourthVC)
        
//        view.addSubview(firstVC.view)
//        view.addSubview(secondVC.view)
//        view.addSubview(thirdVC.view)
//        view.addSubview(fourthVC.view)
        
        view.addSubview(tabCollectionView)
        tabCollectionView.translatesAutoresizingMaskIntoConstraints = false
        tabCollectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tabCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tabCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tabCollectionView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: tabCollectionView.bottomAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        scrollView.addSubview(firstVC.view)
        scrollView.addSubview(secondVC.view)
        scrollView.addSubview(thirdVC.view)
        scrollView.addSubview(fourthVC.view)
    }
    
    private func setCollectionView(_ collectionView: UICollectionView) {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TabCollectionViewCell.self, forCellWithReuseIdentifier: TabCollectionViewCell.identifier)
    }
}

extension ContainerViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabLabelTexts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TabCollectionViewCell.identifier, for: indexPath) as? TabCollectionViewCell ?? TabCollectionViewCell()
        cell.configureUI(with: tabLabelTexts[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let currentOffset = scrollView.contentOffset
        scrollView.setContentOffset(CGPoint(x: currentOffset.x + view.frame.width, y: 0), animated: true)
    }
}

