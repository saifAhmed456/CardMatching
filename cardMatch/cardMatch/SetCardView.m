//
//  SetCardView.m
//  cardMatch
//
//  Created by Shaik A S on 14/09/18.
//  Copyright © 2018 SHAIK AS. All rights reserved.
//

#import "SetCardView.h"
#import"OvalShapeView.h"
@interface SetCardView()
@property (nonatomic) CGFloat DIAMOND_SIDE;
@end
@implementation SetCardView
static const double CORNER_FONT_STANDARD_HEIGHT = 180.0;
static const double CORNER_RADIUS = 12.0;
-(CGFloat) cornerScaleFactor
{
    return (self.bounds.size.height / CORNER_FONT_STANDARD_HEIGHT);
}

-(void) setCount_of_shapes:(NSInteger)count_of_shapes
{
    _count_of_shapes = count_of_shapes;
    [self setNeedsDisplay];
}
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
-(void) setShape:(NSString *)shape
{  if([_shape isEqualToString:@"oval"])
{
    
}
    _shape = shape;
    [self setNeedsDisplay];
}
-(void) setDIAMOND_SIDE:(CGFloat)DIAMOND_SIDE
{
    _DIAMOND_SIDE = DIAMOND_SIDE;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    UIBezierPath * roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:(CORNER_RADIUS * [self cornerScaleFactor]) ];
     [roundedRect addClip];
     [[UIColor whiteColor] setFill];
     [[UIColor blackColor] setStroke];
    [roundedRect fill];
     [roundedRect stroke];
     if(self.faceUp == YES)
     {  [[[UIColor brownColor] colorWithAlphaComponent:0.2] setFill];
     UIRectFill(self.bounds);
     
     
     }
   
    if([self.shape isEqualToString:@"diamond"])
    {
        for(int i = 0; i<self.count_of_shapes;i++) {
            [self drawDiamond : CGRectMake(self.bounds.origin.x, i *(self.bounds.size.height/self.count_of_shapes), self.bounds.size.width, self.bounds.size.height/self.count_of_shapes)] ;
           // NSLog(@"%d)I am in diamond for loop....origin y = %f......height = %f",i,i *(self.bounds.size.height/self.count_of_shapes), self.bounds.size.height/self.count_of_shapes);
        }
    }
    if([self.shape isEqualToString:@"oval"])
    {
        for(int i = 0; i<self.count_of_shapes;i++)
        {    [self drawOval:CGRectMake(self.bounds.origin.x, i *(self.bounds.size.height/self.count_of_shapes), self.bounds.size.width, self.bounds.size.height/self.count_of_shapes)] ;
            
        }
    }   if([self.shape isEqualToString:@"squiggle"])
    {
        for(int i = 0; i<self.count_of_shapes;i++)
            [self drawSquiggle : CGRectMake(self.bounds.origin.x, i *(self.bounds.size.height/self.count_of_shapes), self.bounds.size.width, self.bounds.size.height/self.count_of_shapes)] ;
    }
}
-(void) drawDiamond : (CGRect ) rect
{      CGFloat side = rect.size.width<rect.size.height ? rect.size.width : rect.size.height;
    self.DIAMOND_SIDE =  (3 *side)/(4 * 1.41421356);
    CGPoint origin =  CGPointMake(rect.size.width/2  - (self.DIAMOND_SIDE/1.41421356), rect.origin.y+ (rect.size.height/2));
    UIBezierPath * path = [[UIBezierPath alloc] init];
    [path moveToPoint:origin];
    [path addLineToPoint:CGPointMake(origin.x +(self.DIAMOND_SIDE/1.41421356), origin.y - (self.DIAMOND_SIDE/1.41421356))];
    // [path moveToPoint:CGPointMake(origin.x +(self.DIAMOND_SIDE/1.41421356), origin.y - (self.DIAMOND_SIDE/1.41421356))];
    [path addLineToPoint:CGPointMake(origin.x  + (self.DIAMOND_SIDE* 1.41421356), origin.y)];
    [path addLineToPoint:CGPointMake(origin.x +(self.DIAMOND_SIDE/1.41421356), origin.y + (self.DIAMOND_SIDE/1.41421356))];
    [path closePath];
    [[self getColor:self.color] setFill];
    [[self getColor:self.color] setStroke];
    [path stroke];
    if(self.shade >0.95 )
        [path fill];
    else if (self.shade > 0.7)
    {   UIBezierPath *striped_path = [[UIBezierPath alloc] init];
        CGPoint point_2 = CGPointMake(origin.x + 1.41421356 * self.DIAMOND_SIDE, origin.y);
        for(int i = 0.1;i<=self.DIAMOND_SIDE;i+=5)
        {
            [striped_path moveToPoint:CGPointMake(origin.x + (i * sin(M_PI/4)), origin.y - (i * cos(M_PI/4)))];
            [striped_path addLineToPoint:CGPointMake(origin.x + (i * sin(M_PI/4)), origin.y + (i * cos(M_PI/4)))];
            [striped_path stroke];
            [striped_path moveToPoint:CGPointMake(point_2.x - (i * sin(M_PI/4)), point_2.y - (i * cos(M_PI/4)))];
            [striped_path addLineToPoint:CGPointMake(point_2.x - (i * sin(M_PI/4)), point_2.y + (i * cos(M_PI/4)))];
            [striped_path stroke];
        }
        
        
    }
    
}
-(void) drawOval : (CGRect) rect
{ CGFloat majorAxis =  (rect.size.width) * 0.8;
    CGFloat minorAxis = majorAxis/3;
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
        CGFloat xCoordinate =  oval_rect.origin.x;
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

-(void) drawSquiggle : (CGRect )rect
{ static const  CGFloat theta  = 5 *M_PI/12 ;
    CGFloat radiusOfArc = (rect.size.width /3)/theta;
    CGFloat SizeOfSquiggle =  3 *( radiusOfArc * (1 - cos(theta/2)));
    CGPoint centerOfArc_1 = CGPointMake(rect.size.width/3, rect.origin.y +rect.size.height/2 + (radiusOfArc * cos(theta/2)));
    CGPoint centerOfArc_2 = CGPointMake(centerOfArc_1.x + ( 2 *radiusOfArc * sin(theta/2)), centerOfArc_1.y - ( 2 *radiusOfArc * cos(theta/2)));
    CGPoint centerOfArc_3 = CGPointMake(centerOfArc_1.x, centerOfArc_1.y + SizeOfSquiggle);
    CGPoint centerOfArc_4 = CGPointMake(centerOfArc_2.x, centerOfArc_2.y + SizeOfSquiggle);
    CGPoint startOfArc_1 = CGPointMake(centerOfArc_1.x - radiusOfArc * sin(theta/2), centerOfArc_1.y - (radiusOfArc * cos(theta/2)));
    CGPoint startOfArc_3 = CGPointMake(centerOfArc_3.x -radiusOfArc * sin(theta/2) , centerOfArc_3.y - (radiusOfArc * cos(theta/2)));
    CGPoint endOfArc_2 = CGPointMake(centerOfArc_2.x + radiusOfArc * sin(theta/2), centerOfArc_2.y + (radiusOfArc * cos(theta/2)));
    CGPoint controlPoint_1 = CGPointMake(startOfArc_3.x - SizeOfSquiggle/2.5, (startOfArc_3.y + startOfArc_1.y)/2);
    CGPoint endOfArc_4 = CGPointMake(centerOfArc_4.x + radiusOfArc * sin(theta/2), centerOfArc_4.y + (radiusOfArc * cos(theta/2)));
    CGPoint controlPoint_2 = CGPointMake(endOfArc_2.x + SizeOfSquiggle/2.5, (endOfArc_2.y + endOfArc_4.y)/2);
    UIBezierPath * path_1 = [UIBezierPath bezierPathWithArcCenter:centerOfArc_1 radius:radiusOfArc startAngle:((3 *M_PI/2) - theta/2) endAngle:((3*M_PI/2) + theta/2) clockwise:YES ];
    [path_1 addArcWithCenter:centerOfArc_2 radius:radiusOfArc startAngle:(M_PI/2 +theta/2) endAngle:(M_PI/2)-theta/2 clockwise:NO];
    [path_1 moveToPoint:startOfArc_3];
    [path_1 addArcWithCenter:centerOfArc_3 radius:radiusOfArc startAngle:((3 *M_PI/2) - theta/2) endAngle:((3*M_PI/2) + theta/2) clockwise:YES ];
    [path_1 addArcWithCenter:centerOfArc_4 radius:radiusOfArc startAngle:(M_PI/2 +theta/2)endAngle:(M_PI/2)-theta/2 clockwise:NO];
    [path_1 moveToPoint:startOfArc_1];
    [path_1 addQuadCurveToPoint:startOfArc_3 controlPoint:controlPoint_1];
    [path_1 moveToPoint:endOfArc_2];
    [path_1 addQuadCurveToPoint:endOfArc_4 controlPoint:controlPoint_2];
    
    [[self getColor:self.color] setFill];
    [[self getColor:self.color] setStroke];
    [path_1 stroke];
    if ( (self.shade > 0.7))
    {
        CGFloat angle_1 = (3 *M_PI/2) - theta/2;
        CGFloat angle_2 = (M_PI/2 +theta/2);
        CGFloat iteration_value = 10/ (self.bounds.size.width);
        if(self.shade > 0.99) {
            iteration_value= 0.0001;
        }
        for(;angle_1<= ((3*M_PI/2) + theta/2); angle_1+=iteration_value, angle_2 -=iteration_value)
        {
            CGPoint point_1 = CGPointMake(centerOfArc_1.x + (radiusOfArc * cos(angle_1)), centerOfArc_1.y+(radiusOfArc * sin(angle_1)));
            CGPoint point_2 = CGPointMake(centerOfArc_3.x +(radiusOfArc * cos(angle_1)), centerOfArc_3.y+(radiusOfArc * sin(angle_1)));
            UIBezierPath * path = [[UIBezierPath alloc]init];
            [path moveToPoint:point_1];
            [path addLineToPoint:point_2];
            [path stroke];
            CGPoint point_3 = CGPointMake(centerOfArc_2.x + (radiusOfArc * cos(angle_2)) , centerOfArc_2.y +  (radiusOfArc * sin(angle_2)));
            CGPoint point_4 = CGPointMake(centerOfArc_4.x + (radiusOfArc * cos(angle_2)) , centerOfArc_4.y +  (radiusOfArc * sin(angle_2)));
            [path moveToPoint:point_3];
            [path addLineToPoint:point_4];
            [path stroke];
        }
    }
    
}

-(UIColor *) getColor : (NSString *) color
{
    if([color isEqualToString:@"green"])
        return [[UIColor greenColor] colorWithAlphaComponent:0.8];
    if([color isEqualToString:@"red"])
        return [[UIColor redColor] colorWithAlphaComponent:0.8];
    if([color isEqualToString:@"purple"])
        return [[UIColor purpleColor] colorWithAlphaComponent:0.8];
    return [UIColor yellowColor];
}
-(void) setUp
{   self.enabled = YES;
    self.backgroundColor = nil;
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

