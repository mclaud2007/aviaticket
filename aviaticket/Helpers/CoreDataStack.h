//
//  CoreDataStack.h
//  aviaticket
//
//  Created by Григорий Мартюшин on 05.07.2020.
//  Copyright © 2020 Григорий Мартюшин. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <CloudKit/CloudKit.h>
#import "FavoriteNews+CoreDataClass.h"
#import "News.h"

NS_ASSUME_NONNULL_BEGIN

@interface CoreDataStack : NSObject

+ (instancetype)shared;
- (void)addToFavorite:(News *)news;
- (void)removeFromFavorite:(News *)news;
- (void)removeAllFromFavorite;
- (FavoriteNews *)favoriteFromNews:(News *)news;
- (NSArray *)favorites;

@end

NS_ASSUME_NONNULL_END
