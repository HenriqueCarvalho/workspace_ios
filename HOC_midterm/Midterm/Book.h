//
//  Book.h
//  Midterm
//
//  Created by Student on 2015-03-04.
//  Copyright (c) 2015 Frank Lu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Book : NSObject <NSCoding>

@property (nonatomic, strong) NSString *bookTitle;
@property (nonatomic, strong) NSString *bookIsbn;
@property (nonatomic, strong) NSString *authorName;
@property (nonatomic, strong) NSString *publisher;

@end
