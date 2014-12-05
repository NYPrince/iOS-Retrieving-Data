//
//  DetailViewController.m
//  RssFeed
//
//  Created by Rick Williams on 6/30/14.
//  Copyright (c) 2014 Rick Williams. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize appleArticle;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    
   
    self.titeLabel.text = [self.entry title];
    self.MytextView.text = [self.entry summary];
   ;
    
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated

{
    [super viewWillAppear:animated];
    NSDictionary *imageDict = self.entry.images[0];
    NSURL* url = [NSURL URLWithString:imageDict[@"label"]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage * image = [UIImage imageWithData:data];
    
    
    self.imageView.image = image;
    
}

@end
