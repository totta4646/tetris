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
    grobal = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    [LobiAPI signupWithBaseName:@"player"
                     completion:^(LobiNetworkResponse *res){
        if (res.error) {
            [self alert];
            name = @"NO DATA";
            [self drowLabel:topview:username :0 :VIEW_HEIGHT/3*2-VIEW_HEIGHT/4 - CELL_SIZE*2/3 -　MINI_CELL_SIZE/2 :VIEW_WIDTH :50 :STAGE_COLOR3 :[@"Your Name:" stringByAppendingString:name]];
            return ;
        }
        name = [res.dictionary objectForKey:@"name"];
        [self drowLabel:topview:username :0 :VIEW_HEIGHT/3*2-VIEW_HEIGHT/4 - CELL_SIZE*2/3 -　MINI_CELL_SIZE/2 :VIEW_WIDTH :50 :STAGE_COLOR3 :[@"Your Name:" stringByAppendingString:name]];
    }];
    
    topview = [[UIView alloc]init];
    settingView = [[UIView alloc]init];
    startButton = [[UIButton alloc]init];
    settingButton = [[UIButton alloc]init];
    rankingButton = [[UIButton alloc]init];
    modeButton = [[UIButton alloc]init];
    title = [[UILabel alloc]init];
    hiScoreTitle = [[UILabel alloc]init];
    maxLinesTitle = [[UILabel alloc]init];
    username = [[UILabel alloc]init];
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
     [self drowLabel:topview:hiScoreTitle :0 :VIEW_HEIGHT/3*2-VIEW_HEIGHT/4 + CELL_SIZE :VIEW_WIDTH :50 :STAGE_COLOR3 :[@"HI-SCORE:" stringByAppendingString:access.scoreData[0]]];
    [self drowLabel:topview :maxLinesTitle :0 :VIEW_HEIGHT/2 + CELL_SIZE:VIEW_WIDTH :50 :STAGE_COLOR3 :[@"MAX-LINES:" stringByAppendingString:access.scoreData[1]]];

    //ボタンの描写
    [self drowButton:topview :startButton :VIEW_WIDTH/2 - VIEW_WIDTH/4 :VIEW_HEIGHT/4*3- VIEW_HEIGHT / 10 :VIEW_WIDTH/2:50 :STAGE_COLOR :STAGE_COLOR3 :@"START" :STAGE_COLOR2 :2.0 : @selector(start:)];

    [self drowButton:topview :settingButton :VIEW_WIDTH/2 - VIEW_WIDTH/4 :VIEW_HEIGHT/4*3 :VIEW_WIDTH/2:50 :STAGE_COLOR :STAGE_COLOR3 :@"SETTING" :STAGE_COLOR2 :2.0 : @selector(setting:)];
    [self drowButton:topview :rankingButton :VIEW_WIDTH/2 - VIEW_WIDTH/4 :VIEW_HEIGHT/4*3 + VIEW_HEIGHT / 10 :VIEW_WIDTH/2:50 :STAGE_COLOR :STAGE_COLOR3 :@"RANKING" :STAGE_COLOR2 :2.0 : @selector(rankingMove:)];
    

}
-(void) alert {
    UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"通信エラー"
                                                  message:@"User Nameの生成に失敗しました"
                                                 delegate:nil
                                        cancelButtonTitle:nil
                                        otherButtonTitles:@"OK", nil];
    [alert show];
}
-(void) alert2 {
    UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"User Nameが未入力です"
                                                  message:@"User Nameを入力してください"
                                                 delegate:nil
                                        cancelButtonTitle:nil
                                        otherButtonTitles:@"OK", nil];
    [alert show];
}
- (BOOL)textFieldShouldReturn:(UITextField *)sender {
    // キーボードを閉じる
    [sender resignFirstResponder];
    return TRUE;
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
    drowLabel.text = text;
    drowLabel.textAlignment = NSTextAlignmentCenter;
    drowLabel.textColor = textColor;
    [addView addSubview:drowLabel];
}
-(void)rankingMove:(UIButton*)button{
    RankingViewController *rankView = [[RankingViewController alloc] init];
    rankView.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:rankView animated:YES completion:nil];
}
-(void)setting:(UIButton*)button{
    settingView = [[UIView alloc]initWithFrame:CGRectMake(VIEW_WIDTH * 0.1, VIEW_WIDTH * 0.5, VIEW_WIDTH * 0.8, VIEW_WIDTH * 0.9)];
    settingView.backgroundColor = STAGE_COLOR;
    settingView.tag = 100;
    [settingView.layer setBorderWidth:3];
    [settingView.layer setBorderColor:STAGE_COLOR2.CGColor];
    [self.view addSubview:settingView];
    UILabel *settinglabel = [[UILabel alloc]initWithFrame:CGRectMake(0, MINI_CELL_SIZE, VIEW_WIDTH * 0.4, CELL_SIZE*3)];
    settinglabel.text = @"Rename";
    settinglabel.textAlignment = NSTextAlignmentCenter;
    settinglabel.font = [UIFont fontWithName:@"AppleGothic" size:20];
    settinglabel.textColor = STAGE_COLOR3;
    [settingView addSubview:settinglabel];
    UILabel *Modelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, MINI_CELL_SIZE + CELL_SIZE*3, VIEW_WIDTH * 0.4, CELL_SIZE*3)];
    Modelabel.text = @"Mode";
    Modelabel.textAlignment = NSTextAlignmentCenter;
    Modelabel.font = [UIFont fontWithName:@"AppleGothic" size:20];
    Modelabel.textColor = STAGE_COLOR3;
    [settingView addSubview:Modelabel];

    rename = [[UITextField alloc]initWithFrame:CGRectMake(VIEW_WIDTH * 0.4, MINI_CELL_SIZE * 2.3, VIEW_WIDTH * 0.35, CELL_SIZE)];
    rename.placeholder = name;
    rename.textColor = STAGE_COLOR3;
    rename.backgroundColor = STAGE_COLOR2;
    rename.keyboardType = UIKeyboardTypeEmailAddress;
    rename.delegate = self;
    [settingView addSubview:rename];
    
    cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(VIEW_WIDTH * 0.8 - CELL_SIZE * 5, CELL_SIZE*9, CELL_SIZE*4.5, CELL_SIZE*1.5)];
    cancelButton.opaque = NO;
    [cancelButton.layer setBorderWidth:3];
    [cancelButton.layer setBorderColor:STAGE_COLOR2.CGColor];
    [cancelButton setTitle:@"CANCEL" forState:UIControlStateNormal];
    [cancelButton setTitleColor:STAGE_COLOR3 forState:UIControlStateNormal];
    cancelButton.tag = 100;
    [cancelButton addTarget:self action:@selector(cancel:)
           forControlEvents:UIControlEventTouchDown];
    [settingView addSubview:cancelButton];
    okButton = [[UIButton alloc]initWithFrame:CGRectMake(CELL_SIZE/2, CELL_SIZE*9, CELL_SIZE*4.5, CELL_SIZE*1.5)];
    okButton.opaque = NO;
    [okButton.layer setBorderWidth:3];
    [okButton.layer setBorderColor:STAGE_COLOR2.CGColor];
    [okButton setTitle:@"OK" forState:UIControlStateNormal];
    [okButton setTitleColor:STAGE_COLOR3 forState:UIControlStateNormal];
    okButton.tag = 100;
    [okButton addTarget:self action:@selector(submit:)
         forControlEvents:UIControlEventTouchDown];
    [settingView addSubview:okButton];

    [sound actionBlockSound];

    [self drowButton:settingView :modeButton :VIEW_WIDTH * 0.4  - VIEW_WIDTH * 0.02:MINI_CELL_SIZE * 2 + CELL_SIZE * 3 :VIEW_WIDTH * 0.39:CELL_SIZE*1.5 :STAGE_COLOR :STAGE_COLOR3 :@"NORMAL MODE" :STAGE_COLOR2 :2.0 : @selector(change:)];
    grobal.mode = @"normal";
}
-(void)change:(UIButton*)button{
    [self drowButton:settingView :modeButton :VIEW_WIDTH * 0.4 - VIEW_WIDTH * 0.02:MINI_CELL_SIZE * 2 + CELL_SIZE * 3 :VIEW_WIDTH * 0.39:CELL_SIZE*1.5 :STAGE_COLOR :STAGE_COLOR3 :@"ASSIST MODE" :STAGE_COLOR2 :2.0 : @selector(change2:)];
    grobal.mode = @"assist";
}
-(void)change2:(UIButton*)button{
    [self drowButton:settingView :modeButton :VIEW_WIDTH * 0.4 - VIEW_WIDTH * 0.02:MINI_CELL_SIZE * 2 + CELL_SIZE * 3 :VIEW_WIDTH * 0.39:CELL_SIZE*1.5 :STAGE_COLOR :STAGE_COLOR3 :@"NORMAL MODE" :STAGE_COLOR2 :2.0 : @selector(change:)];
    grobal.mode = @"normal";
}

