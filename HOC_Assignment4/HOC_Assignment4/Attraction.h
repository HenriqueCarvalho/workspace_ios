//
//  Attraction.h
//  HOC_Assignment4
//
//  Created by Henrique Carvalho on 2015-02-08.
//  Copyright (c) 2015 Student. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Attraction : NSObject <NSCoding>

@property (nonatomic, strong) NSString * province;
@property (nonatomic, strong) NSString * attractionName;
@property (nonatomic, strong) NSString * location;
@property (nonatomic, strong) NSString * lastVisited;
@property (nonatomic, assign) int rating;
@property (nonatomic, strong) NSString * notes;

@end
