//
//  RankingViewController.m
//  Tetoris
//
//  Created by totta on 2014/12/10.
//  Copyright (c) 2014年 totta. All rights reserved.
//

#import "RankingViewController.h"

@interface RankingViewController ()

@end

@implementation RankingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = STAGE_COLOR;
    
    rankingview = [[UIScrollView alloc]initWithFrame:CGRectMake(0.05333333333333 * VIEW_WIDTH , VIEW_HEIGHT - CELL_SIZE * 18.5 , 0.89333333333334 * VIEW_WIDTH, VIEW_HEIGHT - (VIEW_HEIGHT - CELL_SIZE * 19.5)*2)];
    [rankingview.layer setBorderWidth:5];
    [rankingview.layer setBorderColor:STAGE_COLOR2.CGColor];
    rankingview.layer.cornerRadius = 5.0f;
    [self.view addSubview:rankingview];
    
    UILabel *rankingtitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, VIEW_WIDTH, 100)];
    rankingtitle.font = [UIFont fontWithName:@"AppleGothic" size:40];
    rankingtitle.text = @"RANKING";
    rankingtitle.textAlignment = NSTextAlignmentCenter;
    rankingtitle.textColor = STAGE_COLOR3;
    [self.view addSubview:rankingtitle];
    
    back = [[UIButton alloc]initWithFrame:CGRectMake(VIEW_WIDTH/2 - VIEW_WIDTH/4 , VIEW_HEIGHT/4*3 + VIEW_HEIGHT / 10 +MINI_CELL_SIZE, VIEW_WIDTH/2,50)];
    [back setTitle:@"BACK" forState:UIControlStateNormal];
    [back addTarget:self action:@selector(backAction:)
         forControlEvents:UIControlEventTouchDown];
    [back setTitleColor:STAGE_COLOR3 forState:UIControlStateNormal];
    back.backgroundColor = STAGE_COLOR;
    [back.layer setBorderWidth:2.0];
    [back.layer setBorderColor:STAGE_COLOR2.CGColor];
    [self.view addSubview:back];
    
    //ランキングを描写
    [self writeRanking];
}
-(void)backAction:(UIButton*)button{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void) writeRanking {
    [LobiAPI getRanking:@"max_score-56824646"
                   type:KLRRankingRangeAll
                 origin:KLRRankingCursorOriginTop
                 cursor:1
                  limit:30
                handler:^(LobiNetworkResponse *res) {
                    if (res.error) {
                        return ;
                    }
                    int num = 30;
                    rankingData = res;
                    if ([[rankingData.body objectForKey:@"orders"] count] < 30) {
                        num =[[rankingData.body objectForKey:@"orders"] count];
                    }
                    for(int i = 0;i < num; i++) {
                        rankingview.contentSize = CGSizeMake(0.89333333333334 * VIEW_WIDTH,
                                                             0.1 * 0.89333333333334 * VIEW_WIDTH + num*(CELL_SIZE*3 + 0.1 * 0.89333333333334 * VIEW_WIDTH));
                        [self.view addSubview:rankingview];
                        NSDictionary *data = [rankingData.body objectForKey:@"orders"][i];
                        UIView *first = [[UIView alloc]initWithFrame:CGRectMake(0.1 * 0.89333333333334 * VIEW_WIDTH, 0.1 * 0.89333333333334 * VIEW_WIDTH + i*(CELL_SIZE*3 + 0.1 * 0.89333333333334 * VIEW_WIDTH),(0.89333333333334 * VIEW_WIDTH) * 0.8 , CELL_SIZE * 3)];
                        [first.layer setBorderWidth:2];
                        [first.layer setBorderColor:STAGE_COLOR3.CGColor];
                        first.layer.cornerRadius = 5.0f;
                        [rankingview addSubview:first];
                        UILabel *rank = [[UILabel alloc]initWithFrame:CGRectMake(MINI_CELL_SIZE/2, CELL_SIZE* 2/3 ,CELL_SIZE * 2, CELL_SIZE*2)];
                        rank.text = [NSString stringWithFormat:@"%d",i + 1];
                        rank.textAlignment = NSTextAlignmentCenter;
                        rank.font = [UIFont fontWithName:@"AppleGothic" size:40];
                        rank.textColor = STAGE_COLOR3;
                        [first addSubview:rank];
                        UILabel *username = [[UILabel alloc]initWithFrame:CGRectMake(CELL_SIZE  * 2.5, MINI_CELL_SIZE * 2/3 ,CELL_SIZE * 10, CELL_SIZE)];
                        username.text = [data objectForKey:@"name"];
                        username.font = [UIFont fontWithName:@"AppleGothic" size:18];
                        username.textColor = STAGE_COLOR3;
                        [first addSubview:username];
                        UILabel *score = [[UILabel alloc]initWithFrame:CGRectMake(0, MINI_CELL_SIZE * 1.5 ,(0.89333333333334 * VIEW_WIDTH) * 0.8 + CELL_SIZE *2, CELL_SIZE *1.5)];
                        score.text = [data objectForKey:@"score"];
                        score.textAlignment = NSTextAlignmentCenter;
                        score.font = [UIFont fontWithName:@"AppleGothic" size:30];
                        score.textColor = STAGE_COLOR3;
                        [first addSubview:score];
                    }
                }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
