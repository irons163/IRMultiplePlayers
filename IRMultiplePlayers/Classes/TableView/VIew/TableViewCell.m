//
//  ProfileTableViewCell.m
//  demo
//
//  Created by Phil on 2019/5/8.
//  Copyright © 2019 Phil. All rights reserved.
//

#import "TableViewCell.h"
#import <IRPlayer/IRPlayer.h>

static NSURL * normalVideo = nil;
static NSURL * vrVideo = nil;
static NSURL * fisheyeVideo = nil;

@interface TableViewCell()

@property (nonatomic, strong) IRPlayerImp * player;

@end

@implementation TableViewCell

- (void)randomPlay {
    NSURL *videoURL = nil;
    switch (arc4random_uniform(3)) {
        case 0:
            videoURL = normalVideo;
            break;
        case 1:
            videoURL = vrVideo;
            break;
        case 2:
            videoURL = fisheyeVideo;
            break;
    }
    [self.player replaceVideoWithURL:videoURL];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.isFinished = YES;
    
    self.player = [IRPlayerImp player];
    [self.player registerPlayerNotificationTarget:self
                                      stateAction:@selector(stateAction:)
                                   progressAction:@selector(progressAction:)
                                   playableAction:@selector(playableAction:)
                                      errorAction:@selector(errorAction:)];
    [self.player setViewTapAction:^(IRPlayerImp * _Nonnull player, IRPLFView * _Nonnull view) {
        NSLog(@"player display view did click!");
    }];
    [self.playerView insertSubview:self.player.view atIndex:0];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        normalVideo = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"i-see-fire" ofType:@"mp4"]];
        vrVideo = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"google-help-vr" ofType:@"mp4"]];
        fisheyeVideo = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"fisheye-demo" ofType:@"mp4"]];
    });
    
    self.player.decoder = [IRPlayerDecoder FFmpegDecoder];
    [self randomPlay];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    [self randomPlay];
}

- (void)stateAction:(NSNotification *)notification
{
    IRState * state = [IRState stateFromUserInfo:notification.userInfo];
    
    NSString * text;
    switch (state.current) {
        case IRPlayerStateNone:
            text = @"None";
            break;
        case IRPlayerStateBuffering:
            text = @"Buffering...";
            break;
        case IRPlayerStateReadyToPlay:
            text = @"Prepare";
            self.isFinished = NO;
//            self.totalTimeLabel.text = [self timeStringFromSeconds:self.player.duration];
            [self.player play];
            break;
        case IRPlayerStatePlaying:
            text = @"Playing";
            break;
        case IRPlayerStateSuspend:
            text = @"Suspend";
            break;
        case IRPlayerStateFinished:
            text = @"Finished";
            self.isFinished = YES;
            break;
        case IRPlayerStateFailed:
            text = @"Error";
            self.isFinished = YES;
            break;
    }
    self.titleLabel.text = text;
}

- (void)progressAction:(NSNotification *)notification
{
//    IRProgress * progress = [IRProgress progressFromUserInfo:notification.userInfo];
//    if (!self.progressSilderTouching) {
//        self.progressSilder.value = progress.percent;
//    }
//    self.currentTimeLabel.text = [self timeStringFromSeconds:progress.current];
}

- (void)playableAction:(NSNotification *)notification
{
    IRPlayable * playable = [IRPlayable playableFromUserInfo:notification.userInfo];
    NSLog(@"playable time : %f", playable.current);
}

- (void)errorAction:(NSNotification *)notification
{
    IRError * error = [IRError errorFromUserInfo:notification.userInfo];
    NSLog(@"player did error : %@", error.error);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (NSString *)identifier {
    return NSStringFromClass([self class]);
}

@end
