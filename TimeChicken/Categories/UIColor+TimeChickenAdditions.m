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

+ (UIColor *)tcThemeColor {
//    return [UIColor colorWithRed:0.0f/255.0f green:109.0f/255.0f blue:14.0f/255.0f alpha:1.0f]; //dark green
    return [UIColor colorWithRed:27.0f/255.0f green:151.0f/255.0f blue:42.0f/255.0f alpha:1.0f];
}
+ (UIColor *)tcGreenColor {
    return [UIColor colorWithRed:33.0f/255.0f green:184.0f/255.0f blue:51.0f/255.0f alpha:1.0f];  //light green 27, 151, 42
}
@end
