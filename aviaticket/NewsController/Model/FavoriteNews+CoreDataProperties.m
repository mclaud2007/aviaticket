//
//  FavoriteNews+CoreDataProperties.m
//  aviaticket
//
//  Created by Григорий Мартюшин on 05.07.2020.
//  Copyright © 2020 Григорий Мартюшин. All rights reserved.
//
//

#import "FavoriteNews+CoreDataProperties.h"

@implementation FavoriteNews (CoreDataProperties)

+ (NSFetchRequest<FavoriteNews *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"FavoriteNews"];
}

@dynamic id;
@dynamic imageURL;
@dynamic publiched_at;
@dynamic short_description;
@dynamic source;
@dynamic title;
@dynamic url;
@dynamic addDate;

@end
