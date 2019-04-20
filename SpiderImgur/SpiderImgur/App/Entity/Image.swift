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
    let images: [Image]
}

/// Изображение, получаемое от сервера
struct Image: Decodable {
    let id: String
    let link: String
}
