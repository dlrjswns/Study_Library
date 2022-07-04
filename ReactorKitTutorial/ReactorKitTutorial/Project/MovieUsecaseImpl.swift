//
//  MovieUsecaseImpl.swift
//  ReactorKitTutorial
//
//  Created by 이건준 on 2022/07/04.
//

import RxSwift

protocol MovieUsecase {
    func getMoviePopular() -> Observable<Result<PopularMovieList, MovieError>>
    func getMovieList(keyword: String) -> Observable<Result<MovieList, MovieError>>
}

class MovieUsecaseImpl: MovieUsecase {
    private let repository: MovieRepository
    
    init(repository: MovieRepository) {
        self.repository = repository
    }
    
    func getMoviePopular() -> Observable<Result<PopularMovieList, MovieError>> {
        return repository.getMoviePopular()
    }
    
    func getMovieList(keyword: String) -> Observable<Result<MovieList, MovieError>> {
        return repository.getMovieList(keyword: keyword)
    }
}
