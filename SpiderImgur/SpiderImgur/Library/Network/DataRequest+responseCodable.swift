//
//  DataRequest+responseCodable.swift
//  SpiderImgur
//
//  Created by Евгений Кириллов on 20/04/2019.
//  Copyright © 2019 Триада. All rights reserved.
//

import Alamofire

extension DataRequest {
    
    /// Метод, позволяющий работать с экземплярами, соответствующими протоколу `Decodable`
    ///
    /// - Parameters:
    ///   - errorParser: Обработчик ошибок, соответствующий протоколу `AbstractErrorParser`
    ///   - requestQueue: Очередь для обработки запроса, по-умолчанию `nil`
    ///   - completion: Завершающий блок
    /// - Returns: Запрос загрузки данных
    @discardableResult
    func responseCodable<T: Decodable>(errorParser: AbstractErrorParser,
                                       requestQueue: DispatchQueue? = nil,
                                       completion: @escaping (DataResponse<T>) -> Void) -> Self {
        
            let responseSerializer = DataResponseSerializer<T> { _, response, data, error in
                
                if let parsedError = errorParser.parse(response: response, data: data, error: error) {
                    return .failure(parsedError)
                }
                
                let serializedResult = Request.serializeResponseData(response: response, data: data, error: nil)
                switch serializedResult {
                case .success(let retrievedRawData):
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let decodedValue = try decoder.decode(T.self, from: retrievedRawData)
                        return .success(decodedValue)
                    } catch {
                        let parsedError = errorParser.parse(error)
                        return .failure(parsedError)
                    }
                case .failure(let retrievedRawError):
                    let parsedError = errorParser.parse(retrievedRawError)
                    return .failure(parsedError)
                }
                
            }
        
            return response(queue: requestQueue,
                            responseSerializer: responseSerializer,
                            completionHandler: completion)
    }
    
}
