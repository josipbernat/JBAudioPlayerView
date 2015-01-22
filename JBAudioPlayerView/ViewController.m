//
//  ViewController.m
//  JBAudioPlayerView
//
//  Created by Josip Bernat on 1/22/15.
//  Copyright (c) 2015 Josip Bernat. All rights reserved.
//

#import "ViewController.h"
#import "JBAudioPlayerView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet JBAudioPlayerView *autoLayoutAudioPlayerView;
@property (weak, nonatomic) IBOutlet JBAudioPlayerView *noAutoLayoutAudioPlayerView;
@property (strong, nonatomic) JBAudioPlayerView *fromCode;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.noAutoLayoutAudioPlayerView.useAutoLayout = NO;
    
    JBAudioPlayerView *fromCode = [[JBAudioPlayerView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.noAutoLayoutAudioPlayerView.frame),
                                                                                      CGRectGetMaxY(self.noAutoLayoutAudioPlayerView.frame) + 30.0f,
                                                                                      CGRectGetWidth(self.noAutoLayoutAudioPlayerView.frame),
                                                                                      CGRectGetHeight(self.noAutoLayoutAudioPlayerView.frame))];
    fromCode.backgroundColor = [UIColor yellowColor];
    fromCode.useAutoLayout = NO;
    [self.view addSubview:fromCode];
    
    self.fromCode = fromCode;
}

- (void)viewDidLayoutSubviews {

    [super viewDidLayoutSubviews];
    
    self.fromCode.frame = CGRectMake(CGRectGetMinX(self.noAutoLayoutAudioPlayerView.frame),
                                     CGRectGetMaxY(self.noAutoLayoutAudioPlayerView.frame) + 30.0f,
                                     CGRectGetWidth(self.noAutoLayoutAudioPlayerView.frame),
                                     CGRectGetHeight(self.noAutoLayoutAudioPlayerView.frame));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
