//
//  NewsDetailView.m
//  aviaticket
//
//  Created by Григорий Мартюшин on 31.05.2020.
//  Copyright © 2020 Григорий Мартюшин. All rights reserved.
//

#import "NewsDetailView.h"

@implementation NewsDetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configureUI];
    }
    return self;
}

- (void)configureUI {
    self.backgroundColor = [UIColor whiteColor];
    
    // Создаем лейбл для названия новости
    self.lblTitle = [[UILabel alloc] init];
    self.lblTitle.translatesAutoresizingMaskIntoConstraints = false;
    self.lblTitle.font = [UIFont systemFontOfSize:17];
    self.lblTitle.numberOfLines = 3;
    self.lblTitle.textColor = [UIColor blackColor];
    [self addSubview:self.lblTitle];
    
    // Создаем лейбл для источника новости
    self.lblSourceTitle = [[UILabel alloc] init];
    self.lblSourceTitle.translatesAutoresizingMaskIntoConstraints = false;
    self.lblSourceTitle.font = [UIFont systemFontOfSize:14];
    self.lblSourceTitle.textColor = [UIColor blackColor];
    self.lblSourceTitle.text = NSLocalizedString(@"sourceTitle", @"");
    [self addSubview:self.lblSourceTitle];
    
    self.lblSource = [[UILabel alloc] init];
    self.lblSource.translatesAutoresizingMaskIntoConstraints = false;
    self.lblSource.font = [UIFont systemFontOfSize:14];
    self.lblSource.textColor = [UIColor blueColor];
    [self addSubview:self.lblSource];

    // Создаем лейбл для даты публикации новости
    self.lblDateTitle = [[UILabel alloc] init];
    self.lblDateTitle.translatesAutoresizingMaskIntoConstraints = false;
    self.lblDateTitle.font = [UIFont systemFontOfSize:14];
    self.lblDateTitle.textColor = [UIColor blackColor];
    self.lblDateTitle.text = NSLocalizedString(@"publicationDate", @"");
    [self addSubview:self.lblDateTitle];
    
    self.lblDate = [[UILabel alloc] init];
    self.lblDate.translatesAutoresizingMaskIntoConstraints = false;
    self.lblDate.font = [UIFont systemFontOfSize:14];
    self.lblDate.textColor = [UIColor blueColor];
    [self addSubview:self.lblDate];
    
    // Создаем блок для текста новости
    self.lblContent = [[UILabel alloc] init];
    self.lblContent.translatesAutoresizingMaskIntoConstraints = false;
    self.lblContent.font = [UIFont systemFontOfSize:12];
    self.lblContent.textColor = [UIColor blackColor];
    self.lblContent.numberOfLines = 50;
    self.lblContent.textAlignment = NSTextAlignmentJustified;
    [self addSubview:self.lblContent];
    
    // Создаем блок под фотографию для новости
    self.imgNews = [[UIImageView alloc] init];
    self.imgNews.translatesAutoresizingMaskIntoConstraints = false;
    self.imgNews.contentMode = UIViewContentModeScaleAspectFill;
    self.imgNews.clipsToBounds = true;
    self.imgNews.layer.cornerRadius = 10;
    [self addSubview:self.imgNews];
    
    // Расставляем констрейнты
    NSLayoutConstraint *lblTitleTop = [NSLayoutConstraint constraintWithItem:self.lblTitle attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.safeAreaLayoutGuide attribute:NSLayoutAttributeTop multiplier:1 constant:10];
    NSLayoutConstraint *lblTitleLeft = [NSLayoutConstraint constraintWithItem:self.lblTitle attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.safeAreaLayoutGuide attribute:NSLayoutAttributeLeft multiplier:1 constant:10];
    NSLayoutConstraint *lblTitleRight = [NSLayoutConstraint constraintWithItem:self.lblTitle attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.safeAreaLayoutGuide attribute:NSLayoutAttributeRight multiplier:1 constant:-10];
    
    // Фотография новости
    NSLayoutConstraint *imgNewsTop = [NSLayoutConstraint constraintWithItem:self.imgNews attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.lblTitle attribute:NSLayoutAttributeBottom multiplier:1 constant:10];
    NSLayoutConstraint *imgNewsLeft = [NSLayoutConstraint constraintWithItem:self.imgNews attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.safeAreaLayoutGuide attribute:NSLayoutAttributeLeft multiplier:1 constant:10];
    NSLayoutConstraint *imgNewsRight = [NSLayoutConstraint constraintWithItem:self.imgNews attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.safeAreaLayoutGuide attribute:NSLayoutAttributeRight multiplier:1 constant:-10];
    NSLayoutConstraint *imgNewsHeight = [NSLayoutConstraint constraintWithItem:self.imgNews attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationLessThanOrEqual toItem:self.imgNews attribute:NSLayoutAttributeWidth multiplier:0.6 constant:10];
    
    // Содержание новости
    NSLayoutConstraint *lblContentTop = [NSLayoutConstraint constraintWithItem:self.lblContent attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.imgNews attribute:NSLayoutAttributeBottom multiplier:1 constant:10];
    NSLayoutConstraint *lblContentLeft = [NSLayoutConstraint constraintWithItem:self.lblContent attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.safeAreaLayoutGuide attribute:NSLayoutAttributeLeft multiplier:1 constant:10];
    NSLayoutConstraint *lblContentRight = [NSLayoutConstraint constraintWithItem:self.lblContent attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.safeAreaLayoutGuide attribute:NSLayoutAttributeRight multiplier:1 constant:-10];

    // Источник
    NSLayoutConstraint *lblSourceTitleTop = [NSLayoutConstraint constraintWithItem:self.lblSourceTitle attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.lblContent attribute:NSLayoutAttributeBottom multiplier:1 constant:10];
    NSLayoutConstraint *lblSourceTitleLeft = [NSLayoutConstraint constraintWithItem:self.lblSourceTitle attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.safeAreaLayoutGuide attribute:NSLayoutAttributeLeft multiplier:1 constant:10];
    
    NSLayoutConstraint *lblSourceTop = [NSLayoutConstraint constraintWithItem:self.lblSource attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.lblSourceTitle attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    NSLayoutConstraint *lblSourceLeft = [NSLayoutConstraint constraintWithItem:self.lblSource attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.lblSourceTitle attribute:NSLayoutAttributeRight multiplier:1 constant:5];
    
    // Дата публикации
    NSLayoutConstraint *lblDateTitleTop = [NSLayoutConstraint constraintWithItem:self.lblDateTitle attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.lblSourceTitle attribute:NSLayoutAttributeBottom multiplier:1 constant:5];
    NSLayoutConstraint *lblDateTitleLeft = [NSLayoutConstraint constraintWithItem:self.lblDateTitle attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.safeAreaLayoutGuide attribute:NSLayoutAttributeLeft multiplier:1 constant:10];
    
    NSLayoutConstraint *lblDateTop = [NSLayoutConstraint constraintWithItem:self.lblDate attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.lblDateTitle attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    NSLayoutConstraint *lblDateLeft = [NSLayoutConstraint constraintWithItem:self.lblDate attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.lblDateTitle attribute:NSLayoutAttributeRight multiplier:1 constant:5];
    
    // Массив констрейнтов
    NSArray *constraint = [NSArray arrayWithObjects:lblTitleTop,lblTitleLeft, lblTitleRight,
                                                    imgNewsTop, imgNewsLeft, imgNewsRight, imgNewsHeight,
                                                    lblContentLeft, lblContentRight, lblContentTop,
                                                    lblSourceTitleTop, lblSourceTitleLeft,
                                                    lblSourceTop, lblSourceLeft,
                                                    lblDateTitleTop, lblDateTitleLeft,
                                                    lblDateTop, lblDateLeft,
                           
                           nil];
    
    [NSLayoutConstraint activateConstraints:constraint];
}

@end
