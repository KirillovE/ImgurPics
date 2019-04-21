//
//  Image.swift
//  SpiderImgur
//
//  Created by Евгений Кириллов on 20/04/2019.
//  Copyright © 2019 Триада. All rights reserved.
//

/// Структура для представления информации об изображении
struct ImageViewModel {
    let id: String
    let address: String
    let title: String
    let views: Int
    let commentCount: Int
    let favoriteCount: Int
    let description: String?
}

/// Ответ сервера на запрос
struct ImageResponse: Decodable {
    let images: [ImageViewModel]
    
    enum TopCodingKeys: String, CodingKey {
        case data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: TopCodingKeys.self)
        
        var dataContainer = try container.nestedUnkeyedContainer(forKey: .data)
        var imageDatas = [ImageData]()
        while !dataContainer.isAtEnd {
            let imageData = try dataContainer.decode(ImageData.self)
            imageDatas.append(imageData)
        }
        
        images = imageDatas.flatMap { imageData -> [ImageViewModel] in
            let id = imageData.id
            let title = imageData.title
            let viewsCount = imageData.views
            let commentsCount = imageData.commentCount
            let favoriteCount = imageData.favoriteCount
            let images = imageData.images ?? []
            return images.map {
                return ImageViewModel(id: id,
                                      address: $0.link,
                                      title: title,
                                      views: viewsCount,
                                      commentCount: commentsCount,
                                      favoriteCount: favoriteCount,
                                      description: $0.description)
            }
        }
        
    }
}

/// Информация об изображении с сервера
struct ImageData: Decodable {
    let id: String
    let title: String
    let views: Int
    let commentCount: Int
    let favoriteCount: Int
    let images: [Image]?
}

/// Изображение, получаемое от сервера
struct Image: Decodable {
    let id: String
    let link: String
    let description: String?
}
