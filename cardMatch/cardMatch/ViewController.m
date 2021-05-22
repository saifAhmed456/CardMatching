//
//  ViewController.m
//  matchismo
//
//  Created by Shaik A S on 20/08/18.
//  Copyright © 2018 SHAIK AS. All rights reserved.
//ABSTRACT CLASS

#import "ViewController.h"
#import"HIstory_ViewController.h"
#import <UIKit/UIKit.h>
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *BoundaryView;
@property (strong,nonatomic) NSMutableArray * currentChosenCards;
@property(strong,nonatomic) UIDynamicAnimator * animator;
@property(strong,nonatomic) UISnapBehavior * snap;
@property (nonatomic)UIDeviceOrientation CurrentOrientation ;

@end

@implementation ViewController
-(void) viewDidLoad
{
    [super viewDidLoad];
    self.count_of_cards = 12;
    self.CurrentOrientation = UIDeviceOrientationPortrait;
   self.BoundaryView.backgroundColor = nil;
    [self setmode];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(OrientationChanged:)
                                                 name:UIApplicationDidChangeStatusBarOrientationNotification
                                               object:nil];
    // [self setUpForStoryBoard];
    // NSLog(@"I am in view controller");
    
}
-(CGFloat) width_of_card_view
{
    _width_of_card_view = sqrt( ( 2* self.BoundaryView.bounds.size.width * self.BoundaryView.bounds.size.height * 0.75) /  ( 3 *self.count_of_cards));
    return _width_of_card_view;
}
-(CGFloat)height_of_card_view
{
    _height_of_card_view = 1.5 * self.width_of_card_view;
    return _height_of_card_view;
}
-(void)setmode
{
    
}
- (IBAction)moveCardsToCentre:(UITapGestureRecognizer *)sender {
    CGPoint snapPoint = CGPointMake(self.BoundaryView.center.x - self.width_of_card_view/2, self.BoundaryView.center.y - self.height_of_card_view/2);
    
    for(CardView * card_view in self.custom_card_views)
    {
        self.snap = [[UISnapBehavior alloc] initWithItem:card_view snapToPoint:snapPoint];
        self.snap.damping = 5.0;
        [self.animator addBehavior:self.snap];
    }
    
}
-(UIDynamicAnimator *) animator
{
    if(!_animator)
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.BoundaryView];
    return _animator;
}
-(CardView *)createView : (CGRect) bounds_of_view
{
    return nil;
}
-(void) setContentsOfCard : (Card *)card ToView : (CardView*)card_view
{
    
}
-(NSMutableArray *)currentChosenCards
{
    if(!_currentChosenCards)
        _currentChosenCards = [[NSMutableArray alloc]init];
    return _currentChosenCards;
}
-(NSUInteger)count_of_cards
{
    
    return _count_of_cards;
}
-(void) setUp
{    //NSLog(@"count of custom card views in setup = %ld",[self.custom_card_views count]);
    CGFloat extraSpacing = 0.0;
    CGFloat i =0, j = 0;
    CardView * card_view;
    
    //CGPoint startingPoint = CGPointMake(self.BoundaryView.center.x - (self.width_of_card_view * 6.0)/(14.0), self.BoundaryView.center.y - (self.height_of_card_view * 6.0)/(14.0) );
    
    if(  ((int) (self.BoundaryView.bounds.size.width/ self.width_of_card_view)  )  > 1)
        extraSpacing =  (self.BoundaryView.bounds.size.width - (  ( (int) (self.BoundaryView.bounds.size.width/ self.width_of_card_view)  ) * self.width_of_card_view) ) /  ((int) (self.BoundaryView.bounds.size.width/ self.width_of_card_view) - 1);
   // NSLog(@"width = %f  height = %f ,extra spacing = %f",self.BoundaryView.bounds.size.width ,self.BoundaryView.bounds.size.height,extraSpacing);
    
    //NSLog(@"card width = %f card height = %f",self.width_of_card_view,self.height_of_card_view);
    for(int k = 1;k<=self.count_of_cards;k++)
    {   // NSLog(@" %d)x = %f  y = %f",k,self.width_of_card_view *i,self.height_of_card_view *j);
        CGPoint finalPoint =  CGPointMake(i*(self.width_of_card_view + extraSpacing), j*(self.height_of_card_view));
        CGFloat x = arc4random() %  (int)self.view.bounds.size.width *3;
        CGFloat y = arc4random() %  (int)self.view.bounds.size.height * 3;
       // NSLog(@"final point.x = %f, finalpoint.y = %f ,x = %f, y =%f",finalPoint.x,finalPoint.y,x,y);
        if(  [self.custom_card_views count] == self.count_of_cards)
        {
             card_view =  [self.custom_card_views objectAtIndex:k-1];
            //[UIView animateWithDuration:2.0 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{[card_view setFrame:(CGRectMake(finalPoint.x, finalPoint.y, self.width_of_card_view *(6.0/7), self.height_of_card_view * (6.0/7)))]; } completion:nil];
            
            Card * card =   [self.game cardAtIndex:k-1];
            card_view.hidden = card.isMatched;
            
        }
        else   {
            
         card_view = [self createView : (CGRectMake(x,y, self.width_of_card_view *(6.0/7), self.height_of_card_view * (6.0/7)))];
        
        UITapGestureRecognizer * flip_card = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap_card:) ];
        [card_view addGestureRecognizer : flip_card];
        [self.custom_card_views addObject:card_view];
        [self.BoundaryView addSubview:card_view];
        // card_view.backgroundColor = [UIColor blueColor];
        [self setContentsOfCard : [self.game cardAtIndex:k-1] ToView : card_view];
           card_view.alpha = 0.0;
          
           
            
        }
       
         [UIView animateWithDuration:2.0 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{[card_view setFrame:(CGRectMake(finalPoint.x, finalPoint.y, self.width_of_card_view *(6.0/7), self.height_of_card_view * (6.0/7)))]; card_view.alpha = 1.0; } completion:nil];
        if( k % (int)(self.BoundaryView.bounds.size.width/self.width_of_card_view)  == 0 )
        {
            i = 0;
            j++;
        }
        else
            i++;
    }
    
    
}
-(void) OrientationChanged : (NSNotification *) notification
{
    NSLog(@"I am  in orientation Method");
    for(CardView * card_view in self.custom_card_views)
        [card_view removeFromSuperview];
    self.custom_card_views = nil;
    [self setUp];
}

