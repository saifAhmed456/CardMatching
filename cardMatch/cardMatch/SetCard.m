//
//  SetCard.m
//  cardMatch
//
//  Created by Shaik A S on 03/09/18.
//  Copyright © 2018 SHAIK AS. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard
-(NSString *)contents
{
    
    return self.shape;
}
-(NSString *) shape
{
    if(!_shape)
        _shape = [[NSString alloc] init];
    return _shape;
}
-(void) initializeWithNumber : (NSInteger) number  withColor: (NSString *)color withShade: (CGFloat) shade withShape: (NSString *) shape
{   //NSLog(@"contents : %d, %f , %@, %@ ",number,shade, color, shape);
    self.color = color; 
    self.shade_of_shape = shade;
    self.number_of_shapes = number;
    self.shape = shape;
   // for(NSUInteger i = 0;i<self.number_of_shapes;i++)
    
      //  self.shape =  [self.shape stringByAppendingString:shape];
   // NSLog(@"properties : : %d, %f , %@, %@ ",self.number_of_shapes, self.shade_of_shape, self.color, [self.shape string]);
   
}

+ (NSArray *) validShapes
{
    return @[@"diamond",@"oval",@"squiggle"];
}
+(NSArray *)validShades
{
     return @[@2,@8,@10];
}
+(NSArray *)validNumbers
{
return @[@1,@2,@3];
}
+(NSArray *)validColors
{
 return @[@"red",@"green",@"purple"];
}
-(NSInteger) matched : (NSArray *) cards
{ //NSLog(@"I am in matched of setCard");
    NSInteger matchScore = 0;
    int count_of_properties[4] = {0};
    for(int i =0;i<[cards count]-1;i++)
    {  SetCard * card_1 = [cards objectAtIndex:i];
        for(int j = i+1;j<[cards count];j++)
        {
            SetCard * card_2 = [cards objectAtIndex:j];
            if(card_1.shade_of_shape == card_2.shade_of_shape)
                count_of_properties[0]++;
            if(card_1.number_of_shapes == card_2.number_of_shapes)
                count_of_properties[1]++;
            if([card_1.color isEqualToString:card_2.color])
                count_of_properties[2]++;
            if([card_1.shape  containsString:card_2.shape] || [card_2.shape containsString:card_1.shape])
                count_of_properties[3]++;
        }
    }
    for(int i =0;i<4;i++)
    {  //NSLog(@"count_of_properties[%d] = %d",i,count_of_properties[i]);
        if(count_of_properties[i] == 1)
            return 0;
    }
    matchScore =25;
    
    
    
    return matchScore;
}
@end
