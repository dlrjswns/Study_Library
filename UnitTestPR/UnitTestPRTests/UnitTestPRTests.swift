//
//  UnitTestPRTests.swift
//  UnitTestPRTests
//
//  Created by 이건준 on 2022/07/01.
//

import XCTest
@testable import UnitTestPR

class UnitTestPRTests: XCTestCase {

    override func setUpWithError() throws {
        // 테스트 메소드가 실행되기 전 모든 상태를 reset합니다 (초기화 코드)
    }

    override func tearDownWithError() throws {
        // 테스트 동작이 끝난 후 모든 상태를 clean up합니다 (해체 코드)
    }
    
    func testScoreIsComputedWhenGuessIsHigherThanTarget() { // 테스트 메소드는 반드시 test키워드로 시작해야함
        // given(필요한 value들을 세팅)
        
        // when(테스트 코드 실행)
        
        
        // then(결과확인 출력)
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure { // 테스트가 성공할 시 녹색으로 체크박스가 뜨고 끝에 있는 회색 다이아몬드를 클릭해 성능결과를 볼 수 있음
            // Put the code you want to measure the time of here.
        }
    }

}