-(void) viewDidLayoutSubviews
{   [super viewDidLayoutSubviews];
    //NSLog(@"didLayout");
    //NSLog(@"width = %f  height = %f ",self.BoundaryView.bounds.size.width ,self.BoundaryView.bounds.size.height);
     if( self.CurrentOrientation != [[UIDevice currentDevice] orientation])
    {    self.CurrentOrientation = [[UIDevice currentDevice] orientation];
       // for(CardView * card_view in self.custom_card_views)
          //  [card_view removeFromSuperview];
        [self setUp];
    }
    
}

-(void) setUpForStoryBoard
{
    for(CardView * card_view in self.array_of_views)
    {
        NSUInteger index = [self.array_of_views indexOfObject:card_view];
        Card * card = [self.game cardAtIndex:index];
        [self setContentsOfCard:card ToView:card_view];
    }
}
-(void) tap_card : (UITapGestureRecognizer *) recogniser
{  //NSLog(@"I am in tap card");
    CardView * card_view = (CardView *)recogniser.view;
    
    NSUInteger index = [self.custom_card_views indexOfObject:card_view];
    [self.game chooseCardAtIndex:index matchMode:self.mode];
    [self manageChosenCardArray:card_view];
    if(card_view.faceUp)
        [UIView transitionWithView:card_view duration:1.5 options:UIViewAnimationOptionTransitionFlipFromLeft animations:nil completion:nil];
    [self.ScoreLabel setText: [NSString stringWithFormat:@"SCORE : %ld",self.game.score]];
    
    NSLog(@"score label width = %f label height = %f, x = %f, y =%f",self.ScoreLabel.bounds.size.width,self.ScoreLabel.bounds.size.height,self.ScoreLabel.frame.origin.x,self.ScoreLabel.frame.origin.y);
}
-(void) manageChosenCardArray : (CardView*) card_view
{
    if( [self.currentChosenCards containsObject:card_view] == NO)
    {
        
        [self.currentChosenCards addObject:card_view];
    }
    for(int i=0;i<[self.currentChosenCards count];i++)
    {
        CardView * view_itr = [self.currentChosenCards objectAtIndex:i];
        NSUInteger index = [self.custom_card_views indexOfObject:view_itr];
        Card *  card1 =[self.game cardAtIndex:index];
        view_itr.faceUp = card1.isChosen;
       // for(int k=0;k<100000;k++)
           // NSLog(@".......");
        
        
        if((view_itr.faceUp ==NO) )
        {  i--;
            [UIView transitionWithView:view_itr duration:1.5 options:UIViewAnimationOptionTransitionFlipFromRight animations:nil completion:nil];
            
            [self.currentChosenCards removeObject:view_itr];
        }
        
        if(card1.isMatched)
        {
            [UIView animateWithDuration:2.0 delay:1.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{view_itr.alpha = 0.0;} completion: ^(BOOL success){ if(success)view_itr.hidden = 1;}];
            [self.currentChosenCards removeObject:view_itr];
            i--;
        }
        //  NSLog(@"index=%ld faceUP= %d i = %d, count = %d", index,view_itr.faceUp,i,[self.currentChosenCards count] );
    }
    
}


