//
//  ErrorHandlerStub.swift
//  SpiderImgurTests
//
//  Created by Евгений Кириллов on 20/04/2019.
//  Copyright © 2018 Триада. All rights reserved.
//

import Foundation
@testable import SpiderImgur

/// Заглушка-обработчик ошибок
class ErrorHandlerStub: AbstractErrorHandler {
    
    func handle(_ error: Error) {
        
        print("Handled")
        
    }
    
}
