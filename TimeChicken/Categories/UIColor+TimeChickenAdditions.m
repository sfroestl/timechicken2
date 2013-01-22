//
//  UIColor+TimeChickenAdditions.m
//  Time Chicken
//
//  Created by Sebastian Fröstl on 21.01.13.
//
//

#import "UIColor+TimeChickenAdditions.h"

@implementation UIColor (TimeChickenAdditions)

+ (UIColor *)tcMetallicColor {
    return [self colorWithPatternImage:[UIImage imageNamed:@"metallicLight2"]];
}

+ (UIColor *)tcDueDateColor {
    return [UIColor colorWithRed:181.0f/255.0f green:36.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
}
@end