-(void)cancel:(UIButton*)button{
    [self removeview];
}
-(void)submit:(UIButton*)button{
    if (![rename.text isEqualToString:@""]) {
        [LobiAPI updateUserName:rename.text
                     completion:^(LobiNetworkResponse *res){
                         if (res.error) {
                             [self alert];
                             return ;
                         }
                         name = rename.text;
                         [self drowLabel:topview:username :0 :VIEW_HEIGHT/3*2-VIEW_HEIGHT/4 - CELL_SIZE*2/3 -　MINI_CELL_SIZE/2 :VIEW_WIDTH :50 :STAGE_COLOR3 :[@"Your Name:" stringByAppendingString:name]];

                     }];
    } else {
        [self alert2];
    }
    [self removeview];
}
-(void) removeview {
    for(int i = 0; i < 10; i++){
        [[self.view viewWithTag:100] removeFromSuperview];
    }
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
-(void) modalViewWillClose {
    [access accessPlist];
    hiScoreTitle.text = [@"HI-SCORE:" stringByAppendingString:access.scoreData[0]];
    maxLinesTitle.text = [@"MAX-LINES:" stringByAppendingString:access.scoreData[1]];
    [topview addSubview:hiScoreTitle];
    [topview addSubview:maxLinesTitle];
    [sound moveViewSound];
    [self dismissModalViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end