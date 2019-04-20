//
//  RequestsFactory.swift
//  SpiderImgur
//
//  Created by Евгений Кириллов on 20/04/2019.
//  Copyright © 2019 Триада. All rights reserved.
//

import Alamofire

final class RequestsFactory: BaseRequestFactory, RequestsFactoryMaker {
    
    func fetchImages(page: Int = 0, completion: @escaping (ImageResponse) -> Void) {
        let router = ImageRequest(baseURL: baseURL, page: page)
        request(request: router, completion: completion)
    }
    
    func fetchComments(forImage imageID: String, completion: @escaping (CommentResponse) -> Void) {
        let router = CommentRequest(baseURL: baseURL, imageID: imageID)
        request(request: router, completion: completion)
    }
    
}

extension RequestsFactory {
    
    /// Модель запроса на получение изображений
    private struct ImageRequest: RequestRouter {
        let method: HTTPMethod = .get
        let parameters: Parameters? = nil
        let baseURL: URL
        let page: Int
        var path: String { return "gallery/top/top/all/\(page)" }
    }
    
    /// Модель запроса на получение комментариев
    private struct CommentRequest: RequestRouter {
        let method: HTTPMethod = .get
        let parameters: Parameters? = nil
        let baseURL: URL
        let imageID: String
        var path: String { return "gallery/\(imageID)/comments/top" }
    }
    
}
