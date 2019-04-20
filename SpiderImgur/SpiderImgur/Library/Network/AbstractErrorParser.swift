//
//  AbstractErrorParser.swift
//  SpiderImgur
//
//  Created by Евгений Кириллов on 20/04/2019.
//  Copyright © 2019 Триада. All rights reserved.
//

import Foundation

/// Протокол для анализа ошибок
protocol AbstractErrorParser {
    
    /// Анализ ошибки
    ///
    /// - Parameter result: Результат запроса, содержащий ошибку
    /// - Returns: Обработанная ошибка
    func parse(_ result: Error) -> Error
    
    /// Анализ ответа, содержащего ошибку
    ///
    /// - Parameters:
    ///   - response: Ответ от сервера
    ///   - data: Данные, полученные от сервера
    ///   - error: Ошибка, полученная от сервера
    /// - Returns: Обработанная ошибка
    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error?

}
