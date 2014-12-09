//
//  ViewController.h
//  Tetoris
//
//  Created by totta on 2014/11/29.
//  Copyright (c) 2014年 totta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "playView.h"
#import "constData.h"
#import "plistAccess.h"
#import "playSound.h"
#import "UIColor+Hex.h"

@interface ViewController : UIViewController {
    UIView *topview,*settingView;
    UIButton *startButton,*settingButton;
    UILabel *maxLinesTitle,*hiScoreTitle,*title;
    plistAccess *access;
    playSound *sound;
}
-(void)drowView;
@end

