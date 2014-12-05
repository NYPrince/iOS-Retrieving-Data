//
//  DetailViewController.h
//  RssFeed
//
//  Created by Rick Williams on 6/30/14.
//  Copyright (c) 2014 Rick Williams. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Entry.h"

@interface DetailViewController : UIViewController{
    NSDictionary * appleArticle;
}

@property(nonatomic, strong) Entry *entry;

@property(nonatomic,copy)NSDictionary * appleArticle;

@property (weak, nonatomic) IBOutlet UILabel *titeLabel;

@property (weak, nonatomic) IBOutlet UITextView *MytextView;

@property (strong, nonatomic) IBOutlet UIImageView *imageView;


@end
