//
//  Card.m
//  matchismo
//
//  Created by Shaik A S on 20/08/18.
//  Copyright © 2018 SHAIK AS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
@interface Card()
@end
@implementation Card
- (NSInteger) matched : (NSArray *) cards
{ NSLog(@"I am in matched of card");
    NSInteger score = 0;
    for (Card * card in cards)
    {
        
        if([self.contents isEqualToString: card.contents])
            score +=1;
    }
    return score;
}
-(NSString *) contents
{
    _contents = @"card_description";
    return _contents;
}
-(NSString *) description
{
    return self.contents;
}
@end

