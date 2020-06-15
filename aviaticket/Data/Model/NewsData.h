// To parse this JSON:
//
//   NSError *error;
//   NewsWelcome *welcome = [NewsWelcome fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class NewsData;
@class NewsArticle;
@class NewsSource;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Object interfaces

@interface NewsData : NSObject
@property (nonatomic, nullable, copy)   NSString *status;
@property (nonatomic, nullable, strong) NSNumber *totalResults;
@property (nonatomic, nullable, copy)   NSArray<NewsArticle *> *articles;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface NewsArticle : NSObject
@property (nonatomic, nullable, strong) NewsSource *source;
@property (nonatomic, nullable, copy)   id author;
@property (nonatomic, nullable, copy)   NSString *title;
@property (nonatomic, nullable, copy)   NSString *theDescription;
@property (nonatomic, nullable, copy)   NSString *url;
@property (nonatomic, nullable, copy)   NSString *urlToImage;
@property (nonatomic, nullable, copy)   NSString *publishedAt;
@property (nonatomic, nullable, copy)   NSString *content;
@end

@interface NewsSource : NSObject
@property (nonatomic, nullable, copy) id identifier;
@property (nonatomic, nullable, copy) NSString *name;
@end

NS_ASSUME_NONNULL_END
