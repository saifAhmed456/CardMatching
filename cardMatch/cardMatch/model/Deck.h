///
//  Deck.h
//  matchismo
//
//  Created by Shaik A S on 20/08/18.
//  Copyright © 2018 SHAIK AS. All rights reserved.
//

#ifndef Deck_h
#define Deck_h


#endif /* Deck_h */
#import<Foundation/Foundation.h>
#import"Card.h"
@interface Deck : NSObject
- (void) addCard : (Card *) card atTop: (BOOL) atTop;
-(void) addCard : (Card *) card;
-(Card *) drawRandomCard;
@end




