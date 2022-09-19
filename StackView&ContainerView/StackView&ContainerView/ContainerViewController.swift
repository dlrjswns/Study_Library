//
//  ContainerViewController.swift
//  StackView&ContainerView
//
//  Created by 이건준 on 2022/09/13.
//

import UIKit

class ContainerCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ContainerCollectionViewCell"
    
    private let label: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .label
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(didPressedLabel))
        longGesture.minimumPressDuration = 0.5
        label.addGestureRecognizer(longGesture)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didPressedLabel(_ gesture: UILongPressGestureRecognizer) {
//        gesture.lo
    }
    
    private func configureUI() {
        contentView.backgroundColor = .secondarySystemBackground
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
    
    private let models = ["전체", "건준", "진우"]
    
    private let vcModels = [FirstViewController(), SecondViewController(), ThirdViewController()]
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .secondarySystemBackground
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        _ = vcModels.map { vc in
            if let firstVC = vc as? FirstViewController {
                firstVC.dataSource = self
            }
        }
        print("text = \("안녕    하세요".trimmingCharacters(in: .whitespaces))")
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        collectionView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        collectionView.register(ContainerCollectionViewCell.self, forCellWithReuseIdentifier: ContainerCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setContainerVC(childViewController: UIViewController) {
//        UIView.animate(withDuration: 1) {
            self.addChild(childViewController)
            self.view.addSubview(childViewController.view)
            childViewController.view.frame = CGRect(x: 180, y: 180, width: 200, height: 200)
            childViewController.didMove(toParent: self)
            childViewController.beginAppearanceTransition(true, animated: true)
//        }
    }
}

extension ContainerViewController: FirstViewControllerDataSource {
    let title: String = ""
}

extension ContainerViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContainerCollectionViewCell.identifier, for: indexPath) as? ContainerCollectionViewCell ?? ContainerCollectionViewCell()
        cell.configureUI(with: models[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
//        let imageToShare: UIImage = UIImage(systemName: "heart.fill")!
//        let urlToShare: String = "http://www.edwith.org/boostcourse-ios"
//        let textToShare: String = "안녕하세요, 부스트 코스입니다."
//
//        let activityViewController = UIActivityViewController(activityItems: [imageToShare, urlToShare, textToShare], applicationActivities: nil)
//
//        // 2. 기본으로 제공되는 서비스 중 사용하지 않을 UIActivityType 제거(선택 사항)
////        activityViewController.excludedActivityTypes = [UIActivity.ActivityType.addToReadingList, UIActivity.ActivityType.assignToContact]
//
//        // 3. 컨트롤러를 닫은 후 실행할 완료 핸들러 지정
//        activityViewController.completionWithItemsHandler = { (activity, success, items, error) in
//            if success {
//            // 성공했을 때 작업
//           }  else  {
//            // 실패했을 때 작업
//           }
//        }
//        // 4. 컨트롤러 나타내기(iPad에서는 팝 오버로, iPhone과 iPod에서는 모달로 나타냅니다.)
//        self.present(activityViewController, animated: true, completion: nil)
        
        setContainerVC(childViewController: vcModels[indexPath.row])
    }
}





protocol FirstViewControllerDataSource: AnyObject {
    var title: String { get }
}

class FirstViewController: UIViewController {
    
    weak var dataSource: FirstViewControllerDataSource?
    
    private let label: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .label
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.bounds = view.bounds
        label.text = dataSource?.title
    }
    
    override func didMove(toParent parent: UIViewController?) {
        print("앙 기모찌 firstVC")
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
        view.backgroundColor = .systemOrange
    }
}

extension UIViewController {
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    func remove() {
        // Just to be safe, we check that this view controller
        // is actually added to a parent before removing it.
        guard parent != nil else {
            return
        }

        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
