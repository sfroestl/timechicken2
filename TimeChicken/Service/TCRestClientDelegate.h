//
//  TCRestClientDelegate.h
//  TimeChicken
//
//  Created by Sebastian Fröstl on 18.01.13.
//  Copyright (c) 2013 Christian Schäfer. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OSTestRestClient;

@protocol TCRestClientDelegate <NSObject>

@required
- (void) resetClientFinished:(OSTestRestClient*)restClient;
- (void) restClient:(OSTestRestClient*)restClient failedWithError:(NSError*)error;

@end

