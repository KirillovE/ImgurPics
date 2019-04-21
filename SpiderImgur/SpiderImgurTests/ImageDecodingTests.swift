//
//  SpiderImgurTests.swift
//  SpiderImgurTests
//
//  Created by Евгений Кириллов on 20/04/2019.
//  Copyright © 2019 Триада. All rights reserved.
//

import XCTest
@testable import SpiderImgur

/// Тестиривание декодирования ответа на запрос изображений
class ImageDecodingTests: XCTestCase {
    
    let decoder = JSONDecoder()
    var resultStub = Data()

    override func setUp() {
        let resultFileBundle = Bundle(for: ImageDecodingTests.self)
        let resultFileURL = resultFileBundle.url(forResource: "ImageResponseStub", withExtension: "json")!
        resultStub = try! Data(contentsOf: resultFileURL)
        
        super.setUp()
    }

    func testImageResultDecoding() {
        let imageResponse = try? decoder.decode(ImageResponse.self, from: resultStub)
        XCTAssertNotNil(imageResponse, "Не удалось декодировать ответ")
        XCTAssertTrue(validateFields(ofResponse: imageResponse), "Неверное декодирование")
    }
    
    private func validateFields(ofResponse response: ImageResponse?) -> Bool {
        let countIsValid = response?.images.count == 1
        let dataIdIsValid = response?.images.first?.id == "H0TBp"
        let dataTitleIsValid = response?.images.first?.title == "It's nice to be nice dump"
        let imageLinkIsValid = response?.images.first?.address == "https://i.imgur.com/tiAxps3.jpg"
        
        return countIsValid
            && dataIdIsValid
            && dataTitleIsValid
            && imageLinkIsValid
    }

}
