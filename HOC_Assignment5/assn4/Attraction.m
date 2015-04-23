//
//  Attraction.m
//  assn4
//
//  Created by Frank Lu on 2015-01-12.
//  Copyright (c) 2015 Frank Lu. All rights reserved.
//
#import "Attraction.h"

static NSString *abbrevKey = @"AAbbrevKey";
static NSString *nameKey = @"ANameKey";
static NSString *locationKey = @"ALocationKey";
static NSString *lastvisitKey = @"ALastvisitKey";
static NSString *attractionImageKey = @"AAttractionImageKey";
static NSString *commentKey = @"ACommentKey";
static NSString *ratingKey = @"ARatingKey";
static NSString *imageKey = @"AImageKey";

@implementation Attraction

-(instancetype) initWithCoder:(NSCoder *)coder
{
    self.abbrev = [coder decodeObjectForKey: abbrevKey];
    self.name = [coder decodeObjectForKey: nameKey];
    self.location = [coder decodeObjectForKey:locationKey];
    self.lastVisit = [coder decodeObjectForKey:lastvisitKey];
    self.comment = [coder decodeObjectForKey:commentKey];
    self.rating =  [coder decodeDoubleForKey:ratingKey];
    
    NSData *imageData = [coder decodeObjectForKey:imageKey];
    if (imageData)
    {
        self.image =[UIImage imageWithData:imageData];
    }
    
    return  self;
}
-(void) encodeWithCoder:(NSCoder *)coder
{
    NSLog(@"%@ %@", self.abbrev, self.name);
    [coder encodeObject:self.abbrev forKey:abbrevKey];
    [coder encodeObject:self.name forKey:nameKey];
    [coder encodeObject:self.location forKey:locationKey];
    [coder encodeObject:self.lastVisit forKey:lastvisitKey];
    [coder encodeDouble:self.rating forKey:ratingKey];
    
    NSData *imageData = UIImagePNGRepresentation(self.image);
    [coder encodeObject:imageData forKey:imageKey];
}
-(NSComparisonResult) compare: (Attraction *) otherObject
{
    return [self.name compare:otherObject.name];
}
@end
