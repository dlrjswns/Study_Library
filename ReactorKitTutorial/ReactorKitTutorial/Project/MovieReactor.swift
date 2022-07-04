//
//  MovieReactor.swift
//  ReactorKitTutorial
//
//  Created by 이건준 on 2022/07/04.
//

import ReactorKit

class MovieReactor: Reactor {
    
    private let usecase: MovieUsecase
    
    var disposeBag = DisposeBag()
    
    init(usecase: MovieUsecase) {
        self.usecase = usecase
    }
    
    enum Action {
        
    }
    
    enum Mutation {
        
    }
    
    struct State {
        let popularMovies: [PopularMovie]?
        let movieError: MovieError?
    }
    
    var initialState: State {
        var popularMovieList: [PopularMovie]?
        var movieError: MovieError?
        usecase.getMoviePopular().subscribe(onNext: { result in
            switch result {
                case .success(let popularMovie):
                    popularMovieList = popularMovie.popularMovieList
                case .failure(let error):
                    movieError = error
            }
        }).disposed(by: disposeBag)
        
        return State(popularMovies: popularMovieList, movieError: movieError)
    }
    
//    func mutate(action: Action) -> Observable<Mutation> {
//        <#code#>
//    }
//
//    func reduce(state: State, mutation: Mutation) -> State {
//        <#code#>
//    }
}
