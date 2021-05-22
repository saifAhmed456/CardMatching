//
//  SetCardViewController.m
//  cardMatch
//
//  Created by Shaik A S on 03/09/18.
//  Copyright © 2018 SHAIK AS. All rights reserved.
//
#import "ShowSetsViewController.h"
#import "SetCardViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"
@interface SetCardViewController ()
//@property (strong,nonatomic) NSMutableAttributedString *history_of_game;
@property (strong, nonatomic) IBOutletCollection(SetCardView) NSArray *setViewArray;
@end
@implementation SetCardViewController
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"ShowSetsSegue"] )
    {
        if([segue.destinationViewController  isKindOfClass : [ShowSetsViewController class]])
        {
            ShowSetsViewController * ssvc = segue.destinationViewController;
            ssvc.unmatched_cards = [self getUnmatchedCards];
        }
    }
} 
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.mode = 1;
    self.isSetShown = NO;
}
-(void)setmode
{
    self.mode = 1;
}
-(Deck *) createDeck
{
    return [[SetCardDeck alloc]init];
}

-(void) setContentsOfCard : (Card *)card ToView : (CardView*)card_view
{
    SetCardView * set_view = (SetCardView *) card_view;
    SetCard * set_card =(SetCard *)card;
    set_view.shape = set_card.shape;
    set_view.shade = set_card.shade_of_shape;
    set_view.count_of_shapes =set_card.number_of_shapes;
    set_view.color =  set_card.color;
   // NSLog(@"shape = %@, count = %ld shade = %f color = %@",set_card.shape,(long)set_card.number_of_shapes,set_card.shade_of_shape,set_card.color );
}
-(CardView *)createView : (CGRect) bounds_of_view
{  //NSLog(@"I am in set card view....x = %f,  y = %f, width = %f  , height = %f", bounds_of_view.origin.x,bounds_of_view.origin.y,bounds_of_view.size.width,bounds_of_view.size.height);
    return [[SetCardView alloc] initWithFrame:bounds_of_view];
}
-(NSArray *) getUnmatchedCards
{
    NSMutableArray * unmatchedCards = [[NSMutableArray alloc]init];
    for(int i = 0;i< [self.custom_card_views count]; i++)
    {
        SetCard * set_card = (SetCard *)[self.game cardAtIndex:i];
        if(set_card.isMatched!= YES)
            [unmatchedCards addObject:set_card];
    }
    
    return unmatchedCards;
}
- (IBAction)AddCardsToUIView:(UIBarButtonItem *)sender {
   BOOL result = [self.game addExtraCardsToGame];
    if(!result)
        return;
if(self.game.countOfUnmatchedCards<= [self.custom_card_views count])
{  int count_of_hidden_views =0;
    for(CardView * card_view in self.custom_card_views)
    {
        if(card_view.hidden && count_of_hidden_views<3)
        {
            NSUInteger index = [self.custom_card_views indexOfObject:card_view];
            Card * card = [self.game cardAtIndex:index];
            [self setContentsOfCard:card ToView:card_view];
            card_view.hidden = card_view.faceUp = NO;
            count_of_hidden_views++;
            [UIView animateWithDuration:2.0 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{card_view.alpha =1.0;} completion:nil];
        }
    }
}
    else
    {
        for(CardView * card_view in self.custom_card_views)
        {
            [card_view removeFromSuperview];
        }
        [self.custom_card_views removeAllObjects];
        self.count_of_cards = self.game.countOfUnmatchedCards;
        [self setUp];
    }
    
}

@end

