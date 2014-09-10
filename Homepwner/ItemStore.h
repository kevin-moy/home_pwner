//
//  ItemStore.h
//  Homepwner
//
//  Created by Kevin Moy on 8/21/14.
//  Copyright (c) 2014 Kevin Moy. All rights reserved.
//


#import <Foundation/Foundation.h>

@class Item;
@interface ItemStore : NSObject

@property (nonatomic, readonly, copy) NSArray *allItems;

- (BOOL)saveChanges;
+ (instancetype)sharedStore;
- (Item *)createItem;
- (void)removeItem:(Item *)item;
- (void)moveItemAtIndex:(NSUInteger)fromIndex
                toIndex:(NSUInteger)toIndex;

@end
