//
//  FactoryAssemblerTests.swift
//  SpiderImgurTests
//
//  Created by Евгений Кириллов on 20/04/2019.
//  Copyright © 2019 Триада. All rights reserved.
//

import XCTest
@testable import SpiderImgur

/// Тестирование сборщика фабрик
class FactoryAssemblerTests: XCTestCase {
    
    let assembler = FactoryAssembler()
    
    func testAssembling() {
        let factory = assembler.assembleRequestFactory()
        XCTAssert(factory is RequestsFactory, "Не удалось получить фабрику")
    }
    
}
