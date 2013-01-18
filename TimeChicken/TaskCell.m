//
//  TaskCell.m
//  TimeChicken
//
//  Created by Christian Schäfer on 16.01.13.
//  Copyright (c) 2013 Christian Schäfer. All rights reserved.
//

#import "TaskCell.h"

@implementation TaskCell

@synthesize controller;
@synthesize tableView;

- (IBAction)startStopTimer:(id)sender {
    //Objective-C-Message-Magic described in NerdRanchGuid 3rd Ed. page 310-312
    
    //Get the name of this method, "startStopTimer:"
    NSString *selector = NSStringFromSelector(_cmd);
    //the selector is now "startStopTimer:atIndexPath:"
    selector = [selector stringByAppendingString:@"atIndexPath:"];
    
    //Prepare a selector from this string
    SEL newSelector = NSSelectorFromString(selector);
    
    NSIndexPath *indexPath = [[self tableView] indexPathForCell:self];
    if(indexPath){
        //check if the controller is able to respond to our new Selector
        if([[self controller] respondsToSelector:newSelector]){
            [[self controller] performSelector:newSelector withObject:sender withObject:indexPath];
        }
    }
}
@end
