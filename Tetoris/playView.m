//
//  playView.m
//  Tetoris
//
//  Created by totta on 2014/12/01.
//  Copyright (c) 2014年 totta. All rights reserved.
//

#import "playView.h"

@interface playView ()

@end

@implementation playView
@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    sound = [[playSound alloc]init];
    sound2 = [[playSound alloc]init];
    self.view.backgroundColor = [UIColor whiteColor];
    changespeed = 0.2;
    speed = 1.0;
    difficult = 10;
    time = [NSTimer scheduledTimerWithTimeInterval:speed
                                            target:self
                                          selector:@selector(dropedBlock)
                                          userInfo:nil
                                           repeats:YES];
    
    hold = true;
    w = self.view.frame.size.width;
    h = self.view.frame.size.height;
    self.view.backgroundColor = STAGE_COLOR4;
    
    gameover = false;
    aliginCount = 2;
    varticalCount = 0;
    holdBlockStatus = -1;
    holdBlockStatus2 = -1;
    LEVEL = 1,LINE = 0,SCORE = 0;
    nextBlockStatus = (int)arc4random_uniform(7);
    nextBlockStatus2 = (int)arc4random_uniform(7);
    
    
    //stageの描写
    stage = [[UIView alloc]initWithFrame:CGRectMake(20, VIEW_HEIGHT - CELL_SIZE*20 - MINI_CELL_SIZE/2 + BORDER_WIDTH, CELL_SIZE * 9, CELL_SIZE * 20)];
    //    stage.backgroundColor = STAGE_COLOR;
    [stage.layer setBorderColor:STAGE_COLOR2.CGColor];
    [stage.layer setBorderWidth:BORDER_WIDTH * 2];
    stage.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:stage];
    
    existBlock = [NSNumber numberWithInteger:1];
    existBlock1 = [NSNumber numberWithInteger:11];
    existBlock2 = [NSNumber numberWithInteger:12];
    existBlock3 = [NSNumber numberWithInteger:13];
    existBlock4 = [NSNumber numberWithInteger:14];
    existBlock5 = [NSNumber numberWithInteger:15];
    existBlock6 = [NSNumber numberWithInteger:16];
    existBlock7 = [NSNumber numberWithInteger:17];
    noneBlock = [NSNumber numberWithInteger:0];

