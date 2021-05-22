//
//  PlayingCardView.h
//  cardMatch
//
//  Created by Shaik A S on 12/09/18.
//  Copyright © 2018 SHAIK AS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardView.h"
@interface PlayingCardView : CardView
@property(nonatomic) NSInteger rank;
@property(strong,nonatomic) NSString * suit;
@end
