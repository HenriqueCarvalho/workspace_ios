//
//  Book.m
//  Midterm
//
//  Created by Student on 2015-03-04.
//  Copyright (c) 2015 Frank Lu. All rights reserved.
//

#import "Book.h"

static NSString *bookTitleKey = @"AbookTitleKey";
static NSString *bookIsbnKey = @"AbookIsbnKey";
static NSString *authorNameKey = @"AauthorNameKey";
static NSString *publisherKey = @"publisherKey";

@implementation Book

-(id) initWithCoder:(NSCoder*)coder {
    self = [super init];
    self.bookTitle = [coder decodeObjectForKey:bookTitleKey];
    self.bookIsbn = [coder decodeObjectForKey:bookIsbnKey];
    self.authorName = [coder decodeObjectForKey:authorNameKey];
    self.publisher = [coder decodeObjectForKey:publisherKey];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.bookTitle forKey:bookTitleKey];
    [coder encodeObject:self.bookIsbn forKey:bookIsbnKey];
    [coder encodeObject:self.authorName forKey:authorNameKey];
    [coder encodeObject:self.publisher forKey:publisherKey];
}

- (NSComparisonResult)compare:(Book *)otherObject {
    return [self.bookTitle compare:otherObject.bookTitle];
}

@end
