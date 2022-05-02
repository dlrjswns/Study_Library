//
//  Beer.swift
//  BeerShop
//
//  Created by 이건준 on 2022/05/02.
//

//import Foundation

struct Beer: Decodable {
    let id: Int?
    let name: String?
    let tagline: String?
    let firstBrewed: String?
    let description: String?
    let imageUrl: String?
    let abv: Double?
    let ibu: Int?
    let targetFg: Int?
    let targetOg: Int?
    let ebc: Int?
    let srm: Int?
    let ph: Double?
    let attenuationLevel: Int?
    let volume: Volume?
    let boilVolume: Volume?
    let method: Method?
    let ingredients: Ingredient?
    let foodPairing: [String]?
    let brewersTips: String?
    let contributedBy: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, tagline, description, abv, ibu, ebc, srm, ph, volume, method, ingredients
        case firstBrewed = "first_brewed"
        case imageUrl = "image_url"
        case targetFg = "target_fg"
        case targetOg = "target_og"
        case attenuationLevel = "attenuation_level"
        case boilVolume = "boil_volume"
        case foodPairing = "food_pairing"
        case brewersTips = "brewers_tips"
        case contributedBy = "contributed_by"
    }
    
    init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try? value.decode(Int.self, forKey: .id)
        self.name = try? value.decode(String.self, forKey: .name)
        self.tagline = try? value.decode(String.self, forKey: .tagline)
        self.firstBrewed = try? value.decode(String.self, forKey: .firstBrewed)
        self.description = try? value.decode(String.self, forKey: .description)
        self.imageUrl = try? value.decode(String.self, forKey: .imageUrl)
        self.abv = try? value.decode(Double.self, forKey: .abv)
        self.ibu = try? value.decode(Int.self, forKey: .ibu)
        self.targetFg = try? value.decode(Int.self, forKey: .targetFg)
        self.targetOg = try? value.decode(Int.self, forKey: .targetOg)
        self.ebc = try? value.decode(Int.self, forKey: .ebc)
        self.srm = try? value.decode(Int.self, forKey: .srm)
        self.ph = try? value.decode(Double.self, forKey: .ph)
        self.attenuationLevel = try? value.decode(Int.self, forKey: .attenuationLevel)
        self.volume = try? value.decode(Volume.self, forKey: .volume)
        self.boilVolume = try? value.decode(Volume.self, forKey: .boilVolume)
        self.method = try? value.decode(Method.self, forKey: .method)
        self.ingredients = try? value.decode(Ingredient.self, forKey: .ingredients)
        self.foodPairing = try? value.decode([String].self, forKey: .foodPairing)
        self.brewersTips = try? value.decode(String.self, forKey: .brewersTips)
        self.contributedBy = try? value.decode(String.self, forKey: .contributedBy)
    }
}

struct Ingredient: Decodable {
    let malt: [Malt]
    let hops: [Hop]
    let yeast: String
}

struct Hop: Decodable {
    let name: String
    let amount: Volume
    let add: String
    let attribute: String
}

struct Malt: Decodable {
    let name: String
    let amount: Volume
}

struct Method: Decodable {
    let mashTemp: [MashTemp]
    let fermentation: FermentationTemp
    let twist: Int?
    
    enum CodingKeys: String, CodingKey {
        case mashTemp = "mash_temp"
        case fermentation, twist
    }
}

struct FermentationTemp: Decodable {
    let temp: Volume
}

struct MashTemp: Decodable {
    let temp: Volume
    let duration: Int
}

struct Volume: Decodable {
    let value: Int
    let unit: String
}
