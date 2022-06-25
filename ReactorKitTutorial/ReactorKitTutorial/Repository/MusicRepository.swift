//
//  MusicRepository.swift
//  ReactorKitTutorial
//
//  Created by 이건준 on 2022/06/22.
//

import RxSwift

protocol MusicRepository {
    func fetchMusic() -> Observable<Result<[MusicData], Error>>
    func fetchData() -> [MusicData]
}

class MusicRepositoryImpl: MusicRepository {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchData() -> [MusicData] {
        do {
            guard let path = Bundle.main.path(forResource: "MyData", ofType: "json") else { return [] }
            guard let data = try String(contentsOfFile: path).data(using: .utf8) else { return [] }
            let musicData = try JSONDecoder().decode(Music.self, from: data)
            print("dfsdfsdf = \(musicData.musics)")
            return musicData.musics
        }
        catch {
            return []
        }
        

    }
    
    func fetchMusic() -> Observable<Result<[MusicData], Error>> {
        guard let request = getURLRequest() else {
            return Observable.just(.failure(URLError.badURL as! Error))
        }
        print("re = \(request)")
        return session.rx.data(request: request).map { data in
            do {
                let musicData = try JSONDecoder().decode(Music.self, from: data)
                print("musicdata = \(musicData)")
                return .success(musicData.musics)
            } catch {
                print("sdfasdf")
                return .failure(URLError.badURL as! Error)
            }
        }
    }
}

extension MusicRepositoryImpl {
    struct MyData {
        static let forResource = "MyData"
        static let withExtension = "json"
    }
    
    private func getURLRequest() -> URLRequest? {
        guard let url = Bundle.main.url(forResource: MyData.forResource, withExtension: MyData.withExtension) else {
            return nil
        }
        
        let request = URLRequest(url: url)
        return request
        
    }
}
