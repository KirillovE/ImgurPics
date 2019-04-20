//
//  AppErrorParser.swift
//  SpiderImgur
//
//  Created by Евгений Кириллов on 20/04/2019.
//  Copyright © 2019 Триада. All rights reserved.
//

import Foundation

/// Типы ошибок, используемые в приложении
///
/// - serverFailure: Серверная
/// - networkFailure: Сетевая
/// - undefinedFailure: Неопредлённая
enum AppError: String, Error {
    case serverFailure = "Серверная ошибка"
    case networkFailure = "Сетевая ошибка"
    case undefinedFailure = "Неопределённая ошибка"
}

/// Анализатор ошибок, использующий специфичные для приложения типы ошибок
final class AppErrorParser: AbstractErrorParser {
    func parse(_ result: Error) -> Error {
        switch result {
        case _ where result is DecodingError:
            return AppError.serverFailure
        case let error as NSError?
            where error?.code == -1001 || error?.code == -1009:
            return AppError.networkFailure
        default:
            return AppError.undefinedFailure
        }
    }
    
    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error? {
        return error != nil ? AppError.undefinedFailure : nil
    }
}
