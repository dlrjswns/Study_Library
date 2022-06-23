//
//  Music.swift
//  ReactorKitTutorial
//
//  Created by 이건준 on 2022/06/22.
//

struct Music: Decodable {
    let musics: [MusicData]
}

struct MusicData: Decodable {
    let name: String
    let title: String
    let date: String
}
