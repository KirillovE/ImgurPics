//
//  DetailProtocols.swift
//  SpiderImgur
//
//  Created by Евгений Кириллов on 21/04/2019.
//  Copyright © 2019 Триада. All rights reserved.
//

import Foundation

/// Источник данных в виде детальной информации об изображении
protocol DetailsDataSource: AnyObject {
    
    /// Массив комментариев для отображения в таблице или коллекции
    var comments: [Comment] { get set }
    
    /// Подробности об изображении
    var imageDetails: [String: String] { get set }
    
    /// Адрес изображения
    var imageURL: URL? { get }
}

/// Определяет правила для работы с детальной информацией об изображении
protocol DetailsList: AnyObject {
    
    /// Источник данных для таблицы или коллекции
    var listDataSource: DetailsDataSource? { get set }
    
    /// Обновление таблицы или коллекции
    func update()
}
