//
//  Day.h
//  Simple Diary_
//
//  Created by an_yommo on 13/03/28.
//
//

#import <Foundation/Foundation.h>

@interface Day : NSObject

@property double time;
@property NSString *title;
@property NSString *content;

- (id)initWithTime:(double)time title:(NSString *)title content:(NSString *)content;

@end
