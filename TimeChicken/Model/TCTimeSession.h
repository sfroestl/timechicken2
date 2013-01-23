//
//  TimeSession.h
//  TimeChicken
//
//  Created by Christian Schäfer on 21.01.13.
//  Copyright (c) 2013 Christian Schäfer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TCTimeSession : NSObject <NSCoding>

@property (strong, nonatomic) NSDate *start;
@property (strong, nonatomic) NSDate *end;

- (id)initWithStart:(NSDate *) startDate;

-(int)durationInSeconds;
-(NSString *)durationAsString;
-(NSString *)durationAsString2;

@end
