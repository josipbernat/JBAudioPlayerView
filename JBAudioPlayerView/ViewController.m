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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.noAutoLayoutAudioPlayerView.useAutoLayout = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
