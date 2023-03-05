//
//  TitleViewController.swift
//  RxDelegateProxyPR
//
//  Created by 이건준 on 2023/01/12.
//

import UIKit

class TitleViewController: UIViewController {
  
  private let button: UIButton = {
    let btn = UIButton()
    btn.setTitle("dfdf", for: .normal)
    btn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
    btn.sizeToFit()
    return btn
  }()
  
  private let label: UILabel = {
    let label = UILabel()
    label.textColor = .red
    label.font = .systemFont(ofSize: 12)
    label.text = "예술"
    return label
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    self.navigationController?.navigationBar.topItem?.titleView = NavigationView()
    
    let space = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
    space.width = 30
    self.navigationItem.leftBarButtonItems = [
      space,
      UIBarButtonItem(customView: button),
      space,
      UIBarButtonItem(customView: label)
    ]
  }
}

class NavigationView: UIView {
  
  private lazy var stackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [imageView, label])
    stackView.alignment = .leading
    return stackView
  }()
  
  private let imageView = UIImageView(image: UIImage(systemName: "person.fill"))
  
  private let label: UILabel = {
    let label = UILabel()
    label.text = "예술"
    label.textColor = .orange
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubview(stackView)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    stackView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
    stackView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
