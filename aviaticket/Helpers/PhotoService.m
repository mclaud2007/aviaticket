//
//  PhotoService.m
//  aviaticket
//
//  Created by Григорий Мартюшин on 01.06.2020.
//  Copyright © 2020 Григорий Мартюшин. All rights reserved.
//

#import "PhotoService.h"

@implementation PhotoService

+ (instancetype)instance {
    static PhotoService *intance;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        intance = [[PhotoService alloc] init];
    });
    
    return intance;
}

- (instancetype)init {
    // Получаем адрес директории кэша в папке пользователя
    NSURL *cacheDirUrlInUserDomain = [[[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask] firstObject];
    
    // В ней для фотографий будет папка images
    _cacheDirURL = [cacheDirUrlInUserDomain URLByAppendingPathComponent:@"images" isDirectory:YES];
    
    // Если этой папки нет - попытаемся её создать
    if ([[NSFileManager defaultManager] fileExistsAtPath: _cacheDirURL.path] == NO) {
        @try {
            [[NSFileManager defaultManager] createDirectoryAtPath:_cacheDirURL.path withIntermediateDirectories:YES attributes:nil error:nil];
        } @catch(NSException *e) {
            _cacheDirURL = nil;
            NSLog(@"Can't create cachedDir");
        }
    }
    
    return self;
}

- (NSString *)getFileNameFrom:(NSURL *)url {
    NSString *lastComponent = [url lastPathComponent];
    
    // Если последний компонент в адресе не пустой (обычно там хранятся названия файлов) - берем его
    if (![lastComponent isEqualToString: @""]) {
        return lastComponent;
    } else {
        // В противном случае попробуем разбить url на части и возьмем последний элемент (название директории документа обычно)
        NSString *lastString = [[lastComponent componentsSeparatedByString:@"/"] lastObject];
        
        if (![lastString isEqualToString:@""]) {
            return lastString;
        } else {
            // В противном случае просто вернём таймштамп
            return [NSString stringWithFormat:@"%f", [NSDate timeIntervalSinceReferenceDate]];
        }
    }
        
    return nil;
}

- (void)setPhotoToDiskFor:(NSURL *)urlString :(UIImage *)imageData {
    NSString *fileName = [self getFileNameFrom:urlString];
    NSURL *fullFileCachedPath = [_cacheDirURL URLByAppendingPathComponent:fileName];
    NSData *pngData = UIImagePNGRepresentation(imageData);
    
    @try {
        [pngData writeToURL:fullFileCachedPath atomically:YES];
    } @catch (NSException *e) {
        
    }
}

- (UIImage *)getPhotoFromDiskBy:(NSURL *)url {
    NSString *fileName = [self getFileNameFrom:url];
    NSURL *fullFileCachedPath = [_cacheDirURL URLByAppendingPathComponent:fileName];
    NSTimeInterval cacheTime = 60 * 60;
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:fullFileCachedPath.path]) {
        @try {
            NSDate *modificationTime = [[[NSFileManager defaultManager] attributesOfItemAtPath:fullFileCachedPath.path error:nil] fileModificationDate];
            NSTimeInterval cahedInterval = [[NSDate date] timeIntervalSinceDate:modificationTime];
            
            // Время кэша не истекло
            if (cahedInterval <= cacheTime) {
                UIImage *returnImage = [UIImage imageWithContentsOfFile:fullFileCachedPath.path];
                
                if (returnImage != nil) {
                    return returnImage;
                }
            }
            
        } @catch (NSException *e){
            return nil;
        }
    }
    
    
    return nil;
}
   

- (void)getPhotoBy:(NSURL *)url :(void(^)(UIImage *data))completion {
    // Пытаемся получить фотографию с диска
    UIImage *cachedImage = [self getPhotoFromDiskBy:url];
    
    // Файла в кэше нет
    if (cachedImage == nil) {
        [[NetworkService instance] getImageByImage:url :^(NSData * _Nonnull data) {
            UIImage *imageFromData = [UIImage imageWithData:data];
            
            // Пытаемся сохранить файл на диск
            [self setPhotoToDiskFor:url :imageFromData];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(imageFromData);
            });
        }];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(cachedImage);
        });
    }
}

@end
