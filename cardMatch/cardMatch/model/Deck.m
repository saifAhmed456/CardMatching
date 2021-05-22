
//
//  Deck.m
//  matchismo
//
//  Created by Shaik A S on 20/08/18.
//  Copyright © 2018 SHAIK AS. All rights reserved.

#import "Deck.h"
@interface Deck()
@property  (strong,nonatomic) NSMutableArray * deck_of_cards;
@end

@implementation  Deck

- (NSMutableArray*) deck_of_cards
{
    if( !(_deck_of_cards))
        _deck_of_cards = [[NSMutableArray alloc] init];
    return _deck_of_cards;
}

-(void) addCard: (Card *)card  atTop:(BOOL) atTop
{
    if(atTop)
        [self.deck_of_cards insertObject: (card) atIndex:(0)];
    else
        [self.deck_of_cards addObject:(card)];
    
}
-(void) addCard : (Card *) card
{
    [self addCard : card  atTop :NO];
    
}
-(Card *)drawRandomCard
{
    Card * RandomCard = nil;
    if([self.deck_of_cards count])
    {
        unsigned int index = arc4random() % [self.deck_of_cards count ] ;
        RandomCard =  [self.deck_of_cards objectAtIndex:index];
        [self.deck_of_cards removeObjectAtIndex: index] ;
       // NSLog(@"%@",RandomCard.contents);
    }
    return RandomCard;
}

@end
