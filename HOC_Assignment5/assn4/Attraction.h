//
//  Attraction.h
//  assn4
//
//  Created by Frank Lu on 2015-01-12.
//  Copyright (c) 2015 Frank Lu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Attraction : NSObject <NSCoding>

@property (nonatomic, strong) NSString * abbrev;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * location;
@property (nonatomic, strong) NSString * lastVisit;
@property (nonatomic, assign) double rating;
@property (nonatomic, strong) UIImage *pic;
@property (nonatomic, strong) NSString * comment;
@property (nonatomic, strong) UIImage *image;

@end
