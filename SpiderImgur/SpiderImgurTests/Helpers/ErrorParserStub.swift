//
//  ErrorParserStub.swift
//  GBShopTests
//
//  Created by Евгений on 05/11/2018.
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
