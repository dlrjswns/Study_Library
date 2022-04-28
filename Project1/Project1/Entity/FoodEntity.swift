//
//  FoodEntity.swift
//  Project1
//
//  Created by 이건준 on 2022/04/28.
//

import Foundation

struct FoodEntity: Decodable {
    let foodImageID: Int?
    let foodStoreID: String?
    let foodStoreName: String?
    let resionName: String?
    let menuID: Int?
    let foodImageString: String?
    
    enum CodingKeys: String, CodingKey {
        case foodImageID = "음식이미지(ID)"
        case foodStoreID = "식당(ID)"
        case foodStoreName = "식당명"
        case resionName = "지역명"
        case menuID = "메뉴(ID)"
        case foodImageString = "음식이미지(URL)"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.foodImageID = try? values.decode(Int.self, forKey: .foodImageID)
        self.foodStoreID = try? values.decode(String.self, forKey: .foodStoreID)
        self.foodStoreName = try? values.decode(String.self, forKey: .foodStoreName)
        self.resionName = try? values.decode(String.self, forKey: .resionName)
        self.menuID = try? values.decode(Int.self, forKey: .menuID)
        self.foodImageString = try? values.decode(String.self, forKey: .foodImageString)
    }
}

//음식이미지(ID)": 0,
//      "식당(ID)": 0,
//      "식당명": "string",
//      "지역명": "string",
//      "메뉴(ID)": 0,
//      "음식이미지(URL)": "string"
