//
//  ViewController.h
//  Tetoris
//
//  Created by totta on 2014/11/29.
//  Copyright (c) 2014年 totta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "playView.h"
#import "RankingViewController.h"
#import "constData.h"
#import "plistAccess.h"
#import "playSound.h"
#import "UIColor+Hex.h"
#import "AppDelegate.h"
#import <LobiCore/LobiAPI.h>
#import <LobiRanking/LobiRanking.h>

@interface ViewController : UIViewController {
    UIView *topview,*settingView;
    UIButton *startButton,*settingButton,*rankingButton,*cancelButton,*okButton,*modeButton;
    UILabel *maxLinesTitle,*hiScoreTitle,*title,*username;
    UITextField *rename;
    NSString *name;
    plistAccess *access;
    playSound *sound;
    AppDelegate *grobal;
}
-(void)drowView;
@end

