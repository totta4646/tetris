//
//  plistAccess.h
//  Tetoris
//
//  Created by totta on 2014/12/05.
//  Copyright (c) 2014年 totta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface plistAccess : NSObject
@property NSMutableArray *scoreData;
@property NSArray *paths;
@property NSString *filePath;
@property NSString *directory;
-(void)accessPlist;
@end
