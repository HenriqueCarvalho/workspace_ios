//
//  Player.m
//  HOC_project
//
//  Created by Henrique Carvalho on 2015-03-29.
//  Copyright (c) 2015 NIC. All rights reserved.
//

#import "Player.h"

@implementation Player

static NSString * nameKey = @"AnameKey";
static NSString * nicknameKey = @"ANicknameKey";
static NSString * recordKey = @"ARecordKey";

- (instancetype) initWithCoder:(NSCoder *)coder
{
    self.name = [coder decodeObjectForKey:nameKey];
    self.nickname = [coder decodeObjectForKey:nicknameKey];
    self.record = [coder decodeIntegerForKey:recordKey];
    
    return self;
}

- (void) encodeWithCoder:(NSCoder *)coder
{
    NSLog(@"%@ %ld", self.name, (long)self.record);
    
    [coder encodeObject:self.name forKey:nameKey];
    [coder encodeInteger:self.record forKey:recordKey];
}

- (NSComparisonResult) compare:(Player *)otherObject
{
   return [self.nickname compare:otherObject.nickname];
    
}

- (NSComparisonResult) compareRecords:(Player *)otherObject
{
    if (self.record < otherObject.record) {
        return (NSComparisonResult)NSOrderedDescending;
    }
    
    if (self.record > otherObject.record) {
        return (NSComparisonResult)NSOrderedAscending;
    }
    return (NSComparisonResult)NSOrderedSame;
}

- (NSString *) stringForMessaging
{
    return @"empty";
}
@end