//    [model modelNew];
    
    //stageBlock: 20 * 9 = 180マス
    stageBlock = [@[] mutableCopy];
    stageBlock2 = [@[] mutableCopy];
    for (int i = 0; i < 180; i++) {
        stageBlock[i] = noneBlock;
    }
    //dropBlock: 4 * 4 = 16マス
    dropBlock = [@[] mutableCopy];
    dropBlock2 = [@[] mutableCopy];
    for (int i = 0; i < 16; i++) {
        dropBlock[i] = noneBlock;
    }
    [self dropBlockChange : true];
    [self drowStageBlock];
    aliginCount = 2;
    varticalCount = 0;
    [self drowDropBlock];

    //ステージ等の描写
    holdView = [[UIView alloc]initWithFrame:CGRectMake(20 + CELL_SIZE * 9, VIEW_HEIGHT -CELL_SIZE*20 - MINI_CELL_SIZE/2, CELL_SIZE*3, CELL_SIZE*5)];
    [[holdView layer] setBorderColor:[STAGE_COLOR2 CGColor]];
    [[holdView layer] setBorderWidth:BORDER_WIDTH];
    holdView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:holdView];
    UILabel *holdtitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CELL_SIZE*3, CELL_SIZE)];
    holdtitle.backgroundColor = STAGE_COLOR2;
    holdtitle.text = @"HOLD";
    holdtitle.textColor = STAGE_COLOR3;
    holdtitle.textAlignment = NSTextAlignmentCenter;
    [holdView addSubview:holdtitle];
    scoreboard = [[UIView alloc]initWithFrame:CGRectMake(20 + CELL_SIZE * 9, VIEW_HEIGHT-CELL_SIZE*15 + BORDER_WIDTH - MINI_CELL_SIZE/2, CELL_SIZE*3, CELL_SIZE*15)];
    [[scoreboard layer] setBorderColor:[STAGE_COLOR2 CGColor]];
    [[scoreboard layer] setBorderWidth:BORDER_WIDTH];
    scoreboard.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scoreboard];
    UILabel *scoretitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CELL_SIZE*3, CELL_SIZE)];
    scoretitle.backgroundColor = STAGE_COLOR2;
    scoretitle.text = @"SCORE";
    scoretitle.textAlignment = NSTextAlignmentCenter;
    scoretitle.textColor = STAGE_COLOR3;
    [scoreboard addSubview:scoretitle];
    UILabel *linestitle = [[UILabel alloc]initWithFrame:CGRectMake(0, CELL_SIZE*5, CELL_SIZE*3, CELL_SIZE)];
    linestitle.backgroundColor = STAGE_COLOR2;
    linestitle.text = @"LINES";
    linestitle.textAlignment = NSTextAlignmentCenter;
    linestitle.textColor = STAGE_COLOR3;
    [scoreboard addSubview:linestitle];
    UILabel *leveltitle = [[UILabel alloc]initWithFrame:CGRectMake(0, CELL_SIZE*10, CELL_SIZE*3, CELL_SIZE)];
    leveltitle.backgroundColor = STAGE_COLOR2;
    leveltitle.text = @"LEVEL";
    leveltitle.textColor = STAGE_COLOR3;
    leveltitle.textAlignment = NSTextAlignmentCenter;
    [scoreboard addSubview:leveltitle];
    
    scoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CELL_SIZE*2.5, CELL_SIZE*3, CELL_SIZE)];
    scoreLabel.textColor = STAGE_COLOR3;
    scoreLabel.text = @"0";
    scoreLabel.textAlignment = NSTextAlignmentCenter;
    [scoreboard addSubview:scoreLabel];
    lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CELL_SIZE*7.5, CELL_SIZE*3, CELL_SIZE)];
    lineLabel.textColor = STAGE_COLOR3;
    lineLabel.text = @"0";
    lineLabel.textAlignment = NSTextAlignmentCenter;
    [scoreboard addSubview:lineLabel];
    levelLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CELL_SIZE*12.5, CELL_SIZE*3, CELL_SIZE)];
    levelLabel.textColor = STAGE_COLOR3;
    levelLabel.text = @"1";
    levelLabel.textAlignment = NSTextAlignmentCenter;
    [scoreboard addSubview:levelLabel];
    
    UILabel *pauseLabel = [[UILabel alloc]initWithFrame:CGRectMake(20 + CELL_SIZE*9 - BORDER_WIDTH, h-CELL_SIZE*22.5 - MINI_CELL_SIZE/2, CELL_SIZE*3, CELL_SIZE*2.5)];
    pauseLabel.text = @"PAUSE";
    pauseLabel.textColor = STAGE_COLOR3;
    pauseLabel.backgroundColor = STAGE_COLOR;
    [[pauseLabel layer] setBorderColor:[STAGE_COLOR2 CGColor]];
    [[pauseLabel layer] setBorderWidth:BORDER_WIDTH];
    pauseLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:pauseLabel];


    nextView = [[UIView alloc]initWithFrame:CGRectMake(20, VIEW_HEIGHT-CELL_SIZE*22.5 + BORDER_WIDTH - MINI_CELL_SIZE/2, CELL_SIZE*9, CELL_SIZE*2.5)];
    [[nextView layer] setBorderColor:[STAGE_COLOR2 CGColor]];
    [[nextView layer] setBorderWidth:BORDER_WIDTH];
    nextView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:nextView];
    UILabel *nexttitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CELL_SIZE*3, CELL_SIZE)];
    nexttitle.backgroundColor = STAGE_COLOR2;
    nexttitle.text = @"NEXT";
    nexttitle.textColor = STAGE_COLOR3;
    nexttitle.textAlignment = NSTextAlignmentCenter;
    [nextView addSubview:nexttitle];
    [self drowNextBlock];

    UILabel *pauseLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(20 + CELL_SIZE*9, VIEW_HEIGHT-CELL_SIZE*22.5 - MINI_CELL_SIZE/2, BORDER_WIDTH * 5, CELL_SIZE*2.5)];
    pauseLabel2.backgroundColor = STAGE_COLOR2;
    [self.view addSubview:pauseLabel2];

    
    //ボタン関係
    
    
    DOWNBUTTON = [[UIButton alloc]initWithFrame:CGRectMake(0, VIEW_HEIGHT/4*3, VIEW_WIDTH, VIEW_HEIGHT/4)];
    DOWNBUTTON.opaque = NO;
    //    DOWNBUTTON.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
    DOWNBUTTON.tag = 10;
    //    DOWNBUTTON.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.0f]; // transparent background.
    [DOWNBUTTON addTarget:self action:@selector(blockDown:)
         forControlEvents:UIControlEventTouchDown];
    UILongPressGestureRecognizer *gestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressedHandler:)];
    [DOWNBUTTON addGestureRecognizer:gestureRecognizer];
    [self.view addSubview:DOWNBUTTON];
    TURNBUTTON = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT/4)];
    TURNBUTTON.opaque = NO;
    TURNBUTTON.tag = 10;
    //    TURNBUTTON.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.1];
    //    TURNBUTTON.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.0f]; // transparent background.
    [TURNBUTTON addTarget:self action:@selector(blockTurn:)
         forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:TURNBUTTON];
    LEFTBUTTON = [[UIButton alloc]initWithFrame:CGRectMake(0, VIEW_HEIGHT/4, VIEW_WIDTH/2, VIEW_HEIGHT/4 *2)];
    LEFTBUTTON.opaque = NO;
    LEFTBUTTON.tag = 10;
    //    LEFTBUTTON.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.1];
    //    LEFTBUTTON.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.0f]; // transparent background.
    [LEFTBUTTON addTarget:self action:@selector(blockLeft:)
         forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:LEFTBUTTON];
    RIGHTBUTTON = [[UIButton alloc]initWithFrame:CGRectMake(VIEW_WIDTH / 2, VIEW_HEIGHT/4 , VIEW_WIDTH/2, VIEW_HEIGHT/4 *2)];
    RIGHTBUTTON.opaque = NO;
    RIGHTBUTTON.tag = 10;
    //    RIGHTBUTTON.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.1];
    //    RIGHTBUTTON.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.0f]; // transparent background.
    [RIGHTBUTTON addTarget:self action:@selector(blockRight:)
          forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:RIGHTBUTTON];
    HOLDBUTTON = [[UIButton alloc]initWithFrame:CGRectMake(20 + CELL_SIZE * 9, VIEW_HEIGHT-CELL_SIZE*20, CELL_SIZE*3, CELL_SIZE*5)];
    HOLDBUTTON.opaque = NO;
    HOLDBUTTON.tag = 10;
    HOLDBUTTON.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.0f]; // transparent background.
    [HOLDBUTTON addTarget:self action:@selector(blockHold:)
         forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:HOLDBUTTON];
    
    PAUSEBUTTON = [[UIButton alloc]initWithFrame:CGRectMake(20 + CELL_SIZE*9 -2, VIEW_HEIGHT-CELL_SIZE*22.5 - MINI_CELL_SIZE/2, CELL_SIZE*3, CELL_SIZE*2.5)];
    PAUSEBUTTON.tag = 10;
    [PAUSEBUTTON addTarget:self action:@selector(pause:)
          forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:PAUSEBUTTON];
    
    
}
-(void) speedChange {
    if (LINE/difficult == LEVEL) {
        LEVEL++;
        [self levelLavelRewrite];
        [time invalidate];
        speed -= changespeed;
        time = [NSTimer scheduledTimerWithTimeInterval:speed
                                                target:self
                                              selector:@selector(dropedBlock)
                                              userInfo:nil repeats:YES];
    }
}
-(void) lineLavelRewrite {
    LINE++;
    lineLabel.text = [NSString stringWithFormat:@"%d",LINE];
    [scoreboard addSubview:lineLabel];
    [self speedChange];
}
-(void) levelLavelRewrite {
    levelLabel.text = [NSString stringWithFormat:@"%d",LEVEL];
    [scoreboard addSubview:levelLabel];
}
-(void) scoreLavelRewrite {
    scoreLabel.text = [NSString stringWithFormat:@"%d",SCORE];
    [scoreboard addSubview:scoreLabel];
}
-(void) nextBlockRandom {
    nextBlockStatus = nextBlockStatus2;
    nextBlockStatus2 = (int)arc4random_uniform(7);
    [self drowNextBlock];
}
-(void) drowNextBlock {
    [self resetNextBlock];
    switch (nextBlockStatus) {
        case 0:
            [self drowNextBlock1];
            break;
        case 1:
            [self drowNextBlock2];
            break;
        case 2:
            [self drowNextBlock3];
            break;
        case 3:
            [self drowNextBlock4];
            break;
        case 4:
            [self drowNextBlock5];
            break;
        case 5:
            [self drowNextBlock6];
            break;
        case 6:
            [self drowNextBlock7];
            break;
    }
}

