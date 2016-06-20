//
//  FISCardDeck.h
//  OOP-Cards-Model
//
//  Created by Lloyd W. Sykes on 6/16/16.
//  Copyright © 2016 Al Tyus. All rights reserved.
//

#import "FISCard.h"

@interface FISCardDeck : NSObject
// I initially inherited FISCard even though the instructions didn't ask to do that. The way to think about it is a CardDeck isn't apart of a Card, if anything it would be the other way around however that's not how this lab was structured.


@property (strong, nonatomic) NSMutableArray *remainingCards;
@property (strong, nonatomic) NSMutableArray *dealtCards;

- (instancetype)init;
- (FISCard *)drawNextCard;
- (void)resetDeck;
- (void)gatherDealtCards;
- (void)shuffleRemainingCards;

@end
