//
//  SetCardView.h
//  cardMatch
//
//  Created by Shaik A S on 14/09/18.
//  Copyright © 2018 SHAIK AS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardView.h"
@interface SetCardView : CardView
@property (strong,nonatomic) NSString * shape;
@property(nonatomic) NSInteger count_of_shapes;
@property(strong,nonatomic) NSString * color;
@property(nonatomic) CGFloat shade;
@end
