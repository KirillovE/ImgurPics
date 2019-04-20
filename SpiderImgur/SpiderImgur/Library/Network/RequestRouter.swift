//
//  RequestRouter.swift
//  SpiderImgur
//
//  Created by Евгений Кириллов on 20/04/2019.
//  Copyright © 2019 Триада. All rights reserved.
//

import Alamofire

/// Тип кодирования запроса
///
/// - url: Параметры передаются внутри URL
/// - json: Параметры передаются с помощью JSON
enum RequestRouterEncoding {
    case url
    case json
}

/// Определяет правило создания запроса в сеть
protocol RequestRouter: URLRequestConvertible {
    var baseURL: URL { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
    var fullURL: URL { get }
    var encoding: RequestRouterEncoding { get }
}

// MARK: - Реализация по-умолчанию
extension RequestRouter {
    
    /// Полный запрос составляется из базовой части `baseURL` и пути `path`
    var fullURL: URL {
        return baseURL.appendingPathComponent(path)
    }
    
    /// По-умолчанию параметры запроса передаются внутри URL
    var encoding: RequestRouterEncoding {
        return .url
    }
    
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: fullURL)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = ["Authorization": Constants.clientID]
        
        switch self.encoding {
        case .url:
            return try URLEncoding.default.encode(urlRequest, with: parameters)
        case .json:
            return try JSONEncoding.default.encode(urlRequest, with: parameters)
        }
    }

}
