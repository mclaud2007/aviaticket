//
//  FavoriteNews+CoreDataProperties.h
//  aviaticket
//
//  Created by Григорий Мартюшин on 05.07.2020.
//  Copyright © 2020 Григорий Мартюшин. All rights reserved.
//
//

#import "FavoriteNews+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface FavoriteNews (CoreDataProperties)

+ (NSFetchRequest<FavoriteNews *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *id;
@property (nullable, nonatomic, copy) NSString *imageURL;
@property (nullable, nonatomic, copy) NSString *publiched_at;
@property (nullable, nonatomic, copy) NSString *short_description;
@property (nullable, nonatomic, copy) NSString *source;
@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSString *url;
@property (nullable, nonatomic, copy) NSDate *addDate;

@end

NS_ASSUME_NONNULL_END
