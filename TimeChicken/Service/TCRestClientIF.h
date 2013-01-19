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
- (void) fetchUserTaskList;
- (void) fetchUserProjectList;
- (void) fetchUser;
- (void)setAuthCredentials:(NSString*)userName password:(NSString *)pw;

@end