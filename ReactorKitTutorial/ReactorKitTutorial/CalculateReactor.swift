//
//  CalculateReactor.swift
//  ReactorKitTutorial
//
//  Created by 이건준 on 2022/06/18.
//

import Foundation
import ReactorKit

class CalculateReactor: Reactor {
    var initialState: State {
        return State(resultNum: 0)
    }
    
    enum Action {
        case plusButtonClicked
        case minusButtonClicked
    }
    
    struct State {
        var resultNum: Int
    }
    
    enum Mutation {
        case plusNumber
        case minusNumber
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
            case .plusButtonClicked:
                return Observable.concat([
                    Observable.just(Mutation.plusNumber)
                ])
            case .minusButtonClicked:
                return Observable.concat([
                    Observable.just(Mutation.minusNumber)
                ])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
            case .plusNumber:
                state.resultNum += 1
            case .minusNumber:
                state.resultNum -= 1
        }
        
        return state
    }
}
