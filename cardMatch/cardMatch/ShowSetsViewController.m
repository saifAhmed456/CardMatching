//
//  ShowSetsViewController.m
//  cardMatch
//
//  Created by Shaik A S on 06/09/18.
//  Copyright © 2018 SHAIK AS. All rights reserved.
//

#import "ShowSetsViewController.h"
#import "SetCard.h"
#import "SetCardView.h"
@interface ShowSetsViewController ()
-(void)find_matched_sets: (int) index  :(NSMutableArray*) temp_array  :(int) temp_index  : (int)mode;
@property (weak, nonatomic) IBOutlet UIScrollView *BoundaryView;
@property(strong,nonatomic) NSMutableArray * FormedSetsArray;

@property(nonatomic) NSInteger countOfCards;
//-(UIColor *) getColor : (NSString *) color alphaComponent : (CGFloat) shade;
@end

@implementation ShowSetsViewController
-(NSMutableArray *) FormedSetsArray
{
    if(!_FormedSetsArray)
        _FormedSetsArray = [[NSMutableArray alloc] init];
    return _FormedSetsArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.BoundaryView.contentSize = CGSizeMake(300, 2000);
}
-(void)viewWillAppear:(BOOL)animated
{  [super viewWillAppear:YES];
    NSMutableArray* temp_array = [[NSMutableArray alloc]init];
    [self find_matched_sets:  0  :temp_array  :  0  : 3 ];
}
-(void)find_matched_sets: (int) index  :(NSMutableArray *) temp_array :(int) temp_index  : (int)mode
{
    if([temp_array count] == mode)
    {
        SetCard * temp_card = [[SetCard alloc]init];
        if([temp_card matched : temp_array])
        {  NSLog(@"I have found a solution");
            for(long i = 0;i<3;i++)
            {     CGRect rect = CGRectMake(i * 90, (self.countOfCards /3)* 115, 75, 100) ;
                SetCardView * card_view = [[SetCardView alloc] initWithFrame:rect];
                SetCard* set_card = (SetCard*) temp_array[i];
                [self setContentsOfCard:set_card ToView:card_view];
                [self.BoundaryView addSubview:card_view];
                
            }
            self.countOfCards +=3;
        }
        return;
    }
    if([self.unmatched_cards count] == index)
        return;
    [self find_matched_sets:  index+1  :temp_array  :  temp_index  : mode ];
    [temp_array addObject: [self.unmatched_cards objectAtIndex:index]];
    [self find_matched_sets:  index+1  :temp_array  :  temp_index+1  : mode];
    [temp_array removeObject:[self.unmatched_cards objectAtIndex:index]];
}
-(void) setContentsOfCard : (SetCard *)set_card ToView : (SetCardView*)set_view
{
    
    set_view.shape = set_card.shape;
    set_view.shade = set_card.shade_of_shape;
    set_view.count_of_shapes = set_card.number_of_shapes;
    set_view.color = set_card.color;
   
}
@end
