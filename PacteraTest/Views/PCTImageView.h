//
//  PCTImageView.h
//  PacteraTest
//
//  Created by Lubor Kolacny on 13/03/2015.
//  Copyright (c) 2015 Lubor Kolacny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PCTImageView : UIImageView

@property (copy,nonatomic,setter=setUrlString:) NSString *urlString;

- (void)updateImageFromCache;

@end
