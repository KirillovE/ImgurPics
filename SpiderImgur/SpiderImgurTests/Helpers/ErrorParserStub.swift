//
//  ErrorParserStub.swift
//  SpiderImgurTests
//
//  Created by Евгений Кириллов on 20/04/2019.
//  Copyright © 2018 Триада. All rights reserved.
//

import Foundation
@testable import SpiderImgur

/// Заглушка-анализатор ошибок
class ErrorParserStub: AbstractErrorParser {
    
    func parse(_ result: Error) -> Error {
        return AppError.undefinedFailure
    }
    
    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error? {
        return error
    }
    
}
