//
//  constData.h
//  Tetoris
//
//  Created by totta on 2014/12/04.
//  Copyright (c) 2014年 totta. All rights reserved.
//

#import <Foundation/Foundation.h>
//画面サイズ
#define VIEW_WIDTH self.view.frame.size.width
#define VIEW_HEIGHT self.view.frame.size.height
//初期データ
#define DEFAULT_SCORE @"------"
//画面描写の大きさ
#define CELL_SIZE 0.07466666666667*VIEW_WIDTH
#define MINI_CELL_SIZE CELL_SIZE/4*3
#define CENTER_CELL CELL_SIZE*3/2-MINI_CELL_SIZE
#define BORDER_WIDTH 0.25
//色
//#define STAGE_COLOR [UIColor colorWithRed:0.90588235294118 green:0.93725490196078 blue:0.89411764705882 alpha:1.0]
//#define STAGE_COLOR2 [UIColor colorWithRed:0.70980392156863 green:0.82352941176471 blue:0.70588235294118 alpha:1.0]
//#define STAGE_COLOR3 [UIColor colorWithRed:0.19607843137255 green:0.43137254901961 blue:0.56470588235294 alpha:1.0]
#define STAGE_COLOR [UIColor colorWithHex:@"f3d5a1"]
#define STAGE_COLOR2 [UIColor colorWithHex:@"d9b384"]
#define STAGE_COLOR3 [UIColor colorWithHex:@"73442a"]
#define STAGE_COLOR4 [UIColor colorWithHex:@"d3743e"]
//a7333e 63a2f2 cdbb99
#define DROP_COLOR1 [UIColor colorWithHex:@"99e2f1"]
#define DROP_COLOR2 [UIColor colorWithHex:@"f2c45b"]
#define DROP_COLOR3 [UIColor colorWithHex:@"fad089"]
#define DROP_COLOR4 [UIColor colorWithHex:@"ff9c5b"]
#define DROP_COLOR5 [UIColor colorWithHex:@"f5634a"]
#define DROP_COLOR6 [UIColor colorWithHex:@"f1bbba"]
#define DROP_COLOR7 [UIColor colorWithHex:@"aaccb1"]


@interface constData : NSObject
@end
