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
    
    let initialState: State = State(popularMovies: [])
    
    init(usecase: MovieUsecase) {
        self.usecase = usecase
    }
    
    enum Action {
        case viewDidLoad
    }
    
    enum Mutation {
        case fetchPopularMovie([PopularMovie]?)
    }
    
    struct State {
        var popularMovies: [PopularMovie]?
//        let movieError: MovieError?
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            let moviePopularResult = usecase.getMoviePopular()
            
            let popularMoviesSuccess = moviePopularResult.map { result -> [PopularMovie]? in
                guard case .success(let popularMovies) = result else { return nil }
                return popularMovies.popularMovieList
            }
            
            return popularMoviesSuccess.map { popularMovies -> Mutation in
                return Mutation.fetchPopularMovie(popularMovies)
            }
            
//            let popularMoviewFailure = moviePopularResult.map { result -> MovieError? in
//                guard case .failure(let error) = result else { return nil }
//                return error
//            }
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
            case .fetchPopularMovie(let popularMovies):
            newState.popularMovies = popularMovies
            }
        print("state = \(newState)")
        return newState
    }
}
