//
//  cardMatchingGame.m
//  matchismo
//
//  Created by Shaik A S on 23/08/18.
//  Copyright © 2018 SHAIK AS. All rights reserved.
//

#import "cardMatchingGame.h"
@interface cardMatchingGame ()
@property  (strong,nonatomic) NSMutableArray * cards;
@property(strong,nonatomic) Card * SampleCard;
@property (nonatomic,readwrite) NSInteger score;
@property  (strong,nonatomic) NSMutableArray * card_array;
@property(strong,nonatomic)Deck * DeckOfCards;
@end
@implementation cardMatchingGame
-(BOOL) isGameOverFromDeck // adds all the unmatched cards to an array and calls matched method
{                          // game is over when there are  (0 or 1 card)  or  (2 or 3 or 4 cards in the array and also matched method returns 0 (i.e they can't be matched) )
    NSMutableArray * last_cards = [[NSMutableArray alloc] init];
    for(Card * card in self.cards)
    {   if(!card.isMatched )
        [last_cards addObject:card];
        
    }
    int count = (int)[last_cards count];
    
    return ( ((count== 3 || count==2 || count == 4)   &&  ![self.SampleCard matched : last_cards ] )  || count ==0 || count==1) ;
    
}
-(NSMutableArray *) card_array
{
    if(!_card_array)
        _card_array = [[NSMutableArray alloc] init];
    return _card_array;
}
- (NSMutableArray *) cards
{
    if(!_cards)
        _cards = [[NSMutableArray alloc] init];
    return _cards;
}
-(instancetype) initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    if(self = [super init])
    {     self.countOfUnmatchedCards = count;
        self.DeckOfCards = deck;
        for(int i =0;i<count;i++)
        {
            
            Card * randomCard = nil;
            randomCard = [deck drawRandomCard];
            
            if(randomCard)
                
                [self.cards insertObject:randomCard atIndex:0] ;
            
            else
            {
                self = nil;
                break;
            }
        }
    }
    self.SampleCard = [deck drawRandomCard];
    
    return self;
}
-(Card*) cardAtIndex:(NSUInteger)index
{
    return index<[self.cards count] ?[self.cards objectAtIndex:index] : nil;
}


static const int TOUCH_PENALTY = 0;
static const int MISMATCH = -2;
static const int BONUS = 4;


-(long) chooseCardAtIndex:(NSUInteger)index matchMode : (NSInteger) mode // ensures that only chosen cards are present in the array(card_array)
{                                                                        // if the count reaches mode(number of cards to match) it calls matched method.
    NSInteger matchscore =0;
    Card * card = [self cardAtIndex : index];
    if(!card.isMatched && !card.isChosen)
    {
        self.score -= TOUCH_PENALTY;
        for(Card * othercard in self.cards)
        {
            if(!othercard.isMatched && othercard.isChosen)
            {
                if(![self.card_array containsObject:othercard])
                    [self.card_array addObject:othercard];
                if([self.card_array count] == (mode +1 ))
                {
                    [self.card_array addObject:card];
                    matchscore = [card matched : self.card_array];
                    [self.card_array removeLastObject];
                    self.score += matchscore ? matchscore *BONUS : MISMATCH;
                    for(Card * card_obj in self.card_array)
                    {  card_obj.matched =  card.matched = matchscore;
                        card_obj.chosen = [self.card_array indexOfObject:card_obj] || matchscore;
                        
                    }
                    if(matchscore) {
                        self.countOfUnmatchedCards -=mode + 2;
                        [self.card_array removeAllObjects];
                        
                    }
                        else
                        [self.card_array removeObjectAtIndex:0];
                    
                }
                
            }
            
        }
        card.chosen = YES;
    }
    else if(card.isChosen)
    {   if([self.card_array containsObject:card])
        [self.card_array removeObject:card];
        card.chosen = NO;
        
    }
   
    return matchscore;
}
-(BOOL) addExtraCardsToGame 
{ int newCardCount = 0;
    if(self.countOfUnmatchedCards == [self.cards count])
    {
        for(;newCardCount<3;newCardCount++)
        {
            Card * card  = [self.DeckOfCards drawRandomCard];
            if(card)
            [self.cards addObject:card];
            else
                return 0;
            
        }
        
        
    }
    else
    {
    for(int i = 0; (newCardCount<3);i++)
    {   Card * card = [self.cards objectAtIndex:i];
          if(card.isMatched)
          {    Card * newcard = [self.DeckOfCards drawRandomCard];
              newCardCount++;
              if(!newcard)
                  return 0;
              
              if([self.cards lastObject] == card)
              {
                  [self.cards removeLastObject];
                  [self.cards addObject:newcard];
              }
              else
              {
                  [self.cards removeObjectAtIndex:i];
                  [self.cards insertObject:newcard atIndex:i];
              }
          }
        
    }
    
    }
    return self.countOfUnmatchedCards+=newCardCount;
}

@end

