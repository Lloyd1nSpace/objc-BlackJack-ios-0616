//
//  FISCardDeck.m
//  OOP-Cards-Model
//
//  Created by Lloyd W. Sykes on 6/16/16.
//  Copyright © 2016 Al Tyus. All rights reserved.
//

#import "FISCardDeck.h"
#import "FISCard.h"

@implementation FISCardDeck

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        
        _remainingCards = [NSMutableArray new];
        _dealtCards = [NSMutableArray new];
        
        [self generateDeck];
        
    }
    
    return self;
    
}

- (FISCard *)drawNextCard {
    
    /* 4. Write the implementation for the `drawNextCard` method. It should return a card at one end of the array (*it is up to you to choose between making this either the first object or the last object in the array*). However, this method should also remove that card from the `remainingCards` array, and also add it to the `dealtCards` array. This way, our instance of `FISCardDeck` will always keep track of all fifty-two cards, even after drawing them. */
    
    if ([self.remainingCards count] == 0) {
        
        return nil;
        NSLog(@"The deck is empty!");
        
    }
    
    FISCard *nextCard = [self.remainingCards lastObject];
    // The objects inside of the self.remainingCards array are FISCard's which is why I had to specifically declare a FISCard instead of NSString for instance. Important to track object types!!!!
    
    [self.remainingCards removeObject:nextCard];
    [self.dealtCards addObject:nextCard];
    
    return nextCard;
    
}

- (void)resetDeck; {
    
    /*  6. Write the implementation for the `resetDeck` method to call the `gatherDealtCards` method and then the `shuffleRemainingCards` method. That's it, however the tests for `resetDeck` will fail until those other method implementations are completed.
     **Advanced:** *This method is the intended interface for interacting with the deck. There is not a "testable" option in Objective-C so the smaller methods must be made fully public in order to be visible to the tests.*/
    
    [self gatherDealtCards];
    [self shuffleRemainingCards];
    
}

- (void)gatherDealtCards {
    
    /* 7. Write the implementation for the `gatherDealtCards` method. It should add the cards in the `dealtCards` array back into the `remainingCards` array and leave the `dealtCards` array empty. */
    
    [self.remainingCards addObjectsFromArray:self.dealtCards];
    // Important to differentiate the addObject: class method from the addObjectsFromArray: class method.
    
    [self.dealtCards removeAllObjects];
    
}

- (void)shuffleRemainingCards {
    
    /* 8. Write the implementation for the `shuffleRemainingCards` method. Randomizing a collection is a difficult challenge and there are several ways to approach it. One approach would be to take the following steps:
     * "pick up" the deck by making a `mutableCopy` of the `remainingCards` array and emptying the `remainingCards` array,
     * begin a loop limited by the total number of cards to be shuffled (*in most cases this will be fifty-two, but can you guarantee that?*),
     * randomly draw a card out of the copied mutable array and insert it into the `remainingCards` array (*make sure to remove it from the copied array*).
     **Top-tip:** *To get a random integer, use the* `arc4random_uniform()` *C function which specifically takes a* `uint32_t` *parameter. To silence the warning generated when passing it an* `NSUInteger` *variable, cast the argument variable to an* `uint32_t`. */
    
    [self gatherDealtCards];
    // Calling the gatherDealtCards method ensures that self.remainingCards contains all 52 cards in its array. Otherwise, there could possibly some objects in the self.dealtCards array which would then mess up the count.
    
    NSUInteger cardCount = [self.remainingCards count];
    // Had to define this NSUInteger to define my counter for my for loop, this also had to be done BEFORE I removeAllObjects from self.remainingCards.
    
    NSMutableArray *cardsLeft = [self.remainingCards mutableCopy];
    [self.remainingCards removeAllObjects];
    // Despite removing all of the objects from the array, it actually doesn't alter my NSUInteger cardCount unless I explicitly redefine it.
    
    for (NSUInteger i = 0; i < cardCount; i++) {
        
        NSUInteger randomizeCard = arc4random_uniform((uint32_t) [cardsLeft count]);
        // Converted arc4random_uniform to an NSUInteger (pretty much literally what I google'd) in order to pull a random card from self.remainingCards (technically from cardsLeft which represents self.remainingCards).
        
        FISCard *randomCards = cardsLeft[randomizeCard];
        // Same way you would access an array by index, I accessed it by the NSUInteger I created which instead of accessing objects in order like the index would, accesses them completely randomly.
        
        [self.remainingCards addObject:randomCards];
        [cardsLeft removeObject:randomCards];
        // Important to remove every object from cardsLeft that gets added to self.remainingCards to avoid putting in duplicates.
        
    }
    
}

- (void)generateDeck {
    
    /*   3. Write the implementation for your card generator helper method. Think about how you can use the two arrays that you saved in the `FISCard` class methods `validSuits` and `validRanks` to dynamically create one unique card of each suit and rank combination. Add each card to the `remainingCards` array.
     **Hint:** *You'll need to use a loop within a loop.*/
    
    
    NSArray *suits = [FISCard validSuits];
    NSArray *ranks = [FISCard validRanks];
    
    for (NSUInteger s = 0; s < [suits count]; s++) {
        for (NSUInteger r = 0; r < [ranks count]; r++) {
            
            FISCard *card = [[FISCard alloc] initWithSuit:suits[s] rank:ranks[r]];
            // Utilized my designated initializer to define what an FISCard looks like in the deck.
            
            [self.remainingCards addObject:card];
            
        }
        
    }
    
}

- (NSString *)description {
    
    /*  9. Override the `description` method to return a customized string. You should return the count of the `remainingCards` array, and continue by appending the `card.description` of each card in the `remainingCards` array.
     **Hint:** *This is a great time to use an* `NSMutableString`.
     **Hint:** *You can hardcode a newline character with* `\n` *and indentations with spaces.*/
    
    NSMutableArray *deck = [NSMutableArray new];
    NSMutableString *newDescription = [NSMutableString stringWithFormat:@"\ncount: %lu \ncards:", self.remainingCards.count];
    
    for (FISCard *card in self.remainingCards) {
        
        if ([deck count] % 13 == 0) {
            // Understanding that every suit has 13 cards in it, this ensures that if the ammount of objects is divisible by 13, to start a new line
            
            [deck addObject:[NSString stringWithFormat:@"\n%@", card.cardLabel]];
            
        } else {
            
            [deck addObject:card.cardLabel];
            
        }
        
    }
    
    [newDescription appendFormat:@"%@", [deck componentsJoinedByString:@" "]];
    // Turning the contents of the cards mutable array into a string.
    
    NSLog(@"\nCHECK OUT MY DECK!: \n\n\n\n\n\n%@\n\n\n\n\n\n", newDescription);
    
    return newDescription;
    
}

@end
