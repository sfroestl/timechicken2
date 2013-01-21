//
//  UIButton+TimeChickenAdditions.m
//  Time Chicken
//
//  Created by Sebastian Fröstl on 21.01.13.
//
//

#import "UIButton+TimeChickenAdditions.h"

@implementation UIButton (TimeChickenAdditions)

+ (UIButton *) tcBigGreenButton {
    UIButton *button = [[self alloc] initWithFrame:CGRectZero];
	[button setBackgroundImage:[[UIImage imageNamed:@"greenButton"] stretchableImageWithLeftCapWidth:6 topCapHeight:0] forState:UIControlStateNormal];
	[button setBackgroundImage:[[UIImage imageNamed:@"greenButtonHighlight"] stretchableImageWithLeftCapWidth:6 topCapHeight:0] forState:UIControlStateHighlighted];
	[button setTitleColor:[UIColor colorWithRed:0.384 green:0.412 blue:0.455 alpha:1] forState:UIControlStateNormal];
	[button setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
	button.titleLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
//	button.titleLabel.font = [UIFont cheddarInterfaceFontOfSize:18.0f];
	return button;
}
+ (UIButton *) tcBigGrayButton {
    UIButton *button = [[self alloc] initWithFrame:CGRectZero];
    return button;
}
+ (UIButton *) tcBigOrangeButton {
    UIButton *button = [[self alloc] initWithFrame:CGRectZero];
    return button;
}

@end
