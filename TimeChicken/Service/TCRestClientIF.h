//
//  TCRestClientIF.h
//  TimeChicken
//
//  Created by Sebastian Fröstl on 19.01.13.
//  Copyright (c) 2013 Christian Schäfer. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TCRestClientIF <NSObject>

@required
//- (void) fetchUserTaskList;
//- (void) fetchUserProjectList;
- (void)fetchUsername:(void (^)(NSString *username, NSError *error))block;
- (void)setBasicAuthUsername:(NSString *)name andPassword:(NSString *)pw;

@end