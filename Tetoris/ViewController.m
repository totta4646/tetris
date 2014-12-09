//
//  ViewController.m
//  Tetoris
//
//  Created by totta on 2014/12/01.
//  Copyright (c) 2014年 totta. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    topview = [[UIView alloc]init];
    settingView = [[UIView alloc]init];
    startButton = [[UIButton alloc]init];
    settingButton = [[UIButton alloc]init];
    title = [[UILabel alloc]init];
    hiScoreTitle = [[UILabel alloc]init];
    maxLinesTitle = [[UILabel alloc]init];
    sound = [[playSound alloc]init];

    //大まかになるtopviewの描写
    [self drowView:self.view uiview: topview uiview:0 float:0 float:VIEW_WIDTH float:VIEW_HEIGHT float:STAGE_COLOR uicolor:0 int:STAGE_COLOR uicolor:0];

    //plistにアクセスしてユーザーのデータを引っ張る
    access = [[plistAccess alloc]init];
    [access accessPlist];

    //plistがなければデフォルトのデータとして@"------"を配列に入れる
    if (![access.scoreData isKindOfClass:[NSMutableArray class]]) {
        access.scoreData = [@[DEFAULT_SCORE,DEFAULT_SCORE,DEFAULT_SCORE]mutableCopy];
       [access.scoreData writeToFile:access.filePath atomically:NO];
    }

    //ラベルの描写
    [self drowLabel:topview :title :0 :VIEW_HEIGHT/4 :VIEW_WIDTH :50 :STAGE_COLOR3 :@"TETORIS"];
    title.font = [UIFont fontWithName:@"AppleGothic" size:40];
    [topview addSubview:title];
    [self drowLabel:topview:hiScoreTitle :0 :VIEW_HEIGHT/3*2-VIEW_HEIGHT/4 :VIEW_WIDTH :50 :STAGE_COLOR3 :[@"HI-SCORE:" stringByAppendingString:access.scoreData[0]]];
    [self drowLabel:topview :maxLinesTitle :0 :VIEW_HEIGHT/2:VIEW_WIDTH :50 :STAGE_COLOR3 :[@"MAX-LINES:" stringByAppendingString:access.scoreData[1]]];

    //ボタンの描写
    [self drowButton:topview :startButton :VIEW_WIDTH/2 - VIEW_WIDTH/4 :VIEW_HEIGHT/4*3- VIEW_HEIGHT / 10 :VIEW_WIDTH/2:50 :STAGE_COLOR :STAGE_COLOR3 :@"START" :STAGE_COLOR2 :2.0 : @selector(start:)];

//    [self drowButton:topview :settingButton :VIEW_WIDTH/2 - VIEW_WIDTH/4 :VIEW_HEIGHT/4*3 :VIEW_WIDTH/2:50 :STAGE_COLOR :STAGE_COLOR3 :@"SETTING" :STAGE_COLOR2 :2.0 : @selector(setting:)];
    

}

//UIViewを描写するメソッド
- (void) drowView :(UIView*)addView uiview:(UIView*)View uiview:(float)widthPoint float:(float)heightPoint float:(float)width float:(float)height float:(UIColor*)backGroundColor uicolor:(int)tags int:(UIColor*)borderColor uicolor:(float)borderWidth {
    View.frame = CGRectMake(widthPoint, heightPoint, width, height);
    View.backgroundColor = backGroundColor;
    View.tag = tags;
    [View.layer setBorderWidth:borderWidth];
    [View.layer setBorderColor:borderColor.CGColor];
    [addView addSubview:View];
}
//ボタンを描写するメソッド
- (void) drowButton :(UIView*)addView:(UIButton*)drowButton:(float)widthPoint:(float)heightPoint:(float)width:(float)height:(UIColor*)backGroundColor:(UIColor*)textColor:(NSString*)title:(UIColor*)borderColor:(float)borderWidth:(SEL)selector {
    

    drowButton.frame = CGRectMake(widthPoint, heightPoint, width, height);
    [drowButton addTarget:self action:selector
            forControlEvents:UIControlEventTouchDown];
    [drowButton setTitle:title forState:UIControlStateNormal];
    drowButton.backgroundColor = backGroundColor;
    [drowButton setTitleColor:textColor forState:UIControlStateNormal];
    [[drowButton layer] setBorderColor:[borderColor CGColor]];
    [[drowButton layer] setBorderWidth:borderWidth];
    [addView addSubview:drowButton];
}
//ラベルを描写するメソッド
- (void) drowLabel :(UIView*)addView:(UILabel*)drowLabel:(float)widthPoint:(float)heightPoint:(float)width:(float)height:(UIColor*)textColor:(NSString*)text{
    drowLabel.frame = CGRectMake(widthPoint, heightPoint, width, height);
    drowLabel.text = text ;
    drowLabel.textAlignment = NSTextAlignmentCenter;
    drowLabel.textColor = textColor;
    [addView addSubview:drowLabel];
}

//セッティングのビューを表示する
-(void)setting:(UIButton*)button{
    [self drowView :self.view uiview:settingView uiview:VIEW_WIDTH * 0.1 float:VIEW_WIDTH * 0.6 float:VIEW_WIDTH * 0.8 float:VIEW_WIDTH float:STAGE_COLOR uicolor:100 int:STAGE_COLOR2 uicolor:3];
    
}
//ゲームスタート
-(void)start:(UIButton*)button{
    playView *view = [[playView alloc] init];
    view.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    view.delegate = self;
    [sound moveViewSound];
    [self presentModalViewController:view animated:YES];
}

//画面が返ってきたときのメソッド
-(void) modalViewWillClose{
    [access accessPlist];
    hiScoreTitle.text = [@"HI-SCORE:" stringByAppendingString:access.scoreData[0]] ;
    maxLinesTitle.text = [@"MAX-LINES:" stringByAppendingString:access.scoreData[1]] ;
    [topview addSubview:hiScoreTitle];
    [topview addSubview:maxLinesTitle];
    [sound moveViewSound];
    [self dismissModalViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end