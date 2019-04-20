//
//  BaseRequestFactory.swift
//  SpiderImgur
//
//  Created by Евгений Кириллов on 20/04/2019.
//  Copyright © 2019 Триада. All rights reserved.
//

import Alamofire

/// Основной класс для работы с сетью, остальные наследуются от него
class BaseRequestFactory: AbstractRequestFactory {
    
    let errorParser: AbstractErrorParser
    let errorHandler: AbstractErrorHandler
    let sessionManager: SessionManager    
    let requestQueue: DispatchQueue?
    let baseURL = Constants.baseURL
    
    init(errorParser: AbstractErrorParser,
         errorHandler: AbstractErrorHandler,
         sessionManager: SessionManager,
         queue: DispatchQueue? = DispatchQueue.global()) {
        self.errorParser = errorParser
        self.errorHandler = errorHandler
        self.sessionManager = sessionManager
        self.requestQueue = queue
    }
    
    @discardableResult
    func request<T: Decodable>(request: URLRequestConvertible,
                               completion: @escaping (T) -> Void) -> DataRequest {
        return sessionManager
            .request(request)
            .responseCodable(errorParser: errorParser,
                             requestQueue: requestQueue) { [weak self] (response: DataResponse<T>) in
                                switch response.result {
                                case .success(let decodedValue):
                                    completion(decodedValue)
                                case .failure(let parsedError):
                                    self?.errorHandler.handle(parsedError)
                                }
        }
    }
    
}
