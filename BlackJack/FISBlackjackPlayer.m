//
//  FISBlackjackPlayer.m
//  BlackJack
//
//  Created by Lloyd W. Sykes on 6/17/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

#import "FISBlackjackPlayer.h"

@interface FISBlackjackPlayer ()

@end

@implementation FISBlackjackPlayer

- (instancetype)init {
    
    self = [self initWithName:@""];
    
    return self;
    
}

- (instancetype)initWithName:(NSString *)name  {
    
    self = [super init];
    
    if (self) {
        
        _name = name;
        _cardsInHand = [NSMutableArray new];
        _aceInHand = NO;
        _blackjack = NO;
        _busted = NO;
        _stayed = NO;
        _handscore = 0;
        _wins = 0;
        _losses = 0;
        
    }
    
    return self;
    
}

- (void)resetForNewGame {
    
    [self.cardsInHand removeAllObjects];
    self.handscore = 0;
    self.aceInHand = NO;
    self.stayed = NO;
    self.blackjack = NO;
    self.busted = NO;
    
}

- (void)acceptCard:(FISCard *)card {
    
    [self.cardsInHand addObject:card];
    
    NSString *ace = @"A";
    // Created this string but I also could have as well just searched for the string @"A" to identify the ace card.
    
    self.handscore += card.cardValue;
    // I was implementing a for-in loop previously but I realized it wasn't necessary.
    
    if ([card.cardLabel containsString:ace]) {
        // This checks the previously definded property cardLabel to pull out the Aces in the deck & prove the BOOLean aceInHand true.
        
        self.aceInHand = YES;
        
    }
    
    if (self.aceInHand == YES && self.handscore <= 11){
        // This essentially decides if the Ace cardValue is 1 or 11 depending on the value of the cards currently in hand (represented by self.handscore)
        
        self.handscore += 10;
        
    }
    
    if (self.cardsInHand.count == 2 && self.handscore == 21) {
        
        self.blackjack = YES;
        
    }
    
    if (self.handscore > 21) {
        
        self.busted = YES;
        
    }
    // To improve readability, I could also create a couple of helper methods to automatically check for aceInHand, whether it'll be worth 1 or 11, define black jack / busted booleans & call said helper methods.
    
}

- (BOOL)shouldHit {
    
    if (self.handscore > 17) {
        
        self.stayed = YES;
        return NO;
        // If the current handscore is more than 17, do not hit me with another card!
        
    }
    
    return YES;
    
}

- (NSString *)description {
    
    NSString *gameStats = [NSString stringWithFormat:@"\nname:  %@\ncards: ♠A ♠J\n     handscore  : %lu\n     ace in hand: %d\n     stayed     : %d\n     blackjack  : %d\n     busted     : %d\n     wins  : %lu\nlosses: %lu", self.name, self.handscore, self.aceInHand, self.stayed, self.blackjack, self.busted, self.wins, self.losses];
    
    NSLog(@"\n\n\n\n\n%@\n\n\n\n\n", gameStats);
    
    return gameStats;
    
}

@end
