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
#import"SetCard.h"
#import "HIstory_ViewController.h"
@interface SetCardViewController ()
@property (weak, nonatomic) IBOutlet UILabel *display_status_label;
//@property (strong,nonatomic) NSMutableAttributedString *history_of_game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *set_card_buttons;
-(UIColor *) getColor : (NSString *) color alphaComponent : (CGFloat) shade;
-(NSArray*) getUnmatchedCardsArray;

@end
@implementation SetCardViewController

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"history_of_setCard"])
    {
        if([segue.destinationViewController isKindOfClass: [HIstory_ViewController class]])
        {
            HIstory_ViewController * hvc = (HIstory_ViewController *)segue.destinationViewController;
            hvc.attributed_string_to_display_history =(NSMutableAttributedString*) [self.history_of_game mutableCopy];
        }
    }
    if([segue.identifier isEqualToString:@"ShowSetsSegue"])
    {
        if([segue.destinationViewController isKindOfClass: [ShowSetsViewController class]])
        {  ShowSetsViewController * ssvc = (ShowSetsViewController *)segue.destinationViewController;
            ssvc.unmatched_cards = [self getUnmatchedCardsArray];
        }
    }
    }

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.mode = 1;
    self.isSetShown = NO;
}
-(Deck *) createDeck
{ 
    return [[SetCardDeck alloc]init];
}
-(void)setTitleForCardButton : (UIButton *) cardButton ForCard : (Card *)card
{
    SetCard* set_card = (SetCard*)card;
    NSAttributedString * attributed_string_of_setCard = [[NSAttributedString alloc]initWithString:set_card.shape attributes:@{NSForegroundColorAttributeName : [self getColor:set_card.color alphaComponent:set_card.shade_of_shape]} ];
    [cardButton setAttributedTitle:attributed_string_of_setCard forState:UIControlStateNormal];
    
    
}
-(void)setBackGroundImageForCardButton : (UIButton *) cardButton ForCard : (Card *)card
{ if(card.isMatched) {
    [cardButton setBackgroundImage:[UIImage imageNamed:@"lavenderImage"] forState:UIControlStateNormal];
    
    return;
}
    if(card.isChosen)
    {    [cardButton setBackgroundImage:[UIImage imageNamed:@"LightBlueImage"] forState:UIControlStateNormal];
        
        return;
    }
    [cardButton setBackgroundImage:[UIImage imageNamed:@"cardfront"] forState:UIControlStateNormal];
}
-(void)setImageAndTitleAfterGameOverForCardButton : (UIButton *) cardButton ForCard : (Card *)card
{
    SetCard* set_card = (SetCard*)card;
    if(!card.isMatched)
    {
        [cardButton setBackgroundImage:[UIImage imageNamed:@"cardfront"] forState: UIControlStateNormal];
        NSAttributedString * attributed_string_of_setCard = [[NSAttributedString alloc]initWithString:set_card.shape attributes:@{NSForegroundColorAttributeName : [self getColor:set_card.color alphaComponent:set_card.shade_of_shape]} ];
        [cardButton setAttributedTitle:attributed_string_of_setCard forState:UIControlStateNormal];
        
    }
    else
    {    NSAttributedString * game_over_string = [[NSAttributedString alloc] initWithString:@"Over"];
        [cardButton setBackgroundImage:[UIImage imageNamed:@"cardfront"] forState: UIControlStateNormal];
        [cardButton setAttributedTitle:game_over_string forState:UIControlStateNormal];
    }
}
-(UIColor *) getColor : (NSString *) color alphaComponent : (CGFloat) shade
{
    if([color isEqualToString:@"green"])
        return [[UIColor greenColor] colorWithAlphaComponent:shade];
    if([color isEqualToString:@"red"])
        return [[UIColor redColor] colorWithAlphaComponent:shade];
    if([color isEqualToString:@"purple"])
        return [[UIColor purpleColor] colorWithAlphaComponent:shade];
    return [UIColor blackColor];
}
-(NSInteger)display_chosen_cards_match_result : (NSArray *)chosen_card_array
{
    NSMutableAttributedString * attributed_contents_of_all_cards = [[NSMutableAttributedString alloc] init];
    for(SetCard * set_card in chosen_card_array)
    {  NSAttributedString * attributed_string_of_one_Card = [[NSAttributedString alloc]initWithString:set_card.shape attributes:@{NSForegroundColorAttributeName : [self getColor:set_card.color alphaComponent:set_card.shade_of_shape]} ];
        [attributed_contents_of_all_cards appendAttributedString:attributed_string_of_one_Card];
    }
    SetCard * temp_set_card = [[SetCard alloc]init];
    NSInteger score = [temp_set_card matched:chosen_card_array];
    if([chosen_card_array count ]>1)
    {
        if(score)
            [attributed_contents_of_all_cards appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" cards matched points : %ld\n",score * 4]]];
        
        else
            [attributed_contents_of_all_cards appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"cards  did not match  points : -2\n"]]];
        
        [self.history_of_game appendAttributedString:attributed_contents_of_all_cards];
    }
    [self.display_status_label setAttributedText:attributed_contents_of_all_cards];
    //NSLog(@"history : %@",[_history_of_game string]);
    return score;
}
- (IBAction)showSets:(UIBarButtonItem *)sender {
    NSLog(@"I am in showSets method");
        self.isSetShown = YES;
       
    
        }
-(NSArray*) getUnmatchedCardsArray
{
    NSMutableArray * unmatchedCards = [[NSMutableArray alloc]init];
    for(UIButton* cardButton in self.set_card_buttons)
    {     NSUInteger index = [self.set_card_buttons indexOfObject:cardButton];
        Card* card = [self.game cardAtIndex:index];
        if(card.isMatched == NO)
            [unmatchedCards addObject:card];
    }
    return unmatchedCards;
}

@end
