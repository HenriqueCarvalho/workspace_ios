//
//  Attraction.h
//  Attractions
//
//  Created by Henrique Carvalho on 2015-03-07.
//  Copyright (c) 2015 NIC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Attraction : NSObject <NSCoding>

@property (nonatomic, strong) NSString * province;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * location;
@property (nonatomic, strong) NSString * lastVisit;
@property (nonatomic, strong) NSString * comment;
@property (nonatomic, assign) double rating;
@property (nonatomic, strong) UIImage * pic;
@property (nonatomic, strong) UIImage * image;

- (NSString *) stringForMessaging;

@end
