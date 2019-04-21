//
//  Comment.swift
//  SpiderImgur
//
//  Created by Евгений Кириллов on 20/04/2019.
//  Copyright © 2019 Триада. All rights reserved.
//

/// Ответ сервера на запрос
struct CommentResponse: Decodable {
    let data: [Comment]
}

/// Комментарий
struct Comment: Decodable {
    let id: Int
    let comment: String
    let author: String
}
