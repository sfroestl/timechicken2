//
//  TimeSession.m
//  TimeChicken
//
//  Created by Christian Schäfer on 21.01.13.
//  Copyright (c) 2013 Christian Schäfer. All rights reserved.
//

#import "TimeSession.h"

@implementation TimeSession

@synthesize start = _start;
@synthesize end = _end;

-(id)initWithStart:(NSDate *)startDate{
    self = [super init];
    if(self){
        self.start = startDate;
    }
    return self;
}

-(NSString *)getDurationAsString{
    NSString *out = @"running";
    if((self.start!=nil)&&(self.end!=nil)){        
        NSTimeInterval secondsBetween = [self.end timeIntervalSinceDate:self.start];
        int seconds = (int) secondsBetween;
        int days = 0;
        int hours = 0;
        int minutes = 0;
        
        if (seconds >= 60)
        {
            minutes = seconds / 60;
            seconds = seconds % 60;
            if (minutes >= 60)
            {
                hours = minutes / 60;
                minutes = minutes % 60;
                if(hours>=24)
                {
                    days = hours / 24;
                    hours = hours % 24;
                }
            }
        };
        
        NSString *hourString;
        NSString *minuteString;
        NSString *secondsString;
        
        if(hours<10) hourString = [NSString stringWithFormat:@"0%d",hours];
        else hourString = [NSString stringWithFormat:@"%d",hours];
        
        if(minutes<10) minuteString = [NSString stringWithFormat:@"0%d",minutes];
        else minuteString = [NSString stringWithFormat:@"%d",minutes];
        
        if(seconds<10) secondsString = [NSString stringWithFormat:@"0%d",seconds];
        else secondsString = [NSString stringWithFormat:@"%d",seconds];
        
        out = [NSString stringWithFormat:@"%@:%@:%@",hourString,minuteString,secondsString];
        
        if(days==1) out = [NSString stringWithFormat:@"1d %@:%@:%@",hourString,minuteString,secondsString];
        if(days>1) out= [NSString stringWithFormat:@"%dd %@:%@:%@",days, hourString,minuteString,secondsString];
    }
    return out;
}

@end
