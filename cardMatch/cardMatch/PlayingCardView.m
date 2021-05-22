//
//  PlayingCardView.m
//  cardMatch
//
//  Created by Shaik A S on 12/09/18.
//  Copyright © 2018 SHAIK AS. All rights reserved.
//

#import "PlayingCardView.h"
@interface PlayingCardView()
@property (nonatomic) CGSize cornerTextSize;
@end
@implementation PlayingCardView
static const int CORNER_FONT_STANDARD_HEIGHT = 180.0;
static const int CORNER_RADIUS = 12.0;

-(void)setRank:(NSInteger)rank
{
    _rank = rank;
    [self setNeedsDisplay];
}
-(void)setSuit:(NSString *)suit
{
    _suit = suit;
    [self setNeedsDisplay];
}
-(CGFloat) cornerScaleFactor
{
    return (self.bounds.size.height / CORNER_FONT_STANDARD_HEIGHT);
}
- (void)drawRect:(CGRect)rect {
    UIBezierPath * roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:(CORNER_RADIUS * [self cornerScaleFactor])  ];
    [roundedRect addClip];
    [[UIColor whiteColor] setFill];
    [[UIColor whiteColor] setStroke];
    roundedRect.lineWidth = 10.0;
    UIRectFill(self.bounds);
    [roundedRect stroke];
    if(self.faceUp)
    {
    [self drawCorners];
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
        CGContextRotateCTM(context, M_PI);
        if(self.rank<11)
        [self drawPips];
     else
     {  CGPoint startPoint = CGPointMake(self.cornerTextSize.width + self.bounds.size.width/10, self.cornerTextSize.height*0.3);
         [[UIImage imageNamed:[NSString stringWithFormat:@"%@%@",[self rankAsString],self.suit]] drawInRect:CGRectMake(startPoint.x,startPoint.y, self.bounds.size.width - 2*startPoint.x, self.bounds.size.height - 2 * startPoint.y)];
     }
       
        
    }
    else
    {
        [[UIImage imageNamed:@"stanford"] drawInRect:self.bounds];
    }
    if(!self.enabled)
    {     [[UIColor grayColor] setFill];
            UIRectFill(self.bounds);
        for(UIGestureRecognizer * recogniser in self.gestureRecognizers)
        [self removeGestureRecognizer:recogniser];
    }
}
-(void) drawPips
{  CGFloat OffSetForY = self.cornerTextSize.height * 0.3 ;
    CGFloat iterationValueForY = 0;
    NSInteger TotalNumOfRows = self.rank < 4 ? self.rank :  ((self.rank/3 ) + 1);
    NSInteger TotalNumOfColumns = self.rank < 4 ? 1 : 2;
    CGFloat OffSetForX = self.cornerTextSize.width + self.bounds.size.width/6;
    UIFont * PipFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    PipFont = [PipFont fontWithSize:PipFont.pointSize *  [self cornerScaleFactor] * 1.2];
    NSAttributedString * pip = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@", self.suit] attributes:@{NSFontAttributeName : PipFont, NSForegroundColorAttributeName : [self getColorForSuit]}];
    CGSize PipSize = [pip size];
  
    CGFloat y = TotalNumOfRows==1 ? self.bounds.size.height/2 - PipSize.height/2 :OffSetForY;
    CGFloat x = TotalNumOfColumns == 1 ? ((self.bounds.size.width/2) - (PipSize.width/2) ) :  ( OffSetForX);
    if(TotalNumOfRows!=1)
    iterationValueForY  = ((self.bounds.size.height - (2 * OffSetForY) - (TotalNumOfRows * PipSize.height) )/ (TotalNumOfRows -1) ) + PipSize.height ;
    NSLog(@"height = %f, iteration value = %f,pip height  =%f,offSet Y= %f",self.bounds.size.height,iterationValueForY,PipSize.height,OffSetForY);
    for(int NumOfRows = 1; NumOfRows<=TotalNumOfRows/2 + (TotalNumOfRows%2 );NumOfRows ++)
    {
        
        for(int NumOFColumns = 1;NumOFColumns<=TotalNumOfColumns;NumOFColumns ++)
        {
            [pip drawInRect:CGRectMake(x, y, PipSize.width, PipSize.height)];
            
            if  ( ( (TotalNumOfRows%2 ==0) ||  (NumOfRows!= (TotalNumOfRows/2 + (TotalNumOfRows%2 ))) ) ) {
                CGContextRef context = UIGraphicsGetCurrentContext();
                CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
                CGContextRotateCTM(context, M_PI);
                  [pip drawInRect:CGRectMake(x, y, PipSize.width, PipSize.height)];
               
            }
            x = self.bounds.size.width - PipSize.width -x;
        }
       
        y+= iterationValueForY ;
        NSLog(@"y = %f",y);
    }
    CGPoint centerPoint = CGPointMake((self.bounds.size.width)/2 - PipSize.width/2,(self.bounds.size.height)/2 - PipSize.height/2);
    if( self.rank - TotalNumOfRows*2 >1 || self.rank ==7)
    {
        centerPoint = CGPointMake(centerPoint.x , centerPoint.y - iterationValueForY/2);
    }
    if(self.rank == 10)
        centerPoint.y-=iterationValueForY/2;
    if (TotalNumOfRows * 2 < self.rank)
     {
         [pip drawInRect:CGRectMake(centerPoint.x, centerPoint.y, PipSize.width, PipSize.height)];
         if (self.rank - TotalNumOfRows*2 == 2){
         CGContextRef context = UIGraphicsGetCurrentContext();
         CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
         CGContextRotateCTM(context, M_PI);
         [pip drawInRect:CGRectMake(centerPoint.x, centerPoint.y, PipSize.width, PipSize.height)];
         }
     }
}
-(void) drawCorners
{  NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    UIFont * cornerFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    CGFloat FontSizeForRankTen = 1;
    if(self.rank == 10)
        FontSizeForRankTen = 0.8;
    cornerFont = [cornerFont fontWithSize:cornerFont.pointSize *  [self cornerScaleFactor] * FontSizeForRankTen];
    NSAttributedString * cornerText = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ \n%@",[self rankAsString], self.suit] attributes:@{NSFontAttributeName : cornerFont, NSParagraphStyleAttributeName : paragraphStyle, NSForegroundColorAttributeName : [self getColorForSuit]}];
    
    CGRect text_bounds;
    text_bounds.origin = CGPointMake(CORNER_RADIUS * [self cornerScaleFactor],CORNER_RADIUS * [self cornerScaleFactor]);
   self.cornerTextSize = text_bounds.size = [cornerText size];
    [cornerText drawInRect:text_bounds];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
    CGContextRotateCTM(context, M_PI);
    [cornerText drawInRect:text_bounds];

}
-(NSString*)rankAsString
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"K",@"Q"][self.rank];
}
-(void) setUp
{   self.enabled = YES;
    self.backgroundColor = nil;
    self.opaque = NO;
    self.contentMode = UIViewContentModeRedraw;
    //self.rank = 4;
    //self.suit = @"♠︎";
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
-(void) tap_card : (UITapGestureRecognizer *) recogniser
{  self.faceUp = !self.faceUp;
    //[self setNeedsDisplay];
    NSLog(@"I am in view");
    
    //  [self updateUI];
    
    
    
}
-(UIColor *) getColorForSuit
{
    if([self.suit isEqualToString:@"♥︎"] || [self.suit isEqualToString:@"♦︎"])
    {
        return [UIColor redColor];
    }
    else
        return [UIColor blackColor];
}
 
@end
