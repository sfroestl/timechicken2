//
//  TCDatePicker.m
//  TimeChicken
//
//  Created by Christian Schäfer on 11.01.13.
//  Copyright (c) 2013 Sebastian Fröstl. All rights reserved.
//

#import "TCDatePicker.h"

@interface  TCDatePicker()
@property (strong, nonatomic) NSDateFormatter* dateFormatter;
@property (strong, nonatomic) UITextField* textField;
@end

@implementation TCDatePicker

-(id)initWithDateFormatString:(NSString *)dateFormatSting forTextField:(UITextField *)textField withDatePickerMode:(UIDatePickerMode)datePickerMode{
    
    self = [super init];
    if(self){
        self.datePickerMode = datePickerMode;
        self.textField = textField;
        self.dateFormatter = [[NSDateFormatter alloc] init];
        self.dateFormatter.dateFormat = dateFormatSting;
        
        //Method that handles datepicker user input
        [self addTarget:self action:@selector(dateSelected:) forControlEvents: UIControlEventValueChanged];
    }
    return self;
}

- (void) setDate:(NSDate *)date{
    [super setDate:date];
    [self dateSelected:nil];
     
}

#pragma mark - @selectors

-(void) dateSelected: (id) sender{
    self.textField.text = [self.dateFormatter stringFromDate:self.date];
}

@end
