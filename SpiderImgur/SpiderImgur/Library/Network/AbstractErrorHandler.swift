//
//  AbstractErrorHandler.swift
//  SpiderImgur
//
//  Created by Евгений Кириллов on 20/04/2019.
//  Copyright © 2019 Триада. All rights reserved.
//

/// Обработчик ошибок
protocol AbstractErrorHandler {
    
    /// Обрабатывает переданную ошибку
    ///
    /// - Parameter error: Ошибка для обработки
    func handle(_ error: Error)
}
