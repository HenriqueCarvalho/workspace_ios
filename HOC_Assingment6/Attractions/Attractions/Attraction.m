//
//  Attraction.m
//  Attractions
//
//  Created by Henrique Carvalho on 2015-03-07.
//  Copyright (c) 2015 NIC. All rights reserved.
//

#import "Attraction.h"

static NSString * provinceKey = @"AAProvincevKey";
static NSString * nameKey = @"ANameKey";
static NSString * locationKey = @"ALocationKey";
static NSString * lastvisitKey = @"ALastvisitKey";
static NSString * attractionImageKey = @"AAttractionImageKey";
static NSString * commentKey = @"ACommentKey";
static NSString * ratingKey = @"ARatingKey";
static NSString * imageKey = @"AImageKey";

@implementation Attraction

- (instancetype) initWithCoder:(NSCoder *)coder
{
  self.province = [coder decodeObjectForKey:provinceKey];
  self.name = [coder decodeObjectForKey:nameKey];
  self.location = [coder decodeObjectForKey:locationKey];
  self.lastVisit = [coder decodeObjectForKey:lastvisitKey];
  self.comment = [coder decodeObjectForKey:commentKey];
  self.rating =  [coder decodeDoubleForKey:ratingKey];

  NSData * imageData = [coder decodeObjectForKey:imageKey];
  if (imageData)
  {
    self.image = [UIImage imageWithData:imageData];
  }

  return self;
}

- (NSString *) stringForMessaging
{
  int rounded = lroundf(self.rating * 10);
  NSMutableString * messageString = [NSMutableString stringWithFormat:@"%@\n", self.province];

  // Attraction Name input
  if (self.name.length > 0)
  {
    [messageString appendString:[NSString stringWithFormat:@"Name: %@\n", self.name]];
  }
  else
  {
    [messageString appendString:[NSString stringWithFormat:@"Name: This input is empty.\n"]];
  }

  // Location input
  if (self.location.length > 0)
  {
    [messageString appendString:[NSString stringWithFormat:@"Location: %@\n", self.location]];
  }
  else
  {
    [messageString appendString:[NSString stringWithFormat:@"Location: This input is empty.\n"]];
  }

  // Last Visit input
  if (self.lastVisit.length > 0)
  {
    [messageString appendString:[NSString stringWithFormat:@"Last Visited: %@\n", self.lastVisit]];
  }
  else
  {
    [messageString appendString:@"Last Visit: This input is empty.\n"];
  }

  // Rating input
  [messageString appendString:[NSString stringWithFormat:@"Rating: %d\n", rounded]];

  // Comment input
  if (self.comment.length > 0)
  {
    [messageString appendString:[NSString stringWithFormat:@"Comment: %@\n", self.comment]];
  }
  else
  {
    [messageString appendString:@"Comment: This input is empty.\n"];
  }

  NSLog(@"%@", messageString);

  return messageString;
}

- (void) encodeWithCoder:(NSCoder *)coder
{
  NSLog(@"%@ %@", self.province, self.name);
  [coder encodeObject:self.province forKey:provinceKey];
  [coder encodeObject:self.name forKey:nameKey];
  [coder encodeObject:self.location forKey:locationKey];
  [coder encodeObject:self.lastVisit forKey:lastvisitKey];
  [coder encodeDouble:self.rating forKey:ratingKey];

  NSData * imageData = UIImagePNGRepresentation(self.image);
  [coder encodeObject:imageData forKey:imageKey];
}

- (NSComparisonResult) compare:(Attraction *)otherObject
{
  return [self.name compare:otherObject.name];
}

@end
