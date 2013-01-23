//
//  UIButton+TimeChickenAdditions.m
//  Time Chicken
//
//  Created by Sebastian Fröstl on 21.01.13.
//
//

#import "UIButton+TimeChickenAdditions.h"

@implementation UIButton (TimeChickenAdditions)

+ (UIButton *) tcBlackButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *buttonImage = [[UIImage imageNamed:@"blackButton"] resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    UIImage *buttonImageHighlight = [[UIImage imageNamed:@"blackButtonHighlight"] resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    
    // Set the background for states
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
    
    // Custom Colors and Shadow
	[button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//	[button setTitleShadowColor:[UIColor blackColor] forState:UIControlStateNormal];
//	button.titleLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
    //	button.titleLabel.font = [UIFont cheddarInterfaceFontOfSize:18.0f];
    
	return button;
}
+ (UIButton *) tcOrangeButton {
    UIButton *button = [[self alloc] initWithFrame:CGRectZero];
    
    UIImage *buttonImage = [[UIImage imageNamed:@"orangeButton"] resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    UIImage *buttonImageHighlight = [[UIImage imageNamed:@"orangeButtonHighlight"] resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    
    // Set the background for states
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
    
    // Custom Colors and Shadow
	[button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
	return button;
}
+ (UIButton *) tcBlueButton {
    UIButton *button = [[self alloc] initWithFrame:CGRectZero];
    
    UIImage *buttonImage = [[UIImage imageNamed:@"blueButton"] resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    UIImage *buttonImageHighlight = [[UIImage imageNamed:@"blueButtonHighlight"] resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    
    // Set the background for states
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
    
    // Custom Colors and Shadow
	[button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
	return button;

}
+ (UIButton *) tcGreenButton {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *buttonImage = [[UIImage imageNamed:@"greenButton"] resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    UIImage *buttonImageHighlight = [[UIImage imageNamed:@"greenButtonHighlight"] resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    
    // Set the background for any states you plan to use
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
    
    
    // Custom Colors and Shadow
	[button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	
    return button;
}

+ (UIButton *) tcGrayButton {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *buttonImage = [[UIImage imageNamed:@"greyButton"] resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    UIImage *buttonImageHighlight = [[UIImage imageNamed:@"greyButtonHighlight"] resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    
    // Set the background for any states you plan to use
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
    
    
    // Custom Colors and Shadow
	[button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	
    return button;
}


@end
