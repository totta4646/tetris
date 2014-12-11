//
//  playView.h
//  Tetoris
//
//  Created by totta on 2014/12/01.
//  Copyright (c) 2014年 totta. All rights reserved.
//

#import "ViewController.h"
#import "playSound.h"
#import "plistAccess.h"
#import <GameKit/GameKit.h>
#import "RankingViewController.h"

@protocol modalViewDelegate <NSObject>
-(void) modalViewWillClose;
@end

@interface playView : UIViewController<GKGameCenterControllerDelegate> {
    NSMutableArray *stageBlock, *stageBlock2, *dropBlock, *dropBlock2, *dropBlockTemp;
    NSNumber *existBlock,*existBlock1,*existBlock2,*existBlock3,*existBlock4,*existBlock5,*existBlock6,*existBlock7,*noneBlock,*tempBlock;
    UIView *stage, *dropStage,*scoreboard,*holdView,*nextView,*pauseView,*pauseView2;
    UILabel *scoreLabel,*lineLabel,*levelLabel,*nextLabel;
    UILabel *stageCell, *dropCell,*pauselabel;
    float w,h,speed,changespeed;
    NSTimer *time,*longtap,*BGM;
    int aliginCount,varticalCount,currntBlockStatus,turnCount,noneBlockCount,aliginCountTemp,holdBlockStatus,holdBlockStatus2,SCORE,LINE,LEVEL,difficult,nextBlockStatus,nextBlockStatus2;
    UIColor *tempColor;
    UIButton *DOWNBUTTON, *LEFTBUTTON, *RIGHTBUTTON, *TURNBUTTON,*HOLDBUTTON,*PAUSEBUTTON,*RESETBUTTON,*RESUMEBUTTON,*HOMEBUTTON,*RANKINGBUTTON;
    BOOL right,left,turn,bottom,up,gameover,hold,blockCheck,newScore,newLines,newLevel;
    
    id delegate;
    playSound *sound,*sound2;
    plistAccess *access;
}
@property (nonatomic,retain) id delegate;
@end

