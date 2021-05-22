//
//  OvalShapeView.m
//  cardMatch
//
//  Created by Shaik A S on 19/09/18.
//  Copyright © 2018 SHAIK AS. All rights reserved.
//

#import "OvalShapeView.h"

@implementation OvalShapeView
-(void) setColor:(NSString *)color
{
    _color = color;
    [self setNeedsDisplay];
}
-(void) setShade:(CGFloat)shade
{
    _shade = shade;
    [self setNeedsDisplay];
    
}
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

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [self drawOval:rect];
}
-(void) drawOval : (CGRect) rect
{ CGFloat majorAxis =  (rect.size.height/rect.size.width) * 50;
    CGFloat minorAxis = majorAxis/2;
    CGRect oval_rect = CGRectMake(rect.size.width/2- (majorAxis/2), rect.origin.y+rect.size.height/3, majorAxis, minorAxis);
    CGPoint centre = CGPointMake(oval_rect.origin.x + majorAxis/2, oval_rect.origin.y+minorAxis/2);
    UIBezierPath * path = [UIBezierPath bezierPathWithOvalInRect:oval_rect];
    [[self getColor:self.color] setFill];
    [[self getColor:self.color] setStroke];
    [path stroke];
    if(self.shade >0.95 )
        [path fill];
    else if (self.shade > 0.7)
    {  UIBezierPath * path = [[UIBezierPath alloc] init];
        CGFloat xCoordinate = 0 + oval_rect.origin.x;
        for(;xCoordinate<= (majorAxis + oval_rect.origin.x);xCoordinate+=3)
        {
            CGFloat shiftedX = xCoordinate - centre.x;
            CGFloat yCoordinate = ((minorAxis/majorAxis)) * sqrt((majorAxis * majorAxis/4) -  (shiftedX * shiftedX));
            [path moveToPoint:CGPointMake(xCoordinate, yCoordinate + centre.y )];
            [path addLineToPoint:CGPointMake(xCoordinate, -yCoordinate + centre.y ) ] ;
            [path stroke];
        }
         
    }
}
-(UIColor *) getColor : (NSString *) color
{
    if([color isEqualToString:@"green"])
        return [UIColor greenColor] ;
    if([color isEqualToString:@"red"])
        return [UIColor redColor] ;
    if([color isEqualToString:@"purple"])
        return [UIColor purpleColor] ;
    return [UIColor yellowColor];
}

@end
