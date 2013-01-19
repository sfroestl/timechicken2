//
//  WebserviceDetailViewController.h
//  TimeChicken
//
//  Created by Sebastian Fröstl on 15.01.13.
//  Copyright (c) 2013 Christian Schäfer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCRestClientDelegate.h"
#import "TCRestClient.h"


@class TCWebserviceEntity;
@class TCRestClient;


@interface WebserviceDetailVC : UIViewController<TCRestClientDelegate> {
    TCRestClient *restClient;
    __weak IBOutlet UITextField *titleField;
    __weak IBOutlet UITextField *usernameField;
    __weak IBOutlet UITextField *passwordField;
    __weak IBOutlet UILabel *lastSyncLabel;
}
@property (strong, nonatomic) TCWebserviceEntity *detailItem;

- (IBAction)fetchTaskButtonPressed:(id)sender;

@end
