//
//  KakaoMapEntity.swift
//  KakaoMapPR
//
//  Created by 이건준 on 2022/05/23.
//

import Foundation

struct KakaoMapLocations: Decodable {
    let documents: [KakaoMapLocation]
}

struct KakaoMapLocation: Decodable {
    let addressName: String?
    let categoryGroupCode: String?
    let categoryGroupName: String?
    let categoryName: String?
    let distance: String?
    let id: String?
    let phone: String
    let placeName: String
    let placeUrl: String?
    let roadAddressName: String?
    let x: String
    let y: String
    
    enum CodingKeys: String, CodingKey {
        case addressName = "address_name"
        case categoryGroupCode = "category_group_code"
        case categoryGroupName = "category_group_name"
        case categoryName = "category_name"
        case placeName = "place_name"
        case placeUrl = "place_url"
        case roadAddressName = "road_address_name"
        case distance, id, phone, x, y
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.addressName = try? values.decode(String.self, forKey: .addressName)
        self.categoryGroupCode = try? values.decode(String.self, forKey: .categoryGroupCode)
        self.categoryGroupName = try? values.decode(String.self, forKey: .categoryGroupName)
        self.categoryName = try? values.decode(String.self, forKey: .categoryName)
        self.distance = try? values.decode(String.self, forKey: .distance)
        self.id = try? values.decode(String.self, forKey: .id)
        self.phone = try values.decode(String.self, forKey: .phone)
        self.placeName = try values.decode(String.self, forKey: .placeName)
        self.placeUrl = try? values.decode(String.self, forKey: .placeUrl)
        self.roadAddressName = try? values.decode(String.self, forKey: .roadAddressName)
        self.x = try values.decode(String.self, forKey: .x)
        self.y = try values.decode(String.self, forKey: .y)
    }
}
