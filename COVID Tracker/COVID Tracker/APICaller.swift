//
//  APICaller.swift
//  COVID Tracker
//
//  Created by 이건준 on 2022/05/16.
//

import UIKit

extension DateFormatter {
    static let dayformatter: DateFormatter = {
       let dateFormatter = DateFormatter()
       dateFormatter.dateFormat = "YYYY-MM-dd"
       dateFormatter.timeZone = .current
       dateFormatter.locale = .current
       return dateFormatter
    }()
    
    static let prettyformatter: DateFormatter = {
       let dateFormatter = DateFormatter()
       dateFormatter.dateStyle = .medium
       dateFormatter.timeZone = .current
       dateFormatter.locale = Locale(identifier: "en_US")
       return dateFormatter
    }()
}

class APICaller {
    static let shared = APICaller()
    
    private init() {}
    
    private struct Constants {
        static let allStateUrl = URL(string: "https://api.covidtracking.com/v2/states.json")
//        static let covidStateData = URL(string: "https://api.covidtracking.com/v2/states")
    }
    
    enum DataScope {
        case national
        case state(State)
    }
    
    public func getCovidData(
        for scope: DataScope,
        completion: @escaping (Result<[DayData], Error>) -> Void) {
            let urlString: String
            switch scope {
                case .national:
                    urlString = "https://api.covidtracking.com/v2/us/daily.json"
                case .state(let state):
                    urlString = "https://api.covidtracking.com/v2/states/\(state.state_code.lowercased())/daily.json"
                    
            }
            
            guard let url = URL(string: urlString) else { return }
            
            let task = URLSession.shared.dataTask(with: url) { data, _, error in
                guard let data = data, error == nil else { return }
                
                do {
                    let result = try JSONDecoder().decode(CovidDataResponse.self, from: data)
                    let models: [DayData] = result.data.compactMap {
                        guard let value = $0.cases.total.value,
                              let date = DateFormatter.dayformatter.date(from: $0.date) else {
                            return nil
                        }
                        return DayData(date: date, count: value)
                    }
                    
                    completion(.success(models))
                    
                } catch {
                    completion(.failure(error))
                }
            }
            
            task.resume()
    }
    
    public func getStateList(completion: @escaping (Result<[State], Error>) -> Void) {
        guard let url = Constants.allStateUrl else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let result = try JSONDecoder().decode(StateListResponse.self, from: data)
                let states = result.data
                completion(.success(states))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}

struct StateListResponse: Decodable {
    let data: [State]
}

struct State: Decodable {
    let name: String
    let state_code: String
}

struct CovidDataResponse: Codable {
    let data: [CovidDayData]
}

struct CovidDayData: Codable {
    let cases: CovidCases
    let date: String
}

struct CovidCases: Codable {
    let total: TotalCases
}

struct TotalCases: Codable {
    let value: Int?
}

struct DayData {
    let date: Date
    let count: Int
}
