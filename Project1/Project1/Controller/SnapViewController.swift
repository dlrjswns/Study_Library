//
//  SnapViewController.swift
//  Project1
//
//  Created by 이건준 on 2022/04/29.
//

import UIKit
import SnapKit

class SnapViewController: UIViewController {
    
    let redView: UIView = {
       let vw = UIView()
        vw.backgroundColor = .red
        return vw
    }()
    
    let blueView: UIView = {
       let vw = UIView()
        vw.backgroundColor = .blue
        return vw
    }()
    
    let greenView: UIView = {
       let vw = UIView()
        vw.backgroundColor = .green
        return vw
    }()
    
    let pinkView: UIView = {
       let vw = UIView()
        vw.backgroundColor = .systemPink
        return vw
    }()
    
    let orangeView: UIView = {
       let vw = UIView()
        vw.backgroundColor = .orange
        return vw
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            let r = try Router.get(["query": "이건준사랑"]).asURLRequest().url
            print("r = \(r!)")
        }
        catch {
            
        }
        
        
        view.backgroundColor = .systemBackground
        
        blueView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapBlueView))
        blueView.addGestureRecognizer(tap)
        
        view.addSubview(redView)
        redView.snp.makeConstraints { make in
//            make.edges.equalTo(view.safeAreaLayoutGuide)
//            make.center.equalToSuperview()
            make.width.height.equalTo(300)
        }
        
        redView.addSubview(blueView)
        blueView.snp.makeConstraints { make in
            make.height.equalTo(200)
//            make.width.equalToSuperview().multipliedBy(0.5)
            make.width.equalTo(redView.snp.width).multipliedBy(0.5)
            make.bottom.equalTo(redView.snp.bottom).inset(20)
        }
    }
    
    @objc func didTapBlueView() {
        blueView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }
        
//        blueView.snp.makeConstraints { make in
//            make.height.equalTo(300)
//        }
    }
    
    
}
