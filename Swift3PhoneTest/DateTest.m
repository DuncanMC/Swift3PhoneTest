//
//  DateTest.m
//  Swift3PhoneTest
//
//  Created by Duncan Champney on 11/29/16.
//  Copyright © 2016 Duncan Champney. All rights reserved.
//

#import "DateTest.h"

@implementation DateTest

- (NSDateFormatter *) formatter {
  if (_formatter == nil) {
    _formatter = [[NSDateFormatter alloc] init];
    [_formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    [_formatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
  }
  return _formatter;
}

- (NSDate *) dateFromString: (NSString *) string; {
  return [self.formatter dateFromString: string];
}

@end
