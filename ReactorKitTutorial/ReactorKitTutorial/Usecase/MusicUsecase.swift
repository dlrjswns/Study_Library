//
//  MusicUsecase.swift
//  ReactorKitTutorial
//
//  Created by 이건준 on 2022/06/22.
//

import RxSwift

protocol MusicUsecase {
    func fetchMusic() -> Observable<Result<[MusicData], Error>>
}

class MusicUsecaseImpl: MusicUsecase {
    private let repository: MusicRepository
    
    init(repository: MusicRepository) {
        self.repository = repository
    }
    
    func fetchMusic() -> Observable<Result<[MusicData], Error>> {
        print("sdfsdf")
        return repository.fetchMusic()
    }
}
