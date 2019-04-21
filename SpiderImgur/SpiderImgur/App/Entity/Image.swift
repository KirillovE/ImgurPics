//
//  Image.swift
//  SpiderImgur
//
//  Created by Евгений Кириллов on 20/04/2019.
//  Copyright © 2019 Триада. All rights reserved.
//

/// Ответ сервера на запрос
struct ImageResponse: Decodable {
    let data: [ImageData]
    let success: Bool
    let status: Int
}

/// Информация об изображении с сервера
struct ImageData: Decodable {
    let id: String
    let title: String
    let images: [Image]?
}

/// Изображение, получаемое от сервера
struct Image: Decodable {
    let id: String
    let link: String
}

extension ImageResponse {
    
    /// Отобразить в удобную для представления структуру
    ///
    /// - Returns: Массив структур для представления
    func mapToViewModel() -> [ImageViewModel] {
        return data.flatMap { imageData -> [ImageViewModel] in
            let id = imageData.id
            let title = imageData.title
            let images = imageData.images ?? []
            return images.map {
                return ImageViewModel(id: id, address: $0.link, title: title)
            }
        }
    }
    
}
