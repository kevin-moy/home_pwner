//
//  DetailViewController.m
//  Homepwner
//
//  Created by Kevin Moy on 8/26/14.
//  Copyright (c) 2014 Kevin Moy. All rights reserved.
//

#import "DetailViewController.h"
#import "Item.h"
#import "ImageStore.h"

@interface DetailViewController ()

<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *serialNumberField;
@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;


@end

@implementation DetailViewController
- (IBAction)backgroundTapped:(id)sender
{
    [self.view endEditing:YES];
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // get picked image from info dictionary
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    // Store Image in ImageStore for this key
    [[ImageStore sharedStore] setImage:image forKey:self.item.itemKey];
    
    // put image onto screen in our image view
    self.imageView.image = image;
    
    // take image picker off screen, must call this dismiss method
    [self dismissViewControllerAnimated:YES completion:NULL];
    
}
- (IBAction)takePicture:(id)sender
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    // If device has camera take picture, otherwise pick from photo library
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    imagePicker.delegate = self;
    
    // Place image picker on screen
    [self presentViewController:imagePicker animated:YES completion:NULL];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    Item *item = self.item;
    
    self.nameField.text = item.itemName;
    self.serialNumberField.text = item.serialNumber;
    
    self.valueField.keyboardType = UIKeyboardTypeNumberPad;
    self.valueField.text = [NSString stringWithFormat:@"%d", item.valueInDollars];
    
    
    // Need NSDateFormatter that will turn date into simple date string static NSDateFormatter *dateFormatter
    static NSDateFormatter *dateFormatter;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
    }
    
    // Use filtered NSDate object to set dateLabel Contents
    self.dateLabel.text = [dateFormatter stringFromDate:item.dateCreated];
    
    NSString *itemKey = self.item.itemKey;
    
    // Get image for its image key from image store
    UIImage *imageToDisplay = [[ImageStore sharedStore] imageForKey:itemKey];
    
    // Use image to put on screen in imageView
    self.imageView.image = imageToDisplay;
    
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    //Clear first responder
    [self.view endEditing:YES];
    
    // "Save" changes to item
    Item *item = self.item;
    item.itemName = self.nameField.text;
    item.serialNumber = self.serialNumberField.text;
    item.valueInDollars = [self.valueField.text intValue];
    
}

- (void)setItem:(Item *)item
{
    _item = item;
    self.navigationItem.title = item.itemName;
}

@end
