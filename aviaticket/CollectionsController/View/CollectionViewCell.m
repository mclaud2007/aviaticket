//
//  CollectionViewCell.m
//  aviaticket
//
//  Created by Григорий Мартюшин on 21.06.2020.
//  Copyright © 2020 Григорий Мартюшин. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self != nil) {
        [self configrueView];
    }
    
    return self;
}

- (void)configrueView {
    CGRect rect = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    self.imgPhoto = [[UIImageView alloc] initWithFrame:rect];
    [self addSubview:self.imgPhoto];
}

- (void)prepareForReuse {
    self.imgPhoto.image = nil;
}

@end
