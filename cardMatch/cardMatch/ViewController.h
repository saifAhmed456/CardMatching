//
//  ViewController.h
//  cardMatch
//
//  Created by Shaik A S on 23/08/18.
//  Copyright © 2018 SHAIK AS. All rights reserved.
//ABSTRACT CLASS

#import <UIKit/UIKit.h>
#import"Deck.h"
#import"PlayingCard.h"
#import"PlayingDeck.h"
#import "PlayingCardView.h"
#import"CardView.h"
#import"SetCard.h"
#import "cardMatchingGame.h"
@interface ViewController : UIViewController

-(Deck*) createDeck;
@property(nonatomic) CGFloat width_of_card_view;
@property(nonatomic)CGFloat height_of_card_view;
@property(nonatomic)NSUInteger count_of_cards;
@property(nonatomic) NSInteger mode ;
@property(nonatomic) BOOL isSetShown;
@property(strong,nonatomic) cardMatchingGame * game;
-(void) updateUI;
-(void) updateUIForStoryBoard;
-(void) setUp;
@property (strong,nonatomic) Deck* deck;
-(CardView *)createView : (CGRect) bounds_of_view;
@property (weak, nonatomic) IBOutlet UILabel *ScoreLabel;
-(void) gameOverUI;
@property (strong, nonatomic) IBOutletCollection(CardView) NSArray *array_of_views;
@property(strong,nonatomic) NSMutableArray * custom_card_views;
@end

