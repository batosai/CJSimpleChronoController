//
//  SimpleChronoController.m
//  IRedmine
//
//  Created by Jeremy on 01/02/13.
//  Copyright (c) 2013 opsone. All rights reserved.
//

#import "CJSimpleChronoController.h"

@interface CJSimpleChronoController () {
    BOOL isWorking;
    BOOL isPaused;
    NSDateFormatter *dateFormatter;
    NSTimeInterval eleapsedTimeAtPause;
    NSTimeInterval timeInterval;
    NSTimer *chronoTimer;
    NSDate *startDate;
    NSMutableArray *dataToShow;
}
@end

@implementation CJSimpleChronoController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"HH:mm:ss"];
        [dateFormatter setTimeZone: [NSTimeZone timeZoneForSecondsFromGMT:0.0]];
        eleapsedTimeAtPause = 0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *background = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 300)];
    background.backgroundColor = [UIColor blackColor];
    
    chronoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, CGRectGetWidth(self.view.frame), 40)];
    chronoLabel.text = @"00:00:00";
    chronoLabel.font = [UIFont fontWithName:@"Helvetica" size:50];
    chronoLabel.backgroundColor = [UIColor clearColor];
    chronoLabel.textColor = [UIColor whiteColor];
    chronoLabel.textAlignment = UITextAlignmentCenter;
    
    
    playButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    playButton.frame = CGRectMake(10, 140, 100, 20);
    [playButton setTitle:NSLocalizedString(@"play", @"play") forState:UIControlStateNormal];
    
    stopButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    stopButton.frame = CGRectMake(10, 170, 100, 20);
    [stopButton setTitle:NSLocalizedString(@"stop", @"stop") forState:UIControlStateNormal];
    
    resetButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    resetButton.frame = CGRectMake(10, 200, 100, 20);
    [resetButton setTitle:NSLocalizedString(@"reset", @"reset") forState:UIControlStateNormal];
    
    
    [playButton addTarget:self action:@selector(onStartPressed:) forControlEvents:UIControlEventTouchUpInside];
    [stopButton addTarget:self action:@selector(onStopPressed:) forControlEvents:UIControlEventTouchUpInside];
    [resetButton addTarget:self action:@selector(onResetPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:background];
    [background addSubview:chronoLabel];
    [self.view addSubview:chronoLabel];
    [self.view addSubview:playButton];
    [self.view addSubview:stopButton];
    [self.view addSubview:resetButton];
}

- (void)updateTimer
{
    NSDate *currentDate = [NSDate date];
    timeInterval = [currentDate timeIntervalSinceDate:startDate];
    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval + eleapsedTimeAtPause];
    NSString *timeString = [dateFormatter stringFromDate:timerDate];
    chronoLabel.text = timeString;
}

#pragma Delegate Buttons

- (void)onStartPressed:(UIButton *)sender
{
    if (!isWorking) {
        isWorking = YES;
        isPaused = NO;
    }
    else {
        isPaused = !isPaused;
    }

    if (isPaused) {
        [chronoTimer invalidate];
        eleapsedTimeAtPause = timeInterval + eleapsedTimeAtPause;
    }
    else {
        startDate = [NSDate date];
        chronoTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/1000.0
                                                       target:self
                                                     selector:@selector(updateTimer)
                                                     userInfo:nil
                                                      repeats:YES];
    }
}

- (void)onStopPressed:(UIButton *)sender
{
    if (isWorking) {
        [chronoTimer invalidate];
        startDate = nil;
        
        isWorking = NO;
        isPaused = NO;
        eleapsedTimeAtPause = 0;
        
    }
}

- (void)onResetPressed:(UIButton *)sender
{
    chronoLabel.text = @"00:00:00";
}

- (void)addTime
{
    NSArray *chunks = [chronoLabel.text componentsSeparatedByString: @":"];

    NSUInteger hours = [[chunks objectAtIndex:0] integerValue];

    NSUInteger minutes = ceil([[NSString stringWithFormat:@"%@.%@",
                       [chunks objectAtIndex:1],
                       [chunks objectAtIndex:2]] floatValue]);

    if (hours) {
        NSLog(@"%ih%imin", hours, minutes);
    }
    else {
        NSLog(@"%imin", minutes);
    }
}

@end
