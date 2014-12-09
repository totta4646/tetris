//
//  plistAccess.m
//  Tetoris
//
//  Created by totta on 2014/12/05.
//  Copyright (c) 2014年 totta. All rights reserved.
//

#import "plistAccess.h"

@implementation plistAccess

-(void) accessPlist {
    self.paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    self.directory = [self.paths objectAtIndex:0];
    self.filePath = [self.directory stringByAppendingPathComponent:@"data.plist"];
    self.scoreData = [[NSMutableArray alloc] initWithContentsOfFile:self.filePath];
}
@end
