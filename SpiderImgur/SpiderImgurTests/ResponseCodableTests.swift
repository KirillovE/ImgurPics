//
//  ResponseCodableTests.swift
//  SpiderImgurTests
//
//  Created by Евгений Кириллов on 20/04/2019.
//  Copyright © 2019 Триада. All rights reserved.
//

import Alamofire
import OHHTTPStubs
import XCTest
@testable import SpiderImgur

/// Заглушка, имитирующая ответ от сервера
struct JSONStub: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

/// Тест расширения класса `DataRequest` методом `responseCodable`
class ResponseCodableTests: XCTestCase {

    var errorParserStub: ErrorParserStub!
    var oStubsHelper: OStubHelper!
    var sessionManager: SessionManager!
    
    override func setUp() {
        errorParserStub = ErrorParserStub()
        oStubsHelper = OStubHelper()
        
        let config = URLSessionConfiguration.ephemeral
        OHHTTPStubs.setEnabled(true, for: config)
        sessionManager = SessionManager(configuration: config)
        
        super.setUp()
    }

    override func tearDown() {
        OHHTTPStubs.removeAllStubs()
        super.tearDown()
    }
    
    func testSuccessfullRequest() {
        let expectation = self.expectation(description: "Успешный запрос")
        let responseStubURL = oStubsHelper.getStubFile(name: "ResponseStub")
        oStubsHelper.setGetStub(with: responseStubURL, pathEnd: "/request")
        
        sessionManager
            .request("https://awesomeserver.ru/request")
            .responseCodable(errorParser: errorParserStub) { (response: DataResponse<JSONStub>) in
                XCTAssert(response.result.isSuccess, "Запрос завершился неудачей")
                expectation.fulfill()
        }
        wait(for: [expectation], timeout: 7)
    }
    
    func testFailedRequest() {
        let expectation = self.expectation(description: "Проваленый запрос")
        let responseStubURL = oStubsHelper.getStubFile(name: "")
        oStubsHelper.setGetStub(with: responseStubURL, pathEnd: "/request")
        
        sessionManager
            .request("https://awesomeserver.ru/request")
            .responseCodable(errorParser: errorParserStub) { (response: DataResponse<JSONStub>) in
                XCTAssert(response.result.isFailure, "Запрос завершился успешно")
                expectation.fulfill()
        }
        wait(for: [expectation], timeout: 7)
    }

}