//ここの処理の切り分け迷い中
//
//
//出現するブロックの決定
- (void) dropBlockChange: (bool*) blockStatus{
    bottom = false;
    turnCount = 0;
    if(blockStatus) {
        currntBlockStatus = nextBlockStatus;
        [self nextBlockRandom];
    } else {
        currntBlockStatus = holdBlockStatus2;
    }
    switch (currntBlockStatus) {
        case 0:
            [self dropPattern1];
            [self drowDropBlock];
            break;
        case 1:
            [self dropPattern2];
            [self drowDropBlock];
            break;
        case 2:
            [self dropPattern3];
            [self drowDropBlock];
            break;
        case 3:
            [self dropPattern4];
            [self drowDropBlock];
            break;
        case 4:
            [self dropPattern5];
            [self drowDropBlock];
            break;
        case 5:
            [self dropPattern6];
            [self drowDropBlock];
            break;
        case 6:
            [self dropPattern7];
            [self drowDropBlock];
            break;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
//縦長
-(void) dropPattern1 {
    dropBlock[0] = existBlock1;
    dropBlock[1] = existBlock1;
    dropBlock[2] = existBlock1;
    dropBlock[3] = existBlock1;
}
-(void) changePattern1 {
    dropBlockTemp = [@[] mutableCopy];
    dropBlockTemp[0] = dropBlock[0];
    for(int i = 1;i < 4; i++) {
        dropBlockTemp[i] = dropBlock[i];
        dropBlock[i] = dropBlock[i*4];
        dropBlock[i*4] = dropBlockTemp[i];
    }
    if(aliginCount > 5) {
        aliginCountTemp = aliginCount - 5;
        aliginCount = 5;
    }
    if(varticalCount > 16){
        varticalCount = 16;
    }
    turnCount++;
}

//四角
-(void) dropPattern2 {
    dropBlock[0] = existBlock;
    dropBlock[1] = existBlock;
    dropBlock[4] = existBlock;
    dropBlock[5] = existBlock;
}
//S字
-(void) dropPattern3 {
    dropBlock[1] = existBlock;
    dropBlock[2] = existBlock;
    dropBlock[4] = existBlock;
    dropBlock[5] = existBlock;
}
//逆S字
-(void) dropPattern4 {
    dropBlock[0] = existBlock;
    dropBlock[1] = existBlock;
    dropBlock[5] = existBlock;
    dropBlock[6] = existBlock;
}
//逆L字
-(void) dropPattern5 {
    dropBlock[0] = existBlock;
    dropBlock[4] = existBlock;
    dropBlock[5] = existBlock;
    dropBlock[6] = existBlock;
}
//L字
-(void) dropPattern6 {
    dropBlock[2] = existBlock;
    dropBlock[4] = existBlock;
    dropBlock[5] = existBlock;
    dropBlock[6] = existBlock;
}
//T字
-(void) dropPattern7 {
    dropBlock[1] = existBlock;
    dropBlock[4] = existBlock;
    dropBlock[5] = existBlock;
    dropBlock[6] = existBlock;
}
-(void) changePattern2 {
    dropBlockTemp = [@[] mutableCopy];
    for(int i = 0; i < 16; i++) {
        dropBlockTemp[i] = noneBlock;
    }
    dropBlockTemp[4] = dropBlock[4];
    dropBlockTemp[5] = dropBlock[5];
    dropBlockTemp[8] = dropBlock[8];
    dropBlockTemp[9] = dropBlock[9];
    dropBlock[2] = dropBlock[0];
    dropBlock[6] = dropBlock[1];
    dropBlock[8] = noneBlock;
    dropBlock[9] = noneBlock;
    
    dropBlock[0] = dropBlockTemp[8];
    dropBlock[4] = dropBlockTemp[9];
    dropBlock[1] = dropBlockTemp[4];
    dropBlock[5] = dropBlockTemp[5];
    if(aliginCount > 6) {
        aliginCount = 6;
    }
    if(varticalCount > 17){
        varticalCount = 17;
        bottom = true;
    }
    if(bottom) {
        varticalCount++;
    }
    turnCount++;
}
-(void) changePattern3 {
    dropBlockTemp = [@[] mutableCopy];
    for(int i = 0; i < 16; i++) {
        dropBlockTemp[i] = noneBlock;
    }
    dropBlockTemp[0] = dropBlock[0];
    dropBlockTemp[1] = dropBlock[1];
    dropBlockTemp[4] = dropBlock[4];
    dropBlockTemp[5] = dropBlock[5];
    dropBlock[9] = dropBlock[2];
    dropBlock[8] = dropBlock[6];
    dropBlock[2] = noneBlock;
    dropBlock[6] = noneBlock;
    
    dropBlock[0] = dropBlockTemp[4];
    dropBlock[1] = dropBlockTemp[0];
    dropBlock[4] = dropBlockTemp[5];
    dropBlock[5] = dropBlockTemp[1];
    if(aliginCount > 6) {
        aliginCount = 6;
    }
    if(varticalCount > 17){
        varticalCount = 17;
        bottom = true;
    }
    turnCount++;
}
//holdしたものの描写
- (void) drowHoldBlock1 {
    for (int i = 0; i < 4; i++) {
        UILabel *cell3 = [[UILabel alloc] initWithFrame:CGRectMake((CELL_SIZE * 3  - MINI_CELL_SIZE)/2,MINI_CELL_SIZE/2 + CELL_SIZE + i * MINI_CELL_SIZE , MINI_CELL_SIZE , MINI_CELL_SIZE)];
        cell3.tag = 20;
        [cell3.layer setBorderWidth:BORDER_WIDTH];
        [cell3.layer setBorderColor:STAGE_COLOR2.CGColor];
        cell3.backgroundColor = DROP_COLOR1;
        [holdView addSubview:cell3];
    };
}
- (void) drowHoldBlock2 {
    for (int i = 0; i < 4; i++) {
        UILabel *cell3 = [[UILabel alloc] initWithFrame:CGRectMake(CENTER_CELL + i*MINI_CELL_SIZE,CELL_SIZE * 2, MINI_CELL_SIZE , MINI_CELL_SIZE)];
        if (i/2 == 1) {
            cell3 = [[UILabel alloc] initWithFrame:CGRectMake(CENTER_CELL + i%2*MINI_CELL_SIZE,CELL_SIZE * 2 + MINI_CELL_SIZE, MINI_CELL_SIZE , MINI_CELL_SIZE)];
        }
        cell3.tag = 20;
        [cell3.layer setBorderWidth:BORDER_WIDTH];
        [cell3.layer setBorderColor:STAGE_COLOR2.CGColor];
        cell3.backgroundColor = DROP_COLOR2;
        [holdView addSubview:cell3];
    };
}
- (void) drowHoldBlock3 {
    for (int i = 0; i < 4; i++) {
        UILabel *cell3 = [[UILabel alloc] initWithFrame:CGRectMake(CENTER_CELL,CELL_SIZE*2 + i*MINI_CELL_SIZE, MINI_CELL_SIZE , MINI_CELL_SIZE)];
        if (i/2 == 1) {
            cell3 = [[UILabel alloc] initWithFrame:CGRectMake(CENTER_CELL + MINI_CELL_SIZE, CELL_SIZE*2 +(i%2+1)*MINI_CELL_SIZE, MINI_CELL_SIZE , MINI_CELL_SIZE)];
        }
        cell3.tag = 20;
        [cell3.layer setBorderWidth:BORDER_WIDTH];
        [cell3.layer setBorderColor:STAGE_COLOR2.CGColor];
        cell3.backgroundColor = DROP_COLOR3;
        [holdView addSubview:cell3];
    };
}
- (void) drowHoldBlock4 {
    for (int i = 0; i < 4; i++) {
        UILabel *cell3 = [[UILabel alloc] initWithFrame:CGRectMake(CENTER_CELL+MINI_CELL_SIZE,CELL_SIZE*2 + i*MINI_CELL_SIZE, MINI_CELL_SIZE , MINI_CELL_SIZE)];
        if (i/2 == 1) {
            cell3 = [[UILabel alloc] initWithFrame:CGRectMake(CENTER_CELL, CELL_SIZE*2 +(i%2+1)*MINI_CELL_SIZE, MINI_CELL_SIZE , MINI_CELL_SIZE)];
        }
        cell3.tag = 20;
        [cell3.layer setBorderWidth:BORDER_WIDTH];
        [cell3.layer setBorderColor:STAGE_COLOR2.CGColor];
        cell3.backgroundColor = DROP_COLOR4;
        [holdView addSubview:cell3];
    };
}
- (void) drowHoldBlock5 {
    for (int i = 0; i < 4; i++) {
        UILabel *cell3 = [[UILabel alloc] initWithFrame:CGRectMake(CENTER_CELL+MINI_CELL_SIZE,CELL_SIZE*2 + i*MINI_CELL_SIZE, MINI_CELL_SIZE , MINI_CELL_SIZE)];
        if (i == 3) {
            cell3 = [[UILabel alloc] initWithFrame:CGRectMake(CENTER_CELL,CELL_SIZE*2 + (i-1)*MINI_CELL_SIZE, MINI_CELL_SIZE , MINI_CELL_SIZE)];
        }
        cell3.tag = 20;
        [cell3.layer setBorderWidth:BORDER_WIDTH];
        [cell3.layer setBorderColor:STAGE_COLOR2.CGColor];
        cell3.backgroundColor = DROP_COLOR5;
        [holdView addSubview:cell3];
    };
}
- (void) drowHoldBlock6 {
    for (int i = 0; i < 4; i++) {
        UILabel *cell3 = [[UILabel alloc] initWithFrame:CGRectMake(CENTER_CELL,CELL_SIZE*2 + i*MINI_CELL_SIZE, MINI_CELL_SIZE , MINI_CELL_SIZE)];
        if (i == 3) {
            cell3 = [[UILabel alloc] initWithFrame:CGRectMake(CENTER_CELL + MINI_CELL_SIZE,CELL_SIZE*2 + (i-1)*MINI_CELL_SIZE, MINI_CELL_SIZE , MINI_CELL_SIZE)];
        }
        cell3.tag = 20;
        [cell3.layer setBorderWidth:BORDER_WIDTH];
        [cell3.layer setBorderColor:STAGE_COLOR2.CGColor];
        cell3.backgroundColor = DROP_COLOR6;
        [holdView addSubview:cell3];
    };
}
- (void) drowHoldBlock7 {
    for (int i = 0; i < 4; i++) {
        UILabel *cell3 = [[UILabel alloc] initWithFrame:CGRectMake(CENTER_CELL,CELL_SIZE*2 + i*MINI_CELL_SIZE, MINI_CELL_SIZE , MINI_CELL_SIZE)];
        if (i == 3) {
            cell3 = [[UILabel alloc] initWithFrame:CGRectMake(CENTER_CELL + MINI_CELL_SIZE,CELL_SIZE*2 + (i-2)*MINI_CELL_SIZE, MINI_CELL_SIZE , MINI_CELL_SIZE)];
        }
        cell3.tag = 20;
        [cell3.layer setBorderWidth:BORDER_WIDTH];
        [cell3.layer setBorderColor:STAGE_COLOR2.CGColor];
        cell3.backgroundColor = DROP_COLOR7;
        [holdView addSubview:cell3];
    };
}
- (void) drowNextBlock1 {
    for (int i = 0; i < 4; i++) {
        UILabel *cell4 = [[UILabel alloc] initWithFrame:CGRectMake((CELL_SIZE * 9  - MINI_CELL_SIZE*3)/2 + i * MINI_CELL_SIZE,(CELL_SIZE*2.5 - MINI_CELL_SIZE)/2, MINI_CELL_SIZE , MINI_CELL_SIZE)];
        cell4.tag = 50;
        [cell4.layer setBorderWidth:BORDER_WIDTH * 2];
        [cell4.layer setBorderColor:STAGE_COLOR2.CGColor];
        cell4.backgroundColor = DROP_COLOR1;
        [nextView addSubview:cell4];
    };
}
- (void) drowNextBlock2 {
    for (int i = 0; i < 4; i++) {
        UILabel *cell4 = [[UILabel alloc] initWithFrame:CGRectMake((CELL_SIZE*9 -MINI_CELL_SIZE)/2 + i*MINI_CELL_SIZE,(CELL_SIZE*3 - MINI_CELL_SIZE*2)/2, MINI_CELL_SIZE , MINI_CELL_SIZE)];
        if (i/2 == 1) {
            cell4 = [[UILabel alloc] initWithFrame:CGRectMake((CELL_SIZE*9 -MINI_CELL_SIZE)/2 + i%2*MINI_CELL_SIZE,(CELL_SIZE*3 - MINI_CELL_SIZE*2)/2 +MINI_CELL_SIZE, MINI_CELL_SIZE , MINI_CELL_SIZE)];
        }
        cell4.tag = 50;
        [cell4.layer setBorderWidth:BORDER_WIDTH];
        [cell4.layer setBorderColor:STAGE_COLOR2.CGColor];
        cell4.backgroundColor = DROP_COLOR2;
        [nextView addSubview:cell4];
    };
}
- (void) drowNextBlock3 {
    for (int i = 0; i < 4; i++) {
        UILabel *cell4 = [[UILabel alloc] initWithFrame:CGRectMake((CELL_SIZE*9-MINI_CELL_SIZE*2)/2 + MINI_CELL_SIZE+i*MINI_CELL_SIZE, CELL_SIZE*3/2-MINI_CELL_SIZE, MINI_CELL_SIZE , MINI_CELL_SIZE)];
        if (i/2 == 1) {
            cell4 = [[UILabel alloc] initWithFrame:CGRectMake((CELL_SIZE*9-MINI_CELL_SIZE*2)/2 + i%2*MINI_CELL_SIZE, CELL_SIZE*3/2, MINI_CELL_SIZE , MINI_CELL_SIZE)];
        }
        cell4.tag = 50;
        [cell4.layer setBorderWidth:BORDER_WIDTH];
        [cell4.layer setBorderColor:STAGE_COLOR2.CGColor];
        cell4.backgroundColor = DROP_COLOR3;
        [nextView addSubview:cell4];
    };
}
- (void) drowNextBlock4 {
    for (int i = 0; i < 4; i++) {
        UILabel *cell4 = [[UILabel alloc] initWithFrame:CGRectMake((CELL_SIZE*9-MINI_CELL_SIZE*2)/2 + i*MINI_CELL_SIZE, CELL_SIZE*3/2-MINI_CELL_SIZE, MINI_CELL_SIZE , MINI_CELL_SIZE)];
        if (i/2 == 1) {
            cell4 = [[UILabel alloc] initWithFrame:CGRectMake(MINI_CELL_SIZE+(CELL_SIZE*9-MINI_CELL_SIZE*2)/2 + i%2*MINI_CELL_SIZE, CELL_SIZE*3/2, MINI_CELL_SIZE , MINI_CELL_SIZE)];
        }
        cell4.tag = 50;
        [cell4.layer setBorderWidth:BORDER_WIDTH];
        [cell4.layer setBorderColor:STAGE_COLOR2.CGColor];
        cell4.backgroundColor = DROP_COLOR4;
        [nextView addSubview:cell4];
    };
}
- (void) drowNextBlock5 {
    for (int i = 0; i < 4; i++) {
        UILabel *cell4 = [[UILabel alloc] initWithFrame:CGRectMake((CELL_SIZE*9-MINI_CELL_SIZE*2)/2 + i*MINI_CELL_SIZE, CELL_SIZE*3/2, MINI_CELL_SIZE , MINI_CELL_SIZE)];
        if (i == 3) {
            cell4 = [[UILabel alloc] initWithFrame:CGRectMake((CELL_SIZE*9-MINI_CELL_SIZE*2)/2,CELL_SIZE*3/2-MINI_CELL_SIZE, MINI_CELL_SIZE , MINI_CELL_SIZE)];
        }
        cell4.tag = 50;
        [cell4.layer setBorderWidth:BORDER_WIDTH];
        [cell4.layer setBorderColor:STAGE_COLOR2.CGColor];
        cell4.backgroundColor = DROP_COLOR5;
        [nextView addSubview:cell4];
    };
}
- (void) drowNextBlock6 {
    for (int i = 0; i < 4; i++) {
        UILabel *cell4 = [[UILabel alloc] initWithFrame:CGRectMake((CELL_SIZE*9-MINI_CELL_SIZE*2)/2 + i*MINI_CELL_SIZE, CELL_SIZE*3/2, MINI_CELL_SIZE , MINI_CELL_SIZE)];
        if (i == 3) {
            cell4 = [[UILabel alloc] initWithFrame:CGRectMake((CELL_SIZE*9+MINI_CELL_SIZE*2)/2,CELL_SIZE*3/2-MINI_CELL_SIZE, MINI_CELL_SIZE , MINI_CELL_SIZE)];
        }
        cell4.tag = 50;
        [cell4.layer setBorderWidth:BORDER_WIDTH];
        [cell4.layer setBorderColor:STAGE_COLOR2.CGColor];
        cell4.backgroundColor = DROP_COLOR6;
        [nextView addSubview:cell4];
    };
}
- (void) drowNextBlock7 {
    for (int i = 0; i < 4; i++) {
        UILabel *cell4 = [[UILabel alloc] initWithFrame:CGRectMake((CELL_SIZE*9-MINI_CELL_SIZE*2)/2 + i*MINI_CELL_SIZE, CELL_SIZE*3/2, MINI_CELL_SIZE , MINI_CELL_SIZE)];
        if (i == 3) {
            cell4 = [[UILabel alloc] initWithFrame:CGRectMake((CELL_SIZE*9)/2,CELL_SIZE*3/2-MINI_CELL_SIZE, MINI_CELL_SIZE , MINI_CELL_SIZE)];
        }
        cell4.tag = 50;
        [cell4.layer setBorderWidth:BORDER_WIDTH];
        [cell4.layer setBorderColor:STAGE_COLOR2.CGColor];
        cell4.backgroundColor = DROP_COLOR7;
        [nextView addSubview:cell4];
    };
}

//ステージ上のブロックの描写
- (void) drowStageBlock {
    for (int i = 0; i < 180; i++) {
        UILabel *cell = [[UILabel alloc] initWithFrame:CGRectMake((i % 9) * CELL_SIZE,(i / 9) * CELL_SIZE, CELL_SIZE , CELL_SIZE)];
        [cell.layer setBorderWidth:0.25];
        [cell.layer setBorderColor:STAGE_COLOR2.CGColor];
        cell.tag = 5;
        if(stageBlock[i] == existBlock1) {
            cell.backgroundColor = DROP_COLOR1;
        }else if(stageBlock[i] == existBlock2) {
            cell.backgroundColor = DROP_COLOR2;
        }else if(stageBlock[i] == existBlock3) {
            cell.backgroundColor = DROP_COLOR3;
        }else if(stageBlock[i] == existBlock4) {
            cell.backgroundColor = DROP_COLOR4;
        }else if(stageBlock[i] == existBlock5) {
            cell.backgroundColor = DROP_COLOR5;
        }else if(stageBlock[i] == existBlock6) {
            cell.backgroundColor = DROP_COLOR6;
        }else if(stageBlock[i] == existBlock7) {
            cell.backgroundColor = DROP_COLOR7;
        }
        stageBlock2[i] = cell;
        [stage addSubview:stageBlock2[i]];
    };
}
//ポーズを消す
-(void) resetPauseView {
    [sound actionPauseSound];
    for(int i = 0; i < 4; i++){
        [[self.view viewWithTag:100] removeFromSuperview];
    }
    [self.view addSubview:DOWNBUTTON];
    [self.view addSubview:LEFTBUTTON];
    [self.view addSubview:RIGHTBUTTON];
    [self.view addSubview:TURNBUTTON];
    [self.view addSubview:PAUSEBUTTON];
    [self.view addSubview:HOLDBUTTON];
}
//動かしているブロックを一回消すメソッド(再描写)
-(void) resetDropBlock {
    for(UIView* view in stage.subviews) {
        if(view.tag == 1) {
            [view removeFromSuperview];
        }
    }
}
//ボタンを消すメソッド
-(void) resetButtonBlock {
    for(int i = 0; i < 6; i++){
        [[self.view viewWithTag:10] removeFromSuperview];
    }
}
//ステージブロックを一回消すメソッド(再描写)
-(void) resetStageBlock {
    for(UIView* view in stage.subviews) {
        if(view.tag == 5) {
            [view removeFromSuperview];
        }
    }
}
//ホールドブロックを一回消すメソッド(再描写)
-(void) resetHoldBlock {
    for(UIView* view in holdView.subviews) {
        if(view.tag == 20) {
            [view removeFromSuperview];
        }
    }
}
//次のブロックを消すメソッド
-(void) resetNextBlock {
    for(UIView* view in nextView.subviews) {
        if(view.tag == 50) {
            [view removeFromSuperview];
        }
    }
}
//ポーズ画面表示
-(void)pause:(UIButton*)button{
    [sound actionPauseSound];

    pauseView = [[UIView alloc]initWithFrame:CGRectMake(VIEW_WIDTH * 0.1, VIEW_WIDTH * 0.5, VIEW_WIDTH * 0.8, VIEW_WIDTH * 0.9)];
    pauseView.backgroundColor = STAGE_COLOR;
    pauseView.tag = 100;
    [pauseView.layer setBorderWidth:3];
    [pauseView.layer setBorderColor:STAGE_COLOR2.CGColor];
    [time invalidate];
    [self resetButtonBlock];
    [self.view addSubview:pauseView];
    pauselabel = [[UILabel alloc]initWithFrame:CGRectMake(0, MINI_CELL_SIZE, VIEW_WIDTH * 0.8, CELL_SIZE*3)];
    pauselabel.text = @"PAUSE";
    pauselabel.textAlignment = NSTextAlignmentCenter;
    pauselabel.font = [UIFont fontWithName:@"AppleGothic" size:30];
    pauselabel.textColor = STAGE_COLOR3;
    [pauseView addSubview:pauselabel];
    RESUMEBUTTON = [[UIButton alloc]initWithFrame:CGRectMake(CELL_SIZE*2.5, CELL_SIZE*5, CELL_SIZE*6, CELL_SIZE*2)];
    RESUMEBUTTON.opaque = NO;
    [RESUMEBUTTON.layer setBorderWidth:3];
    [RESUMEBUTTON.layer setBorderColor:STAGE_COLOR2.CGColor];
    [RESUMEBUTTON setTitle:@"RESUME" forState:UIControlStateNormal];
    [RESUMEBUTTON setTitleColor:STAGE_COLOR3 forState:UIControlStateNormal];
    RESUMEBUTTON.tag = 100;
    [RESUMEBUTTON addTarget:self action:@selector(resume:)
           forControlEvents:UIControlEventTouchDown];
    [pauseView addSubview:RESUMEBUTTON];
    HOMEBUTTON = [[UIButton alloc]initWithFrame:CGRectMake(CELL_SIZE*2.5, CELL_SIZE*8, CELL_SIZE*6, CELL_SIZE*2)];
    HOMEBUTTON.opaque = NO;
    [HOMEBUTTON.layer setBorderWidth:3];
    [HOMEBUTTON.layer setBorderColor:STAGE_COLOR2.CGColor];
    [HOMEBUTTON setTitle:@"HOME" forState:UIControlStateNormal];
    [HOMEBUTTON setTitleColor:STAGE_COLOR3 forState:UIControlStateNormal];
    HOMEBUTTON.tag = 100;
    [HOMEBUTTON addTarget:self action:@selector(home:)
         forControlEvents:UIControlEventTouchDown];
    [pauseView addSubview:HOMEBUTTON];
}
//ゲーム再開
-(void)resume:(UIButton*)button{
    [self resetPauseView];
    time = [NSTimer scheduledTimerWithTimeInterval:speed
                                            target:self
                                          selector:@selector(dropedBlock)
                                          userInfo:nil repeats:YES];
}
//ホームに戻る
-(void)home:(UIButton*)button{
    [sound moveViewSound];
    [delegate modalViewWillClose];
}

-(void)blockTurn:(UIButton*)button{
    aliginCountTemp = 0;
    noneBlockCount = 0;
    turn = false;
    blockCheck = false;

    [sound actionBlockSound];
    
    switch (currntBlockStatus) {
        case 0:
            if(turnCount%2 == 0) {
                [self changePattern1];
                [self turnCheck];
                [self topBlockCheck];
                if(blockCheck && turn) {
                    [self changePattern1];
                    return;
                }
                for(int i = 0;i <= noneBlockCount; i++) {
                    [self turnCheck];
                    if(turn){
                        varticalCount--;
                        turn = false;
                    }
                    if(i == noneBlockCount){
                        [self turnCheck];
                        if(turn){
                            [self changePattern1];
                            varticalCount += noneBlockCount + 1;
                            [self resetDropBlock];
                        }
                    }
                }
            } else {
                [self rightturn];
                if(turn) {
                    return;
                }
                [self changePattern1];
                [self turnCheck];
                [self leftBlockCheck];
                for(int i = 0;i <= noneBlockCount; i++) {
                    [self turnCheck];
                    if(turn){
                        aliginCount--;
                        turn = false;
                    }
                    if(i == noneBlockCount){
                        [self turnCheck];
                        if(turn){
                            [self changePattern1];
                            aliginCount += noneBlockCount + 1 + aliginCountTemp;
                            [self resetDropBlock];
                        }
                    }
                }
            }
            [self resetDropBlock];
            [self drowDropBlock];
            break;
        case 1:
            break;
            
        default:
            if(turnCount%2 == 0) {
                [self changePattern3];
                [self topBlockCheck2];
                [self turnCheck];
                if(blockCheck && turn) {
                    [self changePattern2];
                    [self changePattern3];
                    [self changePattern2];
                    return;
                }
                for(int i = 0;i <= noneBlockCount; i++) {
                    [self turnCheck];
                    if(turn){
                        varticalCount--;
                        turn = false;
                    }
                    if(i == noneBlockCount){
                        [self turnCheck];
                        if(turn){
                            [self changePattern2];
                            [self changePattern3];
                            [self changePattern2];
                            varticalCount += noneBlockCount + 1;
                            [self resetDropBlock];
                        }
                    }
                }
            } else {
                [self rightturn2];
                if(turn) {
                    return;
                }
                [self changePattern2];
                [self leftBlockCheck2];
                for(int i = 0;i <= noneBlockCount; i++) {
                    [self turnCheck];
                    if(turn){
                        aliginCount--;
                        turn = false;
                    }
                    if(i == noneBlockCount || aliginCount < 0){
                        [self turnCheck];
                        if(turn || aliginCount < 0){
                            [self changePattern3];
                            [self changePattern2];
                            [self changePattern3];
                            aliginCount += noneBlockCount + 1;
                            [self resetDropBlock];
                        }
                    }
                }
            }
            [self resetDropBlock];
    [self drowDropBlock];
    }
}
-(void) rightturn {
    int number;
    number =  varticalCount * 9 + aliginCount;
    if(number%9 > 6) {
        for (int i = 1; i < 4; i++) {
            noneBlockCount++;
            if(stageBlock[number - i] != noneBlock) {
                turn = true;
                break;
            }
        }
    }
}
-(void) rightturn2 {
    int number;
    number =  varticalCount * 9 + aliginCount;
    if(number%9 == 7) {
        number--;
        dropBlockTemp = [@[] mutableCopy];
        for(int i = 0; i < 8; i++) {
            dropBlockTemp[i] = noneBlock;
        }
        dropBlockTemp[0] = dropBlock[8];
        dropBlockTemp[1] = dropBlock[4];
        dropBlockTemp[2] = dropBlock[0];
        dropBlockTemp[4] = dropBlock[9];
        dropBlockTemp[5] = dropBlock[5];
        dropBlockTemp[6] = dropBlock[1];
        for(int i = 0; i < 8; i++) {
            if(i == 7 || i == 3 || dropBlockTemp[i] == noneBlock) {
                continue;
            }
            if(stageBlock[number + i] != noneBlock) {
                if(dropBlockTemp[i] != noneBlock) {
                    turn = true;
                    break;
                }
            }
        }
    }
}
-(void)drowHoldBlock {
    [self resetHoldBlock];
    switch (holdBlockStatus) {
        case 0:
            [self drowHoldBlock1];
            break;
        case 1:
            [self drowHoldBlock2];
            break;
        case 2:
            [self drowHoldBlock3];
            break;
        case 3:
            [self drowHoldBlock4];
            break;
        case 4:
            [self drowHoldBlock5];
            break;
        case 5:
            [self drowHoldBlock6];
            break;
        case 6:
            [self drowHoldBlock7];
            break;
    }
}
-(void)blockHold:(UIButton*)button{
    if (!hold) {
        return;
    }
    [sound holdBlockSound];
    if(holdBlockStatus == -1){
        holdBlockStatus = currntBlockStatus;
        [self nextBlock];
        hold = false;
    }else {
        hold = false;
        holdBlockStatus2 = holdBlockStatus;
        holdBlockStatus = currntBlockStatus;
        [self resetDropBlock];
        for (int i = 0; i < 16; i++) {
            dropBlock[i] = noneBlock;
        }
        aliginCount = 2;
        varticalCount = 0;
        [self dropBlockChange : false];
    }
    [self drowHoldBlock];
}

-(void)blockDown:(UIButton*)button{
    [sound actionBlockSound];
    varticalCount++;
    [self arriveBottom];
    [self resetDropBlock];
    [self drowDropBlock];
}
-(void)longPressedHandler:(UILongPressGestureRecognizer *)gestureRecognizer {
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
            longtap = [NSTimer scheduledTimerWithTimeInterval:0.05
                                                    target:self
                                                  selector:@selector(dropedBlock)
                                                  userInfo:nil
                                                   repeats:YES];
            break;
        case UIGestureRecognizerStateEnded:
            [longtap invalidate];
            break;
        default:
            break;
    }
}

-(void)blockRight:(UIButton*)button{
    [sound actionBlockSound];
    right = false;
    [self arriveRight];
    if(right) {
        return;
    }
    aliginCount++;
    [self resetDropBlock];
    [self drowDropBlock];
}
-(void)blockLeft:(UIButton*)button{
    [sound actionBlockSound];
    left = false;
    [self arriveLeft];
    if(left) {
        return;
    }
    aliginCount--;
    [self resetDropBlock];
    [self drowDropBlock];
}
//回転時に移動空白があるかを確認するメソッド
//縦棒の方
-(void) topBlockCheck {
    int number;
    number =  varticalCount * 9 + aliginCount;
    int upMaxCount = 3;
    for (int i = 0; i < upMaxCount; i++) {
        noneBlockCount++;
        if(number-(i+1)*9 < 0) {
            blockCheck = true;
            break;
        }
        if(stageBlock[number-i*9] != noneBlock) {
            break;
        }
    }
}
-(void) leftBlockCheck {
    int number;
//    temp = [dropBlockTemp[0] intValue];
//    number = ((temp / 4) * 9 + temp % 4) + (varticalCount) * 9 + aliginCount;
    number =  varticalCount * 9 + aliginCount;
    int leftMaxCount = aliginCount;
    if(leftMaxCount > 3) {
        leftMaxCount = 3;
    }
    for (int i = 0; i < leftMaxCount; i++) {
        noneBlockCount++;
        if(stageBlock[number-i] != noneBlock) {
            break;
        }
    }
}
//縦棒以外のもの
-(void) topBlockCheck2 {
    [self currentBlock];
    int temp, temp2 = 1000 , temp3 = 1000 ,number;
    for (int i = 0; i < 4; i++) {
        temp = [dropBlockTemp[i] intValue];
        number = ((temp / 4) * 9 + temp % 4) + (varticalCount) * 9 + aliginCount;
        
        if(number % 9 == aliginCount && temp2 > number) {
            temp2 = number;
        }else if(number % 9 == aliginCount + 1 && temp3 > number){
            temp3 = number;
        }
    }
    int upMaxCount = 2;
    for (int i = 0; i < upMaxCount; i++) {
        noneBlockCount++;
        if(temp2-(i+1)*9 < 0 || temp3-(i+1)*9 < 0) {
//            NSLog(@"%d",temp2-(i+1)*9);
            blockCheck = true;
            break;
        }
        if(stageBlock[temp2-i*9] != noneBlock && stageBlock[temp3-i*9] != noneBlock) {
            break;
        }
    }
}
-(void) leftBlockCheck2 {
    [self currentBlock];
    int temp, temp2 = 1000 , temp3 = 1000 ,number;
    for (int i = 0; i < 4; i++) {
        temp = [dropBlockTemp[i] intValue];
        number = ((temp / 4) * 9 + temp % 4) + (varticalCount) * 9 + aliginCount;
        
        if(number / 9 == varticalCount && temp2 > number) {
            temp2 = number;
        }else if(number / 9 == varticalCount + 1 && temp3 > number){
            temp3 = number;
        }
    }
    int leftMaxCount = aliginCount;
    if(leftMaxCount > 3) {
        leftMaxCount = 3;
    }
    for (int i = 0; i < leftMaxCount; i++) {
        noneBlockCount++;
        if(stageBlock[temp2-i] != noneBlock && stageBlock[temp3-i] != noneBlock) {
            break;
        }
    }
    
}
//回転チェックメソッド
-(void) turnCheck {
    [self currentBlock];
    int temp, number;
    for(int i = 0; i < 4; i++){
        temp = [dropBlockTemp[i] intValue];
        number = ((temp / 4) * 9 + temp % 4) + (varticalCount) * 9 + aliginCount;
        if(stageBlock[number] != noneBlock) {
            turn = true;
        }
    }
}
//右端チェックメソッド
- (void) arriveRight {
    [self currentBlock];
    int temp, number;
    for(int i = 0; i < 4; i++){
        temp = [dropBlockTemp[i] intValue];
        number = ((temp / 4) * 9 + temp % 4) + (varticalCount) * 9 + aliginCount;
        //        NSLog(@"%d",number);
        if (number == 179) {
            right = true;
            break;
        }
        if((aliginCount + (temp % 4)) == 8){
            right = true;
        }
        if(stageBlock[number + 1] != noneBlock) {
            right = true;
        }
    }
}
//左端チェックメソッド
- (void) arriveLeft {
    [self currentBlock];
    int temp, number;
    for(int i = 0; i < 4; i++){
        temp = [dropBlockTemp[i] intValue];
        number = ((temp / 4) * 9 + temp % 4) + (varticalCount) * 9 + aliginCount;
        if(number == 0) {
            left = true;
            break;
        }
        if((aliginCount + (temp % 4)) == 0){
            left = true;
        }
        if(stageBlock[number - 1] != noneBlock) {
            left = true;
        }
    }
}
//着地チェックメソッド
- (void) arriveBottom {
    [self currentBlock];
    int temp, number;
    for(int i = 0; i < 4; i++){
        temp = [dropBlockTemp[i] intValue];
        if((varticalCount + temp / 4) == 20){
            [self fixingBlock];
            [self gameover];
            break;
        }
        number = ((temp / 4) * 9 + temp % 4) + (varticalCount - 1) * 9 + aliginCount;
        if(stageBlock[number + 9] != noneBlock) {
            [self fixingBlock];
            [self gameover];
            break;
        }
    }
}


//動かしているブロックの配列の場所を返すメソッド
- (void) currentBlock {
    dropBlockTemp = [@[] mutableCopy];
    int tempcount = 0;
    for (int i = 0; i < 16; i++) {
        if(dropBlock[i] != noneBlock) {
            dropBlockTemp[tempcount] = [NSNumber numberWithInt:i];
            tempcount++;
        }
    }
}
-(void)checkColor {
    switch (currntBlockStatus) {
        case 0:
            tempColor = DROP_COLOR1;
            tempBlock = existBlock1;
            break;
        case 1:
            tempColor = DROP_COLOR2;
            tempBlock = existBlock2;
            break;
        case 2:
            tempColor = DROP_COLOR3;
            tempBlock = existBlock3;
            break;
        case 3:
            tempColor = DROP_COLOR4;
            tempBlock = existBlock4;
            break;
        case 4:
            tempColor = DROP_COLOR5;
            tempBlock = existBlock5;
            break;
        case 5:
            tempColor = DROP_COLOR6;
            tempBlock = existBlock6;
            break;
        case 6:
            tempColor = DROP_COLOR7;
            tempBlock = existBlock7;
            break;
    }
}
//動かしているドロップの画面描写
- (void) drowDropBlock {
    [self checkColor];
    for (int i = 0; i < 16; i++) {
        UILabel *cell2 = [[UILabel alloc] initWithFrame:CGRectMake((aliginCount * CELL_SIZE) + (i % 4) * CELL_SIZE,(varticalCount * CELL_SIZE) + (i /4) * CELL_SIZE, CELL_SIZE , CELL_SIZE)];
        cell2.tag = 1;
        cell2.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.0f]; // transparent background.
        if(dropBlock[i] != noneBlock) {
            [cell2.layer setBorderWidth:BORDER_WIDTH];
            [cell2.layer setBorderColor:STAGE_COLOR2.CGColor];
            cell2.backgroundColor = tempColor;
        }
        dropBlock2[i] = cell2;
        [stage addSubview:dropBlock2[i]];
    };
}
//動かしているブロックのステージへの以降作業
-(void) fixingBlock {
    [longtap invalidate];
    [self resetStageBlock];
    int temp;
    [self checkColor];
    for(int i = 0; i < 4; i++){
        temp = [dropBlockTemp[i] intValue];
        int number = ((temp / 4) * 9 + temp % 4) + (varticalCount - 1) * 9 + aliginCount;
        stageBlock[number] = tempBlock;
    }
    [self lineClear];
    [self nextBlock];
}
//次のブロックへ
-(void) nextBlock {
    hold = true;
    if(!gameover) {
        [self drowStageBlock];
        [self resetDropBlock];
        for (int i = 0; i < 16; i++) {
            dropBlock[i] = noneBlock;
        }
        aliginCount = 2;
        varticalCount = 0;
        [self dropBlockChange : true];
    }
}
//ラインを消すメソッド
-(void) lineClear{
    BOOL clear = true,onceChance = true,onceChance2 = true;
    int deleteCount = 0;
    for (int i = 0; i < 20; i++) {
        clear = true;
        for (int j = 0; j < 9; j++) {
            if(stageBlock[(i*9)+j] == noneBlock) {
                clear = false;
                break;
            }
        }
        if (clear) {
            if(onceChance) {
                [sound2 deleteBlockSound];
                onceChance = false;
                onceChance2 = false;
            }
            [self lineDown:i];
            deleteCount++;
        }
    }
    if (onceChance2){
        [sound arriveBlockSound];
    }
    if (deleteCount == 4) {
        SCORE += 1200;
    } else if(deleteCount == 3) {
        SCORE += 300;
    } else if(deleteCount == 2) {
        SCORE += 100;
    } else if(deleteCount == 1) {
        SCORE += 40;
    }
    [self scoreLavelRewrite];
    
}
//消えてずれるメソッド
-(void) lineDown:(int*)col {
    [self lineLavelRewrite];
    int Max = col;
    Max = (Max+1) * 9 - 1;
    for (int i = Max; i >= 0; i--) {
        if (i >= 9) {
//このメソッドでメモリーが解放される
            [self resetStageBlock];
            stageBlock[i] = stageBlock[i - 9];
        } else {
            stageBlock[i] = noneBlock;
        }
    }
}
-(void) gameover {
    for(int i = 2; i < 6; i++ ){
        if(stageBlock[i] != noneBlock) {
            for(int i = 0; i < 6; i++){
                [[self.view viewWithTag:10] removeFromSuperview];
            }
            [self stopTetoris];
            break;
        }
    }
    for(int i = 11; i < 15; i++ ){
        if(stageBlock[i] != noneBlock) {
            for(int i = 0; i < 6; i++){
                [[self.view viewWithTag:10] removeFromSuperview];
            }
            [self stopTetoris];
            break;
        }
    }
}
-(void) stopTetoris {
    access = [[plistAccess alloc]init];
    [access accessPlist];
    if (![access.scoreData[0] isEqualToString:@"------"]) {
        if([access.scoreData[0] integerValue] < SCORE) {
            access.scoreData[0] = [NSString stringWithFormat:@"%d",SCORE];
        }
    } else {
        access.scoreData[0] = [NSString stringWithFormat:@"%d",SCORE];
    }
    if (![access.scoreData[1] isEqualToString:@"------"]) {
        if([access.scoreData[1] integerValue] < LINE) {
            access.scoreData[1] = [NSString stringWithFormat:@"%d",LINE];
        }
    } else {
        access.scoreData[1] = [NSString stringWithFormat:@"%d",LINE];
        
    }
    if (![access.scoreData[2] isEqualToString:@"------"]) {
        if([access.scoreData[2] integerValue] < LEVEL) {
            access.scoreData[2] = [NSString stringWithFormat:@"%d",LEVEL];
        }
    } else {
        access.scoreData[2] = [NSString stringWithFormat:@"%d",LEVEL];
    }
    [access.scoreData writeToFile:access.filePath atomically:NO];
    [time invalidate];
    gameover = true;
    [self result];
}

