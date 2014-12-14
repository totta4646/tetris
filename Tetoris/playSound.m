//
//  playSound.m
//  Tetoris
//
//  Created by totta on 2014/12/06.
//  Copyright (c) 2014年 totta. All rights reserved.
//

#import "playSound.h"

@implementation playSound

-(void)moveViewSound {
    _bgmpath = [[NSBundle mainBundle] pathForResource:@"SE_17" ofType:@"mp3"];
    [self soundPlay];
}
-(void)actionBlockSound {
    _bgmpath = [[NSBundle mainBundle] pathForResource:@"click_01-low" ofType:@"mp3"];
    [self soundPlay2];
}
-(void)actionPauseSound {
    _bgmpath = [[NSBundle mainBundle] pathForResource:@"click_08-low" ofType:@"mp3"];
    [self soundPlay];
}
-(void)holdBlockSound {
    _bgmpath = [[NSBundle mainBundle] pathForResource:@"click_03-low" ofType:@"mp3"];
    [self soundPlay];
}
-(void)arriveBlockSound {
    _bgmpath = [[NSBundle mainBundle] pathForResource:@"click_06-low" ofType:@"mp3"];
    [self soundPlay];
}
-(void)deleteBlockSound {
    _bgmpath = [[NSBundle mainBundle] pathForResource:@"get" ofType:@"mp3"];
    [self soundPlay2];
}

-(void)bgmSound {
    _bgmpath = [[NSBundle mainBundle] pathForResource:@"smile" ofType:@"mp3"];
    [self bgmplay];
}
-(void)bgmStop {
    [_sound3 stop];
}



-(void)soundPlay {
    _bgmurl = [NSURL fileURLWithPath:_bgmpath];
    _sound = [[AVAudioPlayer alloc]initWithContentsOfURL:_bgmurl error:nil];
    _sound.currentTime = 0;
    [_sound play];
}
-(void)soundPlay2 {
    _bgmurl = [NSURL fileURLWithPath:_bgmpath];
    _sound2 = [[AVAudioPlayer alloc]initWithContentsOfURL:_bgmurl error:nil];
    [_sound2 play];
}
-(void)bgmplay {
    _bgmurl = [NSURL fileURLWithPath:_bgmpath];
    _sound3 = [[AVAudioPlayer alloc]initWithContentsOfURL:_bgmurl error:nil];
    _sound3.numberOfLoops = -1;
    [_sound3 play];
}
@end
