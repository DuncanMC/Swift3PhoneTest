//
//  DateTest.h
//  Swift3PhoneTest
//
//  Created by Duncan Champney on 11/29/16.
//  Copyright © 2016 Duncan Champney. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateTest : NSObject

@property (nonatomic, strong) NSDateFormatter *formatter;

- (NSDate *) dateFromString: (NSString *) string;

@end
