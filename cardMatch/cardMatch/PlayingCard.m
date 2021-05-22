//
//  PlayingCard.m
//  matchismo
//
//  Created by Shaik A S on 20/08/18.
//  Copyright © 2018 SHAIK AS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlayingCard.h"
@implementation PlayingCard
- (NSString *) contents
{
    NSArray * possible_ranks = @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"K",@"Q"];
    return [possible_ranks[self.rank]  stringByAppendingString: self.suit] ;
    
}
@synthesize suit = _suit;
- (void) setSuit: (NSString *) suit
{
    if([@[@"♠︎",@"♣︎",@"♦︎",@"♥︎"] containsObject: suit])
        _suit = suit;
    
}
- (NSString*) suit
{
    return _suit ? _suit : @"?";
}
+ (NSArray *) valid_suits
{
    return @[@"♠︎",@"♣︎",@"♦︎",@"♥︎"];
}
+ (NSArray *) valid_ranks
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"K",@"Q"];
    
}
-(NSInteger) matched:(NSArray *)cards
{  NSInteger score =0;
    if([cards count] == 2) // for 2 card matching
    {
        PlayingCard * card_1 = cards[0];
        PlayingCard * card_2 = cards[1];
        
        {
            if(card_1.rank == card_2.rank)
                score = 4;
            if([card_1.suit isEqualToString:card_2.suit])
                score = 1;
            
            
        }
    }
    else
    {
        
        
        for(int i=0;i<[cards count] -1;i++)
        {
            PlayingCard * card_1 = [cards objectAtIndex:i];
            for(int j = i+1;j<[cards count];j++)
            {
                PlayingCard * card_2 = [cards objectAtIndex:j];
                if(card_1.rank == card_2.rank)
                {
                    if(score == 13) // score will be 13 if already 2 ranks matched....
                        score = 312;  // so this is 3 ranks matching case
                    
                    else if(score == 4) // score will be 4 if 2 suits matched priorly.
                        score = 26;     // so this is 2 ranks 2 suits matching case
                    
                    else if(!score)   // This is 2 ranks matching case.
                        score =13;
                    
                }
                if([card_1.suit isEqualToString:card_2.suit])
                {
                    if(score == 4)  // score will be 4 if already 2 suits matched....
                        score = 14;  // so this is 3 suits matching case
                    
                    else if(score == 13)  // score will be 13 if 2 ranks matched priorly.
                        score = 26;     // so this is 2 ranks 2 suits matching case
                    
                    else if(!score)  // This is 2 suits matching case.
                        score = 4;
                }
                
            }
            
            
            
            
        }
    }
    return score;
}

@end

