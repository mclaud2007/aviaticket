//
//  NetworkService.h
//  aviaticket
//
//  Created by Григорий Мартюшин on 01.06.2020.
//  Copyright © 2020 Григорий Мартюшин. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsData.h"
#import "News.h"

#define NEWS_API_TOKEN @"ff292dac9c5d40ba91c214edf8b86aa1"
#define NEWS_API_URL @"https://newsapi.org/v2/top-headlines"

NS_ASSUME_NONNULL_BEGIN

@interface NetworkService : NSObject

@property (nonatomic, readonly, strong) NSURLSession *session;
@property (nonatomic, strong) NSURLSessionConfiguration *configuration;
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;
@property (nonatomic, strong) NSURLSessionUploadTask *uploadTask;


+ (instancetype)instance;
- (instancetype)init;

- (void)getNewsList:(void(^)(NSMutableArray *newsListArray))completion;
- (void)getImageByImage:(NSURL *)url :(void(^)(NSData *data))completion;

@end

NS_ASSUME_NONNULL_END
