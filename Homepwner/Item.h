//
//  BNRItem.h
//  RandomItems
//
//  Created by Kevin Moy on 8/13/14.
//  Copyright (c) 2014 Kevin Moy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject <NSCoding>

@property (nonatomic, copy) NSString *itemName;
@property (nonatomic, copy) NSString *serialNumber;
@property (nonatomic) int valueInDollars;
@property (nonatomic, readonly, strong) NSDate *dateCreated;
@property (nonatomic, copy) NSString *itemKey;
@property (strong, nonatomic) UIImage *thumbnail;

+ (instancetype)randomItem;

// Designated initalizer for BNRItem
- (instancetype)initWithItemName:(NSString *)name
                  valueInDollars:(int)value
                    serialNumber:(NSString *)sNumber;
- (instancetype)initWithItemName:(NSString *)name;
- (void)setThumbnailFromImage:(UIImage *)image;

@end