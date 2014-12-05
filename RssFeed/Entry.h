//
//  Entry.h
//  RssFeed
//
//  Created by Rick Williams on 7/2/14.
//  Copyright (c) 2014 Rick Williams. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Entry : NSObject

@property(nonatomic, strong)NSString * title;

@property(nonatomic,strong)NSString * summary;

@property(nonatomic, strong)NSMutableArray * images;

@property(nonatomic, strong)NSString * artist;

@end
