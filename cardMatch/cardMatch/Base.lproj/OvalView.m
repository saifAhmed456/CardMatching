//
//  OvalView.m
//  cardMatch
//
//  Created by Shaik A S on 19/09/18.
//  Copyright © 2018 SHAIK AS. All rights reserved.
//

#import "OvalView.h"

@implementation OvalView

-(void) setUp
{   
    self.backgroundColor = [UIColor whiteColor];
    self.opaque = NO;
    self.contentMode = UIViewContentModeRedraw;
    
}
-(void) awakeFromNib
{  [super awakeFromNib];
    [self setUp];
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self setUp];
    return self;
}


@end
