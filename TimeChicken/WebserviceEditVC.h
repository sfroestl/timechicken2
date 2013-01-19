//
//  WebserviceEditVC.h
//  TimeChicken
//
//  Created by Sebastian Fröstl on 18.01.13.
//  Copyright (c) 2013 Christian Schäfer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCRestClientDelegate.h"
@class TCWebservice;
@class TCWSOneSpark;
@class OneSparkRestClient;

@interface WebserviceEditVC : UITableViewController <TCRestClientDelegate> {
    TCRestClient *restClient;
}

@property (strong, nonatomic) TCWebservice *detailItem;

- (void) proveWs;
- (void) saveWs;
- (void) cancel;


@end
