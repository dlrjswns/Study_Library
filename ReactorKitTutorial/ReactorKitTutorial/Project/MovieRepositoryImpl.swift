//
//  MovieRepositoryImpl.swift
//  ReactorKitTutorial
//
//  Created by 이건준 on 2022/07/04.
//

import RxSwift
import RxCocoa

// MARK: -Repository
protocol MovieRepository {
    func getMoviePopular() -> Observable<Result<PopularMovieList, MovieError>>
    func getMovieList(keyword: String) -> Observable<Result<MovieList, MovieError>>
}

enum MovieError: Error {
    case urlError
    case decodeError
    
    var errorMessage: String {
        switch self {
        case .urlError:
            return "올바른 URL을 입력해주세요"
        case .decodeError:
            return "Decode하지않았습니다"
        }
    }
}


// MARK: -Repository Impl
class MovieRepositoryImpl: MovieRepository {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func getMoviePopular() -> Observable<Result<PopularMovieList, MovieError>> {
        guard let url = getMoviePopularURLComponents().url else {
            return Observable.just(.failure(.urlError))
        }
        let request = URLRequest(url: url)
        return session.rx.data(request: request).map { data in
            do {
                let popularMovieList = try JSONDecoder().decode(PopularMovieList.self, from: data)
                return .success(popularMovieList)
            } catch {
                return .failure(.decodeError)
            }
        }
    }
    
    func getMovieList(keyword: String) -> Observable<Result<MovieList, MovieError>> {
        let result = getMovieListURLRequest(keyword: keyword)
        switch result {
        case .success(let request):
            return session.rx.data(request: request).map { data in
                do {
                    let movieList = try JSONDecoder().decode(MovieList.self, from: data)
                    return .success(movieList)
                } catch {
                    return .failure(.decodeError)
                }
            }
        case .failure(let error):
            return Observable.just(.failure(error))
        }
    }
}

extension MovieRepositoryImpl {
    struct MovieAPI {
        static let scheme = "https"
        static let host = "openapi.naver.com"
        static let path = "/v1/search/movie.json"
        static let clientID = "o6h5Wlhgb309uisyslEX"
        static let clientSecret = "c1WvQUksjQ"
    }
    
    struct MyMovieDB {
        static let scheme = "https"
        static let host = "api.themoviedb.org"
        static let path = "/3/movie/popular"
    }
    
    func getMoviePopularURLComponents() -> URLComponents {
        var components = URLComponents()
        components.scheme = MyMovieDB.scheme
        components.host = MyMovieDB.host
        components.path = MyMovieDB.path
        components.queryItems = [
            URLQueryItem(name: "api_key", value: "5dfb363e92ea551484beb33ec87c3cb2")
        ]
        return components
    }
    
    func getMovieListURLRequest(keyword: String) -> Result<URLRequest, MovieError> {
        guard let url = getMovieListURLComponents(keyword: keyword).url else {
            let error = MovieError.urlError
            return .failure(error)
        }
        
        var components: URLRequest = .init(url: url)
        components.allHTTPHeaderFields = [
            "X-Naver-Client-Id" : MovieAPI.clientID,
            "X-Naver-Client-Secret" : MovieAPI.clientSecret
        ]
        
        return .success(components)
        
    }
    
    private func getMovieListURLComponents(keyword: String) -> URLComponents {
        var components: URLComponents = .init()
        components.scheme = MovieAPI.scheme
        components.host = MovieAPI.host
        components.path = MovieAPI.path
        
        components.queryItems = [
            URLQueryItem(name: "query", value: keyword)
        ]
        
        return components
    }
}

