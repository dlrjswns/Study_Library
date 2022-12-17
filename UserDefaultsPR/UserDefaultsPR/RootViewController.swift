//
//  RootViewController.swift
//  UserDefaultsPR
//
//  Created by 이건준 on 2022/12/17.
//

import UIKit

struct MapCoordinate: Codable {
    let latitude: Double
    let longitude: Double
}

struct UserDefaultsManager {
    @UserDefaultWrapper(key: "checkEvnetViewWillAppear", defaultValue: 1)
    static var checkEventViewWillAppear1
    @UserDefaultWrapper(key: "checkEvnetViewWillAppear", defaultValue: 1.09988)
    static var checkEventViewWillAppear2
    @UserDefaultWrapper(key: "checkEvnetViewWillAppear", defaultValue: "dk")
    static var checkEventViewWillAppear3
    @UserDefaultWrapper(key: "checkEvnetViewWillAppear", defaultValue: false)
    static var checkEventViewWillAppear
    
    @UserDefaultWrapper(key: "currentLocation", defaultValue: MapCoordinate(latitude: 30, longitude: 30))
    static var currentLocation
}

@propertyWrapper
fileprivate struct UserDefaultWrapper<T: Codable> {
    private let key: String
    private let defaultValue: T

    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T? {
        get {
            if let savedData = UserDefaults.standard.object(forKey: key) as? Data {
                let decoder = JSONDecoder()
                if let lodedObejct = try? decoder.decode(T.self, from: savedData) {
                    return lodedObejct
                }
            }
            return defaultValue
        }
        set {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(newValue) {
                UserDefaults.standard.setValue(encoded, forKey: key)
            }
        }
    }
}

class RootViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        print("currentLocation = \(UserDefaultsManager.currentLocation)")
        UserDefaultsManager.currentLocation = MapCoordinate(latitude: 31, longitude: 31)
        print("afterLocation = \(UserDefaultsManager.currentLocation)")
        
        print("a = \(UserDefaultsManager.checkEventViewWillAppear1)")
        
        print("b = \(UserDefaultsManager.checkEventViewWillAppear2)")
        
        print("c = \(UserDefaultsManager.checkEventViewWillAppear3)")
    }
}
