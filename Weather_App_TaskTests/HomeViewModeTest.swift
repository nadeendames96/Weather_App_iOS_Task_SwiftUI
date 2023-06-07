//
//  HomeViewModeTest.swift
//  Weather_App_TaskTests
//
//  Created by Nadeen Dames on 07/06/2023.
//
import XCTest
import Combine
@testable import Weather_App_Task
class SimpleTestCombine{
    private var valueTest = CurrentValueSubject<Int,Never>(0)
    var valuePublisher: AnyPublisher<String,Never>{
        valueTest.map{value in
            "1"
        }.eraseToAnyPublisher()
    }
    func set(value: Int){
        valueTest.send(value)
    }
}

class HomeViewModelTest: XCTestCase {
    func test_exp_language(){
        let homeViewModel = HomeViewModel()
        let actual = homeViewModel.expCurrentLanguage("ar")
        let expected = "ar"
        let exp = expectation(description: "Wait for result")
        XCTAssertEqual(actual,expected)
        waitForExpectations(timeout: 0.1)
    }
    
    func simple_test_combine(){
        let simpleTestCombine = SimpleTestCombine()
        simpleTestCombine.set(value: 1)
        let exp = expectation(description: "Wait for result")
        simpleTestCombine.valuePublisher.sink{ result in  // subscribe
            XCTAssertEqual(result,"1")
            exp.fulfill()
        }
        waitForExpectations(timeout: 0.1)
    }
    
}

