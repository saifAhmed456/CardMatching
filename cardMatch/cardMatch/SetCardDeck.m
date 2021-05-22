//
//  SetCardDeck.m
//  cardMatch
//
//  Created by Shaik A S on 03/09/18.
//  Copyright © 2018 SHAIK AS. All rights reserved.
//

#import "SetCardDeck.h"
#import"SetCard.h"
@implementation SetCardDeck
-(instancetype)init
{ 
    self = [super init];
    if(self)
    {
        for(NSNumber * i in [SetCard validNumbers] )
        {
            for(NSNumber * shade in [SetCard validShades])
            {
                for(NSString * color in [SetCard validColors])
                {
                    for(NSString * shape in [SetCard validShapes])
                    {
                        SetCard * card = [[SetCard alloc] init];
                        [card initializeWithNumber:[i integerValue] withColor:color withShade:([shade integerValue]/10.0f) withShape:shape];
                        [self addCard:card];
                        // NSLog(@"contents : %@ , count : %d",card.contents,count);
                        
                        
                    }
                }
            }
        }
    }
    return self;
}

@end
