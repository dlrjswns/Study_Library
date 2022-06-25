//
//  MusicReactor.swift
//  ReactorKitTutorial
//
//  Created by 이건준 on 2022/06/22.
//

import ReactorKit

class MusicReactor: Reactor {
    private let usecase: MusicUsecase
    
    var disposeBag = DisposeBag()
    
    init(usecase: MusicUsecase) {
        self.usecase = usecase
    }
    
    enum Action {
        case viewWillAppear
    }
    
    struct State {
        var music: [MusicData]
    }
    
    var initialState: State {
        return State(music: [])
    }
    
    enum Mutation {
        case initialMusicData
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewWillAppear:
            return Observable.just(Mutation.initialMusicData)
        }
//        return Observable.just(Mutation.initialMusicData)
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state: State = state
        switch mutation {
        case .initialMusicData:
            state.music = usecase.fetchData()
//            let fetchResult = usecase.fetchMusic()
//
//            fetchResult.subscribe(onNext: { data in
//                print("sdfdsaf = \(data)")
//            }).disposed(by: disposeBag)
//
//            let fetchSuccess = fetchResult.map { result -> [MusicData]? in
//                guard case .success(let musicDatas) = result else { return nil }
//                return musicDatas
//            }
//
//            fetchSuccess.subscribe(onNext: { musicDatas in
//                guard let musicDatas = musicDatas else { return }
//                state.music = musicDatas
//                print("dsfdsf = \(musicDatas)")
//            }).disposed(by: disposeBag)
//
//            let fetchFailure = fetchResult.map { result -> Error? in
//                guard case .failure(let error) = result else { return nil }
//                return error
//            }
//
//            fetchFailure.subscribe(onNext: { error in
//                print("erro = \(error)")
//            })
//            .disposed(by: disposeBag)
        }
//        switch mutation {
//            case .initialMusicData:
//                state = usecase.fetchMusic()
//        }
        return state
    }
    
    
}
