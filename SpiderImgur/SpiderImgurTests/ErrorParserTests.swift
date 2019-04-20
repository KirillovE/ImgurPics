//
//  ErrorParserTests.swift
//  SpiderImgurTests
//
//  Created by Евгений Кириллов on 20/04/2019.
//  Copyright © 2019 Триада. All rights reserved.
//

import XCTest
@testable import SpiderImgur

/// Тестирование анализатора ошибок
class ErrorParserTests: XCTestCase {
    
    private var errorParser: AppErrorParser!
    private let failureMessage = "Получен неверный тип ошибки"
    
    override func setUp() {
        errorParser = AppErrorParser()
        super.setUp()
    }
    
    // MARK: - Тестирование метода `parse(_:)`
    
    func testDecodingError() {
        let passedErrorContext = DecodingError.Context(codingPath: [], debugDescription: "")
        let passedError = DecodingError.typeMismatch(String.self, passedErrorContext)
        let returnedError = errorParser.parse(passedError) as? AppError
        XCTAssert(returnedError == .serverFailure, failureMessage)
    }
    
    func test1001error() {
        let passedError: Error = NSError(domain: "", code: -1001, userInfo: nil)
        let returnedError = errorParser.parse(passedError) as? AppError
        XCTAssert(returnedError == .networkFailure, failureMessage)
    }

    func test1009error() {
        let passedError: Error = NSError(domain: "", code: -1009, userInfo: nil)
        let returnedError = errorParser.parse(passedError) as? AppError
        XCTAssert(returnedError == .networkFailure, failureMessage)
    }

    func testOtherError() {
        let passedError: Error = NSError(domain: "", code: -100, userInfo: nil)
        let returnedError = errorParser.parse(passedError) as? AppError
        XCTAssert(returnedError == .undefinedFailure, failureMessage)
    }
    
    // MARK: - Тестирование метода `parse(response:data:error:)`
    
    func testUndefinedError() {
        let passedError: Error = NSError(domain: "", code: -777, userInfo: nil)
        let returnedError = errorParser.parse(response: nil, data: nil, error: passedError) as? AppError
        XCTAssert(returnedError == .undefinedFailure, failureMessage)
    }
    
    func testNilError() {
        let returnedError = errorParser.parse(response: nil, data: nil, error: nil)
        XCTAssertNil(returnedError, failureMessage)
    }
    
}
