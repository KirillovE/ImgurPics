//
//  OStubHelper.swift
//  GBShopTests
//
//  Created by Евгений Кириллов on 15/11/2018.
//  Copyright © 2018 Триада. All rights reserved.
//

import OHHTTPStubs

/// Помощник в работе с библиотекой `OHHTTPStubs`
class OStubHelper {
    
    /// Получить URL файла-заглушки в формате JSON
    ///
    /// - Parameter name: Имя файла без расширения
    /// - Returns: URL указанного файла
    func getStubFile(name: String) -> URL {
        return Bundle(for: OStubHelper.self).url(forResource: name, withExtension: "json")!
    }
    
    /// Настраивает HTTP-заглушку для метода **GET**
    ///
    /// - Parameters:
    ///   - fileURL: URL файла-заглушки, который будет передан в качестве ответа
    ///   - pathEnd: Окончание пути к методу API
    func setGetStub(with fileURL: URL, pathEnd: String) {
        stub(condition: isMethodGET() && pathEndsWith(pathEnd)) { _ in
            return OHHTTPStubsResponse(fileURL: fileURL, statusCode: 200, headers: [:])
        }
    }

}
