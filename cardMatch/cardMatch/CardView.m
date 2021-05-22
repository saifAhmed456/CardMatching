//
//  CardView.m
//  cardMatch
//
//  Created by Shaik A S on 14/09/18.
//  Copyright © 2018 SHAIK AS. All rights reserved.
//

#import "CardView.h"

@implementation CardView
-(void)setFaceUp:(BOOL)faceUp
{
    _faceUp = faceUp;
    [self setNeedsDisplay];
}
-(void)setEnabled:(BOOL)enabled
{
    _enabled = enabled;
    [self setNeedsDisplay];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
