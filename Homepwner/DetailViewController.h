//
//  DetailViewController.h
//  Homepwner
//
//  Created by Kevin Moy on 8/26/14.
//  Copyright (c) 2014 Kevin Moy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Item;

@interface DetailViewController : UIViewController

- (instancetype)initForNewItem:(BOOL)isNew;

@property (nonatomic, strong) Item *item;
@property (nonatomic, copy) void (^dimissBlock)(void);

@end
