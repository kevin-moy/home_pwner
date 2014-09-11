//
//  ItemCell.m
//  Homepwner
//
//  Created by Kevin Moy on 9/10/14.
//  Copyright (c) 2014 Kevin Moy. All rights reserved.
//

#import "ItemCell.h"

@implementation ItemCell

- (IBAction)showImage:(id)sender
{
    if (self.actionBlock) {
        self.actionBlock();
    }
}

@end
