//
//  CoreDataStack.m
//  aviaticket
//
//  Created by Григорий Мартюшин on 05.07.2020.
//  Copyright © 2020 Григорий Мартюшин. All rights reserved.
//

#import "CoreDataStack.h"

@interface CoreDataStack()

@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;

@end

@implementation CoreDataStack

+(instancetype)shared
{
    static CoreDataStack *instance;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[CoreDataStack alloc] init];
        [instance setup];
    });
    
    return instance;
}

- (void)setup
{
    // Создем модель
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Favorites" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    // Ищем адрес директории документов пользоателя
    NSURL *docsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSURL *storeURL = [docsURL URLByAppendingPathComponent:@"base.sqlite"];
    
    // Регистрируем координатор
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_managedObjectModel];
    
    NSPersistentStore* store = [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:nil];
    
    if (!store) {
        abort();
    }
    
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    _managedObjectContext.persistentStoreCoordinator = _persistentStoreCoordinator;
    
}

- (void)save
{
    NSError *error;
    [_managedObjectContext save: &error];
    
    if(error) {
        NSLog(@"%@", [error localizedDescription]);
    } else {
        NSLog(@"Context saved!");
    }
}

- (void)addToFavorite:(News *)news
{
    FavoriteNews *favorite = [NSEntityDescription insertNewObjectForEntityForName:@"FavoriteNews" inManagedObjectContext:_managedObjectContext];
    
    if (news.url != nil) {
        favorite.id = [NSString stringWithFormat:@"%lu", [news.url.absoluteString hash]];
    }
    
    favorite.imageURL = news.imageURL.absoluteString;
    favorite.publiched_at = news.publisherAt;
    favorite.short_description = news.short_description;
    favorite.source = news.source;
    favorite.title = news.title;
    favorite.url = news.url.absoluteString;
    favorite.addDate = [NSDate date];
    
    // А также отправляем данные в iCloud, но только в том случае, если удалось создать id для новости
    if (favorite.id != nil) {
        CKRecordID *newsId = [[CKRecordID alloc] initWithRecordName:favorite.id];
        CKRecord *publicationRecord = [[CKRecord alloc] initWithRecordType:@"Favorites" recordID:newsId];
        
        publicationRecord[@"imageURL"] = favorite.imageURL;
        publicationRecord[@"publichedAt"] = favorite.publiched_at;
        publicationRecord[@"shortDescription"] = favorite.short_description;
        publicationRecord[@"source"] = favorite.source;
        publicationRecord[@"title"] = favorite.title;
        publicationRecord[@"url"] = favorite.url;
        publicationRecord[@"addDate"] = favorite.addDate;
        
        // Получаем экземпляр базы данных
        CKContainer *container = [CKContainer containerWithIdentifier:@"iCloud.im.mga.aviaticket.cloudcontainer"];
        CKDatabase *publicDatabase = [container publicCloudDatabase];
        
        // Сохранение записи
        [publicDatabase saveRecord:publicationRecord completionHandler:^(CKRecord * _Nullable record, NSError * _Nullable error) {
            
            if (error) {
                NSLog(@"%@", error);
                NSLog(@"Can't save in iCloud");
                return;
            }
        }];
    }
    
    [self save];
    
}

- (FavoriteNews *)favoriteFromNews:(News *)news {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"FavoriteNews"];
    
    if (news.url != nil) {
        NSUInteger newsHash = [news.url.absoluteString hash];
        NSString *newsId = [NSString stringWithFormat:@"%lu", newsHash];
        
        request.predicate = [NSPredicate predicateWithFormat:@"id == %@", newsId];
    } else {
        request.predicate = [NSPredicate predicateWithFormat:@"title == %@ AND short_description == %@", news.title, news.short_description];
    }
    
    return [[_managedObjectContext executeFetchRequest:request error:nil] firstObject];
}

- (void)removeFromFavorite:(News *)news
{
    FavoriteNews *favorite = [self favoriteFromNews:news];
    if(favorite) {
        // А также удалим из iCloud ссылку на эту новость
        if (favorite.id) {
            CKRecordID *recordID = [[CKRecordID alloc] initWithRecordName:favorite.id];
            CKContainer *containter = [CKContainer containerWithIdentifier:@"iCloud.im.mga.aviaticket.cloudcontainer"];
            CKDatabase *publicDatabase = [containter publicCloudDatabase];
            
            // Пытаемся найти запись о новости в iCloud
            [publicDatabase fetchRecordWithID:recordID completionHandler:^(CKRecord * _Nullable record, NSError * _Nullable error) {
                if (!error) {
                    [publicDatabase deleteRecordWithID:recordID completionHandler:^(CKRecordID * _Nullable recordID, NSError * _Nullable error) {
                        
                        if (error) {
                            NSLog(@"Can't del record in iCloud");
                        }
                    }];
                }
            }];
            
            // Удаляем ссылку в локальной базе
            [_managedObjectContext deleteObject:favorite];
        }
        
        [self save];
    }
}

- (void)removeAllFromFavorite
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"FavoriteNews"];
    NSBatchDeleteRequest *delete = [[NSBatchDeleteRequest alloc] initWithFetchRequest:request];
    NSError *deleteError = nil;
    
    [_managedObjectContext executeRequest:delete error:&deleteError];
    [self save];
}

-(NSArray *)favorites {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"FavoriteNews"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"addDate" ascending:false]];
    return [_managedObjectContext executeFetchRequest:request error:nil];
    
}

@end
