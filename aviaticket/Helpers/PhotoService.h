//
//  PhotoService.h
//  aviaticket
//
//  Created by Григорий Мартюшин on 01.06.2020.
//  Copyright © 2020 Григорий Мартюшин. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NetworkService.h"

NS_ASSUME_NONNULL_BEGIN

@interface PhotoService : NSObject

@property (nonatomic, readonly, strong) NSURL *cacheDirURL;

+ (instancetype)instance;
- (instancetype)init;
- (NSString *)getFileNameFrom:(NSURL *)url;
- (void)getPhotoBy:(NSURL *)url :(void(^)(UIImage *data))completion;

@end

NS_ASSUME_NONNULL_END