-(void) result {
    pauseView = [[UIView alloc]initWithFrame:CGRectMake(VIEW_WIDTH * 0.1, VIEW_WIDTH * 0.5, VIEW_WIDTH * 0.8, VIEW_WIDTH * 0.9)];
    pauseView.backgroundColor = STAGE_COLOR;
    pauseView.tag = 100;
    [pauseView.layer setBorderWidth:3];
    [pauseView.layer setBorderColor:STAGE_COLOR2.CGColor];
    [self resetButtonBlock];

    [self.view addSubview:pauseView];
    pauselabel = [[UILabel alloc]initWithFrame:CGRectMake(0, MINI_CELL_SIZE, VIEW_WIDTH * 0.8, CELL_SIZE*3)];
    pauselabel.text = @"RESULT";
    pauselabel.textAlignment = NSTextAlignmentCenter;
    pauselabel.font = [UIFont fontWithName:@"AppleGothic" size:30];
    pauselabel.textColor = STAGE_COLOR3;
    [pauseView addSubview:pauselabel];
    [pauseView addSubview:RESUMEBUTTON];
    
 
    UILabel *resultScoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CELL_SIZE*3.5, VIEW_WIDTH * 0.8, CELL_SIZE)];
    resultScoreLabel.text = [@"SCORE:" stringByAppendingString:scoreLabel.text] ;
    resultScoreLabel.textAlignment = NSTextAlignmentCenter;
    resultScoreLabel.textColor = STAGE_COLOR3;
    [pauseView addSubview:resultScoreLabel];
 
    UILabel *resultLineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CELL_SIZE*5, VIEW_WIDTH * 0.8, CELL_SIZE)];
    resultLineLabel.text = [@"LINES:" stringByAppendingString:lineLabel.text] ;
    resultLineLabel.textAlignment = NSTextAlignmentCenter;
    resultLineLabel.textColor = STAGE_COLOR3;
    [pauseView addSubview:resultLineLabel];

    UILabel *resultLevelLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CELL_SIZE*6.5, VIEW_WIDTH * 0.8, CELL_SIZE)];
    resultLevelLabel.text = [@"LEVEL:" stringByAppendingString:levelLabel.text] ;
    resultLevelLabel.textAlignment = NSTextAlignmentCenter;
    resultLevelLabel.textColor = STAGE_COLOR3;
    [pauseView addSubview:resultLevelLabel];

    
    HOMEBUTTON = [[UIButton alloc]initWithFrame:CGRectMake(CELL_SIZE*2.5, CELL_SIZE*8, CELL_SIZE*6, CELL_SIZE*2)];
    HOMEBUTTON.opaque = NO;
    [HOMEBUTTON.layer setBorderWidth:3];
    [HOMEBUTTON.layer setBorderColor:STAGE_COLOR2.CGColor];
    [HOMEBUTTON setTitle:@"HOME" forState:UIControlStateNormal];
    [HOMEBUTTON setTitleColor:STAGE_COLOR3 forState:UIControlStateNormal];
    HOMEBUTTON.tag = 100;
    [HOMEBUTTON addTarget:self action:@selector(home:)
         forControlEvents:UIControlEventTouchDown];
    [pauseView addSubview:HOMEBUTTON];
    
}
//時間で自動的に落ちるメソッド
-(void)dropedBlock{
    if (!gameover) {
    varticalCount++;
    [self arriveBottom];
    [self resetDropBlock];
    [self drowDropBlock];
    }
}

@end
