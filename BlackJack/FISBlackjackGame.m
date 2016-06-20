//
//  FISBlackjackGame.m
//  BlackJack
//
//  Created by Lloyd W. Sykes on 6/17/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

#import "FISBlackjackGame.h"

@interface FISBlackjackGame ()

@end

@implementation FISBlackjackGame

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        
        _deck = [FISCardDeck new];
        _house = [[FISBlackjackPlayer alloc] initWithName:@"House"];
        _player = [[FISBlackjackPlayer alloc] initWithName:@"Player"];
    
    }
    
    return self;
    
}

- (void)playBlackjack {
    
    [self.deck resetDeck];
    [self.house resetForNewGame];
    [self.player resetForNewGame];
    [self dealNewRound];
    
    for (NSUInteger i = 0; i < 3; i++) {
        
        [self processPlayerTurn];
        if (self.player.busted == YES) {
            
            break;
            
        }
        
        
        [self processHouseTurn];
        if (self.house.busted == YES) {
            
            break;
            
        }
        
    }
    
        [self incrementWinsAndLossesForHouseWins:[self houseWins]];
    
    NSLog(@"\n\n\n\n\nPlay BlackJack!\n\n\n\n\n%@\n\n\n\n\n", self.player.description);
    NSLog(@"\n\n\n\n\n\n\nPlay BlackJack!\n\n\n\n\n\n%@\n\n\n\n\n\n", self.house.description);
    
}

- (void)dealNewRound {
 
    [self.deck resetDeck];
    
    FISCard *card = [[FISCard alloc] initWithSuit:card.suit rank:card.rank];
    
    [self.deck drawNextCard];
    [self.player acceptCard:card];
    // Important to note that the drawNextCard method was required to be called prior to acceptCard:. Since we're pulling one card at a time, and going from player to house, I wrote it four times. I'm sure a loop could be implemeented as well, I found this simpler.
    
    [self.deck drawNextCard];
    [self.house acceptCard:card];
    
    [self.deck drawNextCard];
    [self.player acceptCard:card];
    
    [self.deck drawNextCard];
    [self.house acceptCard:card];
    
}

- (void)dealCardToPlayer {
    
    FISCard *card = [FISCard new];
    
    if ([self.player shouldHit] && [self.player busted] == NO && [self.player stayed] == NO) {
        // Ensures that if the player has decided it shouldHit (from the method), ensures that it's not Busted or decided to stay.

    [self.deck drawNextCard];
    [self.player acceptCard:card];
    
    }
    
}

- (void)dealCardToHouse {
    
    FISCard *card = [FISCard new];
    
    if ([self.house shouldHit] && [self.house busted] == NO && [self.house stayed] == NO) {
    
    [self.deck drawNextCard];
   [self.house acceptCard:card];
    
    }
        
}

- (void)processPlayerTurn {
    
        [self dealCardToPlayer];
        
}

- (void)processHouseTurn {
        
        [self dealCardToHouse];
    
}

- (BOOL)houseWins {
    
    if (self.player.blackjack == YES && self.house.blackjack == YES ) {
        // If player & house both get Blackjack, player wins! Return NO for houseWins.
        
        return NO;
        
    } else if (self.house.busted == YES || self.player.handscore > self.house.handscore) {
        // If house is busted OR the player handscore is greater than the house handscore than the house loses & player wins.
        
        
        return NO;
        
    } else {
        // If all of the above conditions check out, houseWins!
        
        return YES;
        
    }
    
    return NO;
    
}
- (void)incrementWinsAndLossesForHouseWins:(BOOL)houseWins {
    
    if (houseWins == YES) {
        // Initially, I called the method houseWins ([self houseWins]) however, the tests are explicitly checking the argument BOOL so I had to write it this way!
    
        self.house.wins++;
        self.player.losses++;
        NSLog(@"House Wins! House: %@ W%lu - L%lu, Player: %@ W%lu - L%lu", self.house.name, self.house.wins, self.house.losses, self.player.name, self.player.wins, self.player.losses);
        
    }
    
    if (houseWins == NO) {
        
        self.house.losses++;
        self.player.wins++;
         NSLog(@"Player Wins! House: %@ W%lu - L%lu, Player: %@ W%lu - L%lu", self.house.name, self.house.wins, self.house.losses, self.player.name, self.player.wins, self.player.losses);
        
    }
    
    
}

@end
