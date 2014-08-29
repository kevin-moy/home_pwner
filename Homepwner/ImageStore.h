//
//  ImageStore.h
//  Homepwner
//
//  Created by Kevin Moy on 8/27/14.
//  Copyright (c) 2014 Kevin Moy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageStore : NSObject

+ (instancetype)sharedStore;

- (void)setImage:(UIImage *)image forKey:(NSString *)key;
- (UIImage *)imageForKey:(NSString *)key;
- (void)deleteImageForKey:(NSString *)key;

@end
