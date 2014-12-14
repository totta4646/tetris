//
//  playSound.h
//  Tetoris
//
//  Created by totta on 2014/12/06.
//  Copyright (c) 2014年 totta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface playSound : NSObject
@property NSString *bgmpath;
@property NSURL *bgmurl;
@property AVAudioPlayer *sound,*sound2,*sound3;
-(void)moveViewSound;
-(void)actionBlockSound;
-(void)actionPauseSound;
-(void)holdBlockSound;
-(void)deleteBlockSound;
-(void)arriveBlockSound;
-(void)bgmSound;
-(void)bgmStop;
@end
