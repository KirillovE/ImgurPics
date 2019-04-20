//
//  FactoryAssembler.swift
//  SpiderImgur
//
//  Created by Евгений Кириллов on 20/04/2019.
//  Copyright © 2019 Триада. All rights reserved.
//

import Alamofire

struct FactoryAssembler {
    
    private func makeErrorParser() -> AbstractErrorParser {
        return AppErrorParser()
    }
    
    private func makeErrorHandler() -> AbstractErrorHandler {
        return AlertErrorHandler()
    }
    
    private func makeSessionManager() -> SessionManager {
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        let manager = SessionManager(configuration: configuration)
        return manager
    }
    
    private let sessionQueue = DispatchQueue.global()
    
    /// Собирает фабрику сетевых запросов
    ///
    /// - Returns: Фабрика сетевых запросов
    func assembleRequestFactory() -> RequestsFactoryMaker {
        return RequestsFactory(
            errorParser: makeErrorParser(),
            errorHandler: makeErrorHandler(),
            sessionManager: makeSessionManager(),
            queue: sessionQueue
        )
    }
    
}
