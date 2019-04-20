//
//  RequestsFactoryMaker.swift
//  SpiderImgur
//
//  Created by Евгений Кириллов on 20/04/2019.
//  Copyright © 2019 Триада. All rights reserved.
//

/// Создатель фабрики запросов в сеть
protocol RequestsFactoryMaker {
    
    /// Скачивание изображений
    ///
    /// - Parameters:
    ///   - page: Номер страницы с изображениями
    ///   - completion: Завершающий блок с полученными изображениями
    func fetchImages(page: Int, completion: @escaping (ImageResponse) -> Void)
    
    /// Скачивание комментариев для изображения или галереи
    ///
    /// - Parameters:
    ///   - imageID: Идентификатор изображения или галереи
    ///   - comletion: Завершающий блок с полученными комментариями
    func fetchComments(forImage imageID: String, completion: @escaping (CommentResponse) -> Void)
}
