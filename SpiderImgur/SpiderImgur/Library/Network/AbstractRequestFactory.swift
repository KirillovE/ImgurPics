//
//  AbstractRequest.swift
//  SpiderImgur
//
//  Created by Евгений Кириллов on 20/04/2019.
//  Copyright © 2019 Триада. All rights reserved.
//

import Alamofire

/// Помогает реализовать фабрику, создающую абстрактный запрос в сеть с помощью библиотеки Alamofire
protocol AbstractRequestFactory: AnyObject {
    
    /// Пользовательский анализатор ошибок, соответствующий протоколу `AbstractErrorParser`
    var errorParser: AbstractErrorParser { get }
    
    /// Пользовательский обработчик ошибок, соответствующий протоколу `AbstractErrorHandler`
    var errorHandler: AbstractErrorHandler { get }
    
    /// Менеджер сессии, в которой запускается запрос
    var sessionManager: SessionManager { get }
    
    /// Очередь для обработки запроса
    var requestQueue: DispatchQueue? { get }
    
    /// Создаёт запрос получения данных, специфичный для библиотеки Alamofire
    ///
    /// - Parameters:
    ///   - request: Запрос, помогающий сформировать запрос на получение данных
    ///   - completion: Завершающий блок
    /// - Returns: Запрос на получение данных, описанный в библиотеке Alamofire
    @discardableResult
    func request<T: Decodable>(request: URLRequestConvertible,
                               completion: @escaping (T) -> Void) -> DataRequest
    
}
