//
//  SetCard.h
//  cardMatch
//
//  Created by Shaik A S on 03/09/18.
//  Copyright © 2018 SHAIK AS. All rights reserved.
//

#import "Card.h"
#import <UIKit/UIKit.h>

@interface SetCard : Card
@property (strong,nonatomic) NSString * shape ;
@property(nonatomic)NSInteger number_of_shapes;
@property(nonatomic) CGFloat shade_of_shape;
@property(strong,nonatomic)NSString * color;
-(void) initializeWithNumber : (NSInteger) number withColor : (NSString *)color withShade : (CGFloat) shade withShape : (NSString *) shape;
+ (NSArray *) validShapes;
+(NSArray *)validShades;
+(NSArray *)validNumbers;
+(NSArray *)validColors;
@end
