//
//  ItemCell.h
//  Homepwner
//
//  Created by Kevin Moy on 9/10/14.
//  Copyright (c) 2014 Kevin Moy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *serialNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;

@property (copy, nonatomic) void (^actionBlock)(void);

@end
