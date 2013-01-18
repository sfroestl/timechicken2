//
//  TCRestClientDelegate.h
//  TimeChicken
//
//  Created by Sebastian Fröstl on 18.01.13.
//  Copyright (c) 2013 Christian Schäfer. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TCRestClient;

@protocol TCRestClientDelegate <NSObject>

@required
- (void) resetClientFinished:(TCRestClient*)restClient;
- (void) restClient:(TCRestClient*)restClient failedWithError:(NSError*)error;

@end

