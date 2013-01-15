//
//  TCDatePicker.h
//  TimeChicken
//
//  Created by Christian Schäfer on 11.01.13.
//  Copyright (c) 2013 Sebastian Fröstl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCDatePicker : UIDatePicker

-(id)initWithDateFormatString: (NSString*)dateFormatSting forTextField:(UITextField*)textField withDatePickerMode:(UIDatePickerMode) datePickerMode;

@end
