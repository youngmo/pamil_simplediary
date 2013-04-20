//
//  PhotoCell.h
//  Pamil
//
//  Created by an_yommo on 13/04/20.
//  Copyright (c) 2013年 an_yommo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoCell : UICollectionViewCell {
    IBOutlet UIImageView *imageView;
}

- (void)setImage:(UIImage *)image;

@end
