//
//  TCOneSparkRestClient.h
//  TimeChicken
//
//  Created by Sebastian Fröstl on 15.01.13.
//  Copyright (c) 2013 Christian Schäfer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TCOneSparkRestClient : NSURLConnection {
    NSString *projectsUrl;
    NSString *tasksUrl;
    NSString *timesessionUrl;
}

@end
