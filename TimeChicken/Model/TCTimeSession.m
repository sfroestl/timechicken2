//
//  TimeSession.m
//  TimeChicken
//
//  Created by Christian Schäfer on 21.01.13.
//  Copyright (c) 2013 Christian Schäfer. All rights reserved.
//

#import "TCTimeSession.h"

@implementation TCTimeSession

@synthesize start = _start;
@synthesize end = _end;

-(id)initWithStart:(NSDate *)startDate{
    self = [super init];
    if(self){
        self.start = startDate;
    }
    return self;
}

- (int) durationInSeconds {
    return [self.end timeIntervalSinceDate:self.start];
}

-(NSString *)durationAsString {
    NSString *out = @"running";
    if((self.start!=nil)&&(self.end!=nil)){        
        NSTimeInterval secondsBetween = [self.end timeIntervalSinceDate: self.start];
        int seconds = (int) secondsBetween;
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
            }
        };
        
        NSString *hourString;
        NSString *minuteString;
        NSString *secondsString;
        
        if(hours<10) hourString = [NSString stringWithFormat:@"0%d",hours];
        else hourString = [NSString stringWithFormat:@"%d", hours];
        
        if(minutes<10) minuteString = [NSString stringWithFormat:@"0%d",minutes];
        else minuteString = [NSString stringWithFormat:@"%d", minutes];
        
        if(seconds<10) secondsString = [NSString stringWithFormat:@"0%d",seconds];
        else secondsString = [NSString stringWithFormat:@"%d", seconds];
        
        out = [NSString stringWithFormat:@"%@:%@:%@",hourString,minuteString,secondsString];
    }
    return out;
}

-(void) encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.start forKey:@"start"];
    [aCoder encodeObject:self.end forKey:@"end"];
}

-(id) initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if(self){
        [self setStart:[aDecoder decodeObjectForKey:@"start"]];
        [self setEnd:[aDecoder decodeObjectForKey:@"end"]];
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"{TimeSession: {start: %@, end: %@ }}", self.start, self.end];
}

@end
