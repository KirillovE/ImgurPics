//
//  CommentDecodingTests.swift
//  SpiderImgurTests
//
//  Created by Евгений Кириллов on 20/04/2019.
//  Copyright © 2019 Триада. All rights reserved.
//

import XCTest
@testable import SpiderImgur

/// Тестиривание декодирования ответа на запрос комментариев
class CommentDecodingTests: XCTestCase {
    
    let decoder = JSONDecoder()
    var resultStub = Data()

    override func setUp() {
        let resultFileBundle = Bundle(for: CommentDecodingTests.self)
        let resultFileURL = resultFileBundle.url(forResource: "CommentResponseStub", withExtension: "json")!
        resultStub = try! Data(contentsOf: resultFileURL)
        
        super.setUp()
    }

    func testExample() {
        let commentResponse = try? decoder.decode(CommentResponse.self, from: resultStub)
        XCTAssertNotNil(commentResponse, "Не удалось декодировать ответ")
        XCTAssertTrue(validateFields(ofResponse: commentResponse), "Неверное декодирование")
    }
    
    private func validateFields(ofResponse response: CommentResponse?) -> Bool {
        let commentIdIsValid = response?.data.first?.id == 1053911831
        let commentTextIsValid = response?.data.first?.comment == "Onions.  Onions everywhere"
        
        return commentIdIsValid && commentTextIsValid
    }

}
