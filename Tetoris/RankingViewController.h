//
//  RankingViewController.h
//  Tetoris
//
//  Created by totta on 2014/12/10.
//  Copyright (c) 2014年 totta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "constData.h"
#import "UIColor+Hex.h"
#import <LobiRanking/LobiRanking.h>
#import <LobiCore/LobiCore.h>

@interface RankingViewController : UIViewController {
    UIScrollView *rankingview;
    LobiNetworkResponse *rankingData;
    UIButton *back;
}

@end
