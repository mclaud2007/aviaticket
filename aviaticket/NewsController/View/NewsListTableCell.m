//
//  NewsListTableCell.m
//  aviaticket
//
//  Created by Григорий Мартюшин on 31.05.2020.
//  Copyright © 2020 Григорий Мартюшин. All rights reserved.
//

#import "NewsListTableCell.h"

@implementation NewsListTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self configureUI];
    }
    
    return self;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.lblTitle.text = @"";
    self.lblDescription.text = @"";
    self.imgNews.image = nil;
}

- (void)configureWithNews:(News *)news {
    self.lblTitle.text = news.title;
    self.lblDescription.text = news.short_description;
    
    // Есть картинка
    if (news.imageUrl != nil) {
        // Загружаем фотографию
        [[PhotoService instance] getPhotoBy:news.imageUrl :^(UIImage * _Nonnull data) {
            if (data != nil) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.imgNews.image = data;
                });
            }
            // Ошибка загрузки фотографии
            else {
                self.imgNews.image = [UIImage imageNamed:@"nonews"];
            }
        }];
    } 
}

- (void)configureUI {
    self.lblTitle = [[UILabel alloc] init];
    self.lblTitle.translatesAutoresizingMaskIntoConstraints = false;
    self.lblTitle.font = [UIFont systemFontOfSize:14];
    self.lblTitle.textColor = [UIColor blackColor];
    [self addSubview:self.lblTitle];
    
    self.lblDescription = [[UILabel alloc] init];
    self.lblDescription.translatesAutoresizingMaskIntoConstraints = false;
    self.lblDescription.numberOfLines = 5;
    self.lblDescription.font = [UIFont systemFontOfSize:12];
    self.lblDescription.textColor = [UIColor grayColor];
    [self addSubview:self.lblDescription];
    
    self.imgNews = [[UIImageView alloc] init];
    self.imgNews.clipsToBounds = YES;
    self.imgNews.layer.masksToBounds = YES;
    self.imgNews.layer.cornerRadius = 5;
    self.imgNews.contentMode = UIViewContentModeScaleAspectFill;
    self.imgNews.translatesAutoresizingMaskIntoConstraints = false;
    
    [self addSubview:self.imgNews];
    
    NSLayoutConstraint *widthImage = [NSLayoutConstraint constraintWithItem:self.imgNews attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:100];
    NSLayoutConstraint *heightImage = [NSLayoutConstraint constraintWithItem:self.imgNews attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationLessThanOrEqual toItem:self.imgNews attribute:NSLayoutAttributeHeight multiplier:1 constant:1];
    NSLayoutConstraint *topImage = [NSLayoutConstraint constraintWithItem:self.imgNews attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.safeAreaLayoutGuide attribute:NSLayoutAttributeTop multiplier:1 constant:10];
    NSLayoutConstraint *leftImage = [NSLayoutConstraint constraintWithItem:self.imgNews attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.safeAreaLayoutGuide attribute:NSLayoutAttributeLeft multiplier:1 constant:10];
    NSLayoutConstraint *bottomImage = [NSLayoutConstraint constraintWithItem:self.imgNews attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.safeAreaLayoutGuide attribute:NSLayoutAttributeBottom multiplier:1 constant:-10];
    
    NSLayoutConstraint *leftLblTitle = [NSLayoutConstraint constraintWithItem:self.lblTitle attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.imgNews attribute:NSLayoutAttributeRight multiplier:1 constant:5];
    NSLayoutConstraint *topLblTitle = [NSLayoutConstraint constraintWithItem:self.lblTitle attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.safeAreaLayoutGuide attribute:NSLayoutAttributeTop multiplier:1 constant:10];
    NSLayoutConstraint *rightLblTitle = [NSLayoutConstraint constraintWithItem:self.lblTitle attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.safeAreaLayoutGuide attribute:NSLayoutAttributeRight multiplier:1 constant:-10];
    
    NSLayoutConstraint *lblDescriptionLeft = [NSLayoutConstraint constraintWithItem:self.lblDescription attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.lblTitle attribute:NSLayoutAttributeLeft multiplier:1 constant:1];
    NSLayoutConstraint *lblDescriptionRight = [NSLayoutConstraint constraintWithItem:self.lblDescription attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.safeAreaLayoutGuide attribute:NSLayoutAttributeRight multiplier:1 constant:-10];
    NSLayoutConstraint *lblDescriptionTop = [NSLayoutConstraint constraintWithItem:self.lblDescription attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.lblTitle attribute:NSLayoutAttributeBottom multiplier:1 constant:5];
    
    // Массив констрейнтов для активации
    NSArray *constraints = [NSArray arrayWithObjects:widthImage, heightImage, topImage, leftImage, topLblTitle, bottomImage, leftLblTitle, rightLblTitle, lblDescriptionTop, lblDescriptionLeft, lblDescriptionRight, nil];
    
    // Активируем констрейнты
    [NSLayoutConstraint activateConstraints:constraints];
}

@end
