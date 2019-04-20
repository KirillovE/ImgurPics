//
//  RequestFactoryTests.swift
//  SpiderImgurTests
//
//  Created by Евгений Кириллов on 20/04/2019.
//  Copyright © 2019 Триада. All rights reserved.
//

import OHHTTPStubs
import Alamofire
import XCTest
@testable import SpiderImgur

/// Тестирование сетевых запросов
class RequestFactoryTests: XCTestCase {
    
    // MARK: - Настройка
    
    var errorParser: AbstractErrorParser!
    var errorHandler: AbstractErrorHandler!
    var oStubsHelper: OStubHelper!
    var sessionManager: SessionManager!
    var requestFactory: RequestsFactoryMaker!
    let failureMessage = "Нужный ответ не получен"
    let timeout: TimeInterval = 7
    
    override func setUp() {
        errorParser = ErrorParserStub()
        errorHandler = ErrorHandlerStub()
        oStubsHelper = OStubHelper()
        
        let config = URLSessionConfiguration.ephemeral
        OHHTTPStubs.setEnabled(true, for: config)
        sessionManager = SessionManager(configuration: config)
        
        requestFactory = RequestsFactory(
            errorParser: errorParser,
            errorHandler: errorHandler,
            sessionManager: sessionManager
        )
        
        super.setUp()
    }
    
    override func tearDown() {
        OHHTTPStubs.removeAllStubs()
        super.tearDown()
    }
    
    // MARK: - Тесты
    
    func testFetchImagesRequest() {
        let page = 0
        let expectation = self.expectation(description: "Успешный запрос картинок")
        let responseStubURL = oStubsHelper.getStubFile(name: "ImageResponseStub")
        oStubsHelper.setGetStub(with: responseStubURL, pathEnd: "gallery/top/top/all/\(page)")
        
        requestFactory.fetchImages(page: page) { [weak self] response in
            let imageID = response.data.first?.images?.first?.id
            XCTAssertEqual(imageID, "tiAxps3", self!.failureMessage)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: timeout)
        
    }
    
    func testFetchCommentsRequest() {
        let imageID = "80yW8"
        let expectation = self.expectation(description: "Успешный запрос комментариев")
        let responseStubURL = oStubsHelper.getStubFile(name: "CommentResponseStub")
        oStubsHelper.setGetStub(with: responseStubURL, pathEnd: "gallery/\(imageID)/comments/top")
        
        requestFactory.fetchComments(forImage: imageID) { [weak self] response in
            let commentID = response.data.first?.id
            XCTAssertEqual(commentID, 1053911831, self!.failureMessage)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: timeout)
        
    }

}
