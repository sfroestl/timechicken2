//
//  UIImage+UIImage_TimeChickenAdditions.m
//  TimeChicken
//
//  Created by Sebastian Fröstl on 23.01.13.
//
//

#import "UIImage+TimeChickenAdditions.h"

@implementation UIImage (TimeChickenAdditions)

+ (UIImage *) tcNavBackground {
//    UIImage *image = [UIImage imageNamed:@"tcNavBackground"];
    return [UIImage imageNamed:@"nav-background"];
}

+ (UIImage *) tcNavBackgroundMini {
    UIImage *image = [[UIImage imageNamed:@"nav-background-mini"] resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
	
    return image;
}


@end
