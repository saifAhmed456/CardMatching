//
//  PlayingCardViewController.m
//  cardMatch
//
//  Created by Shaik A S on 03/09/18.
//  Copyright © 2018 SHAIK AS. All rights reserved.
//

#import "PlayingCardViewController.h"
#import"PlayingDeck.h"
#import "HIstory_ViewController.h"
#import "PlayingCardView.h"

@interface PlayingCardViewController ()
@end

@implementation PlayingCardViewController


-(void) setContentsOfCard : (Card *)card ToView : (CardView*)card_view
{
    PlayingCardView * p_view = (PlayingCardView *) card_view;
    PlayingCard * playing_card =(PlayingCard *)card;
    p_view.rank = playing_card.rank;
    p_view.suit = playing_card.suit;
}

-(CardView *)createView : (CGRect) bounds_of_view
{
    return [[PlayingCardView alloc] initWithFrame:bounds_of_view];
}


-(Deck *) createDeck
{ 
    return [[PlayingDeck alloc]init];
}
-(void)setmode
{
    self.mode = 0;
}

@end
