//
//  News.m
//  aviaticket
//
//  Created by Григорий Мартюшин on 01.06.2020.
//  Copyright © 2020 Григорий Мартюшин. All rights reserved.
//

#import "News.h"

@implementation News

- (instancetype)initWithTitle:(NSString *)title ShortDescription:(NSString *)short_description Source:(NSString *)source {
    _title = title;
    _short_description = short_description;
    _source = source;
    _imageURL = nil;
    _newsId = nil;
    
    return self;
}

- (instancetype)initWithNewsArticle:(NewsArticle *)data {
    if (data.title != nil && data.theDescription != nil) {
        _title = data.title;
        _short_description = data.theDescription;
        _source = data.source.name;
        
        if (data.urlToImage != nil) {
            _imageURL = [NSURL URLWithString:data.urlToImage];
        } else {
            _imageURL = nil;
        }
        
        if (data.url != nil) {
            _url = [NSURL URLWithString:data.url];
        } else {
            _url = nil;
        }
        
        if (data.publishedAt != nil) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
            NSDate *date = [formatter dateFromString:data.publishedAt];
            
            // Конвертируем в нужный нам формат
            [formatter setDateFormat:@"d.mm.yy, HH:mm"];
            _publisherAt = [formatter stringFromDate:date];
            
        } else {
            _publisherAt = nil;
        }
    } else {
        _title = @"";
        _short_description = @"";
    }
        
    return self;
}

- (instancetype)initWithTitle:(NSString *)title ShortDescription:(NSString *)short_description Url:(NSString *)url Source:(NSString *)source Image:(NSString *)image Date:(NSDate *)date {
    _title = title;
    _short_description = short_description;
    _source = source;
    _imageURL = [NSURL URLWithString:image];
    
    if (date != nil) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
//        NSDate *date = [formatter dateFromString:dateString];
        
        // Конвертируем в нужный нам формат
        [formatter setDateFormat:@"d.mm.yy, HH:mm"];
        _publisherAt = [formatter stringFromDate:date];
        
    } else {
        _publisherAt = nil;
        
    }
    
    return self;
}


- (instancetype)initWithFavorite:(FavoriteNews *)favorite
{
    _title = favorite.title;
    _short_description = favorite.short_description;
    _url = [NSURL URLWithString:favorite.url];
    _imageURL = [NSURL URLWithString:favorite.imageURL];
    _source = favorite.source;
    _publisherAt = favorite.publiched_at;
    _newsId = favorite.id;
    
    return self;
}

@end
