//
//  ItemStore.m
//  Homepwner
//
//  Created by Kevin Moy on 8/21/14.
//  Copyright (c) 2014 Kevin Moy. All rights reserved.
//

#import "ItemStore.h"
#import "Item.h"
#import "ImageStore.h"

@interface ItemStore ()

@property (nonatomic) NSMutableArray *privateItems;

@end

@implementation ItemStore

+ (instancetype)sharedStore
{
    static ItemStore *sharedStore;
    
    // Do I need to create sharedStore?
    if (!sharedStore) {
        sharedStore = [[self alloc] initPrivate];
    }
    return sharedStore;
}

- (instancetype)init
{
    [NSException raise:@"Singleton" format:@"Use + [ItemStore sharedStore]"];
    return nil;
}

- (instancetype)initPrivate
{
    self = [super init];
    if (self) {
        NSString *path = [self itemArchivePath];
        _privateItems = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        
        // If array hadn't been saved, creat new empty one
        if (!_privateItems) {
            _privateItems = [[NSMutableArray alloc] init];
        }
    }
    return self;
}
- (NSArray *)allItems
{
    return [self.privateItems copy];
}

// Create a new item that user can change
- (Item *)createItem
{
    Item *item = [[Item alloc] init];
    
    [self.privateItems addObject:item];
    
    return item;
}
- (void)removeItem:(Item *)item
{
    NSString *key = item.itemKey;
    [[ImageStore sharedStore] deleteImageForKey:key];
    
    [self.privateItems removeObjectIdenticalTo:item];
}

- (void)moveItemAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex
{
    if (fromIndex == toIndex) {
        return;
    }
    // Get pointer to object being moved so can re-insert it
    Item *item = self.privateItems[fromIndex];
    
    // Remove item from array
    [self.privateItems removeObjectAtIndex:fromIndex];
    
    // Insert item in array at new location
    [self.privateItems insertObject:item atIndex:toIndex];
    
}

- (NSString *)itemArchivePath
{
    // Make sure first argument is NSDocumentDictionary and not NSDocumentationDictionary
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    // Get one document directory from that list
    NSString *documentDirectory = [documentDirectories firstObject];
    
    return [documentDirectory stringByAppendingPathComponent:@"items.archive"];
}

- (BOOL)saveChanges
{
    NSString *path = [self itemArchivePath];
    
    // Return yes on success
    return [NSKeyedArchiver archiveRootObject:self.privateItems toFile:path];
}

@end
