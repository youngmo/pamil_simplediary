//
//  Day.m
//  Simple Diary_
//
//  Created by an_yommo on 13/03/28.
//
//

#import "Day.h"

@implementation Day

@synthesize time = _time, title = _title, content = _content;

- (id)initWithTime:(double)time title:(NSString *)title content:(NSString *)content
{
    self = [super init];
    if (self) {
        _time = time;
        _title = title;
        _content = content;
        return self;
    }
    return nil;
}

@end
