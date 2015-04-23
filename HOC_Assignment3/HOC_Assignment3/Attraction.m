//
//  Attraction.m
//  HOC_Assignment3
//
//  Created by Henrique Carvalho on 2015-02-03.
//  Copyright (c) 2015 Student. All rights reserved.
//

#import "Attraction.h"

static NSString * provinceKey = @"AProvinceKey";
static NSString * attractionNameKey = @"AAttractionNameKey";
static NSString * locationKey = @"ALocationKey";
static NSString * lastVisitedKey = @"ALastVisitedKey";
static NSString * ratingKey = @"ARatingKey";
static NSString * commentKey = @"ACommentKey";

@implementation Attraction

- (id) initWithCoder:(NSCoder *)coder
{
  self = [super init];

  self.province = [coder decodeObjectForKey:provinceKey];
  self.attractionName = [coder decodeObjectForKey:attractionNameKey];
  self.location = [coder decodeObjectForKey:locationKey];
  self.lastVisited = [coder decodeObjectForKey:lastVisitedKey];
  self.rating = [coder decodeIntegerForKey:ratingKey];
  self.comment = [coder decodeObjectForKey:commentKey];

  return self;
}

- (void) encodeWithCoder:(NSCoder *)coder
{
  [coder encodeObject:self.province forKey:provinceKey];
  [coder encodeObject:self.attractionName forKey:attractionNameKey];
  [coder encodeObject:self.location forKey:locationKey];
  [coder encodeObject:self.lastVisited forKey:lastVisitedKey];
  [coder encodeInteger:self.rating forKey:ratingKey];
  [coder encodeObject:self.comment forKey:commentKey];
}

- (NSComparisonResult) compare:(Attraction *)otherObject
{
  return [self.province compare:otherObject.province];
}

@end
