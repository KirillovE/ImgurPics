//
//  ImageProtocols.swift
//  SpiderImgur
//
//  Created by Евгений Кириллов on 21/04/2019.
//  Copyright © 2019 Триада. All rights reserved.
//

/// Источник данных в виде изображений
protocol ImagesDataSource: AnyObject {
    
    /// Массив моделей изображений для отображения в таблице или коллекции
    var images: [ImageViewModel] { get set }
}

/// Определяет правила для работы со списком изображений
protocol ImageList: AnyObject {
    
    /// Источник данных для таблицы или коллекции
    var listDataSource: ImagesDataSource? { get set }
    
    /// Обновление таблицы или коллекции
    func update()
}
