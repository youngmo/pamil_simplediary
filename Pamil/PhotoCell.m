//
//  PhotoCell.m
//  Pamil
//
//  Created by an_yommo on 13/04/20.
//  Copyright (c) 2013年 an_yommo. All rights reserved.
//

#import "PhotoCell.h"

@implementation PhotoCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, self.frame.size.width - 4, self.frame.size.height-4)];
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:imageView];
    }
    return self;
}

- (void)setImage:(UIImage *)image {
    [imageView setImage:image];
}

@end
