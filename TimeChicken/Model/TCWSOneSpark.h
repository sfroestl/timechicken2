//
//  TCWSOneSpark.h
//  TimeChicken
//
//  Created by Sebastian Fröstl on 15.01.13.
//  Copyright (c) 2013 Christian Schäfer. All rights reserved.
//

#import "TCWebserviceEntity.h"
#import "TCTask.h"

@interface TCWSOneSpark : TCWebserviceEntity



- (id) initWithBaseUrl:(NSURL *)baseUrl andTitle: (NSString *)title;

@end
