//
//  News.h
//  aviaticket
//
//  Created by Григорий Мартюшин on 01.06.2020.
//  Copyright © 2020 Григорий Мартюшин. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsData.h"

NS_ASSUME_NONNULL_BEGIN

@interface News : NSObject

@property (nonatomic, nonnull, strong) NSString *title;
@property (nonatomic, nonnull, strong) NSString *short_description;
@property (nonatomic, nullable, strong) NSURL *url;
@property (nonatomic, nullable, strong) NSURL *imageUrl;
@property (nonatomic, nullable, strong) NSString *source;
@property (nonatomic, nullable, strong) NSString *publisherAt;

- (instancetype)initWithTitle:(NSString *)title ShortDescription:(NSString *)short_description Source:(NSString *)source;
- (instancetype)initWithTitle:(NSString *)title ShortDescription:(NSString *)short_description Url:(NSString *)url Source:(NSString *)source Image:(NSString *)image Date:(NSString *)dateString;
- (instancetype)initWithNewsArticle:(NewsArticle *)Data;

@end

NS_ASSUME_NONNULL_END
