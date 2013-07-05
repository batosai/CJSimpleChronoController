//
//  CJSimpleChronoController.h
//  IRedmine
//
//  Created by Jeremy on 01/02/13.
//  Copyright (c) 2013 opsone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CJSimpleChronoController : UIViewController {
    UILabel *chronoLabel;
    UIButton *playButton;
    UIButton *stopButton;
    UIButton *resetButton;
}

- (void)updateTimer;
- (void)onStartPressed:(UIButton *)sender;
- (void)onStopPressed:(UIButton *)sender;
- (void)onResetPressed:(UIButton *)sender;

@end
