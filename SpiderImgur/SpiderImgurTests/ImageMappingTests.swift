//
//  ImageMappingTests.swift
//  SpiderImgurTests
//
//  Created by Евгений Кириллов on 21/04/2019.
//  Copyright © 2019 Триада. All rights reserved.
//

import XCTest
@testable import SpiderImgur

/// Тестирование отображения ответа сервера в
class ImageMappingTests: XCTestCase {

    var imageResponseStub: ImageResponse?
    
    override func setUp() {
        var imageData = [ImageData]()
        for dataIndex in 0...9 {
            var images = [Image]()
            for imageIndex in 0...3 {
                images.append(Image(id: "\(imageIndex)", link: "link\(imageIndex)-\(dataIndex)"))
            }
            imageData.append(ImageData(id: "\(dataIndex)", title: "title\(dataIndex)", images: images))
        }
        imageResponseStub = ImageResponse(data: imageData, success: true, status: 200)
    }

    override func tearDown() {
        imageResponseStub = nil
    }

    func testMapping() {
        print("image response", imageResponseStub!, separator: "\n")
        let viewModel = imageResponseStub!.mapToViewModel()
        print("view model", viewModel, separator: "\n")
        XCTAssertEqual(viewModel.count, 40, "Неверное отображение")
    }

}