-(NSMutableArray *) custom_card_views
{
    if(!_custom_card_views)
        _custom_card_views = [[NSMutableArray alloc] init];
    return _custom_card_views;
}
-(Deck *) createDeck
{
    return nil;
}

- (Deck*) deck
{
    if(!_deck)
        _deck =[self createDeck];
    return _deck;
}
- (cardMatchingGame *) game
{
    if(! (_game))
        _game =  [[cardMatchingGame alloc] initWithCardCount:self.count_of_cards usingDeck: self.deck ];
    return _game;
}

-(void) viewDidAppear:(BOOL)animated

{
    [super viewDidAppear:YES];
    self.view.hidden = NO;
    //self.PlayingCardView.hidden = YES;
    [self setUp];
    
}


- (IBAction)RestartGame:(id)sender {
    [self.ScoreLabel setText:@"SCORE : 0"];
    self.game = nil;
    self.deck = nil;
    self.isSetShown = NO;
    for(CardView * card_view in self.custom_card_views)
        [card_view removeFromSuperview];
    self.custom_card_views = nil;
    for(CardView * card_view in self.currentChosenCards)
        [card_view removeFromSuperview];
    self.currentChosenCards = nil;
    [self setUp];
    [self updateUI];
    
}
- (IBAction)tapCard:(UITapGestureRecognizer *)sender {
    CardView * card_view = (CardView *)sender.view;
    NSUInteger index = [self.array_of_views indexOfObject:card_view];
    [self.game chooseCardAtIndex:index matchMode:self.mode];
    // [self updateUI];
    [self updateUIForStoryBoard];
}


-(void) updateUI
{
    for(CardView *card_view in self.custom_card_views )
    {
        NSUInteger index = [self.custom_card_views indexOfObject:card_view];
        Card *  card1 =[self.game cardAtIndex:index];
        card_view.faceUp = card1.isChosen;
        card_view.hidden = card1.isMatched ;
        
        
    }
    // [self.ScoreLabel setText: [NSString stringWithFormat: @"SCORE : %ld",(long)self.game.score]];
    
}
-(void) updateUIForStoryBoard
{  for(CardView * card_view in self.array_of_views)
{
    NSUInteger index = [self.array_of_views indexOfObject:card_view];
    Card *  card1 =[self.game cardAtIndex:index];
    card_view.faceUp = card1.isChosen;
    card_view.hidden = card1.isMatched;
}
    
}
-(void) gameOverUI
{
    //  for(UIButton * cardButton in self.cardButtons)
    {  // NSUInteger index = [self.cardButtons indexOfObject:cardButton];
        // Card * card = [self.game cardAtIndex:index];
        // [cardButton setEnabled:NO];
    }
    [self.ScoreLabel setText:@""];
    
    
}


@end

