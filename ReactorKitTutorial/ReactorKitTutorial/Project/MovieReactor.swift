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
        case searchMovie(String)
    }
    
    enum Mutation {
        case fetchPopularMovie([PopularMovie]?)
        case fetchSearchMovie([Movie]?)
    }
    
    struct State {
        var popularMovies: [PopularMovie]?
        var searchMovies: [Movie]?
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
                
        case .searchMovie(let query):
            let movieSearchResult = usecase.getMovieList(keyword: query)
            let movieSearchSuccess = movieSearchResult.map { result -> [Movie]? in
                guard case .success(let movieSearch) = result else { return nil }
                return movieSearch.items
            }
            
            return movieSearchSuccess.map { movies in
                return Mutation.fetchSearchMovie(movies)
            }
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
            case .fetchPopularMovie(let popularMovies):
                newState.popularMovies = popularMovies
            case .fetchSearchMovie(let movies):
                    newState.searchMovies = movies
            }
        print("state = \(newState)")
        return newState
    }
}
