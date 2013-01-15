//
//  TCWebservice.h
//  WebserviceConnector
//
//  Created by Sebastian Fröstl on 15.01.13.
//  Copyright (c) 2013 Sebastian Fröstl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TCWebservice : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) UIImage *image;

- (id) initWithTitle:(NSString *)title;

@end
