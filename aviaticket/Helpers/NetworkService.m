//
//  NetworkService.m
//  aviaticket
//
//  Created by Григорий Мартюшин on 01.06.2020.
//  Copyright © 2020 Григорий Мартюшин. All rights reserved.
//

#import "NetworkService.h"

@implementation NetworkService

+ (instancetype)instance {
    static NetworkService *intance;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        intance = [[NetworkService alloc] init];
    });
    
    return intance;
}

- (instancetype)init {
    if (self.configuration == nil) {
        _configuration = NSURLSessionConfiguration.defaultSessionConfiguration;
    }
    
    // Запускаем сессию
    _session = [NSURLSession sessionWithConfiguration:self.configuration];
    
    return self;
}

- (void)getImageByImage:(NSURL *)url :(void(^)(NSData *data))completion {
    NSURLSessionDataTask *dTask = [_session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data != nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(data);
            });
        }
    }];
    
    // Запускаем задачу
    [dTask resume];
}

// Загрузка новостей
- (void)getNewsList:(void(^)(NSMutableArray *newsListArray))completion {
    // Список полученных новостей будет хранить в массиве -
    NSMutableArray *newsList = [[NSMutableArray alloc] init];
    
    if (self.session != nil) {
        // Генерим адрес для запроса данных
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?country=ru&category=technology&apiKey=%@", NEWS_API_URL, NEWS_API_TOKEN]];
        
        // Готовоим задачу на загрузку данных
        _dataTask = [_session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError *_Nullable error) {
            // Кастим ответ как ответ HTTP
            NSHTTPURLResponse *resp = (NSHTTPURLResponse *) response;
            
            // Проверяем наличие данных и код ответа 200 Ok
            if (resp.statusCode == 200 && data != nil) {
                // Переменная для хранения ошибок разбора json из data
                NSError *parseError = nil;
                
                // Запускаем парсинг json новостей
                NewsData *nwData = [NewsData fromData:data error:&parseError];
                
                // Удалось распарсить и пришел status == ok
                if (nwData != nil && [nwData.status isEqualToString:@"ok"]) {
                    // Создаем массив новостей для возвращения в замыкание
                    for (NewsArticle *article in nwData.articles) {
                        News *addNews;
                        
                        // Новости без изображений и описания не берем
                        if (article.title != nil && article.theDescription != nil) {
                            addNews = [[News alloc] initWithNewsArticle:article];
                            [newsList addObject:addNews];
                        }
                    }
                }
            }
            
            // Массив вернем в любом случае, даже если была какая-то ошибка,
            // просто он будет пустой
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(newsList);
            });
        }];
        
        // Запускаем выполнение запроса
        [_dataTask resume];
    }
}

@end
