//
//  FISCard.m
//  OOP-Cards-Model
//
//  Created by Lloyd W. Sykes on 6/16/16.
//  Copyright © 2016 Al Tyus. All rights reserved.
//

#import "FISCard.h"

@interface FISCard ()

@property (strong, nonatomic, readwrite) NSString *suit;
@property (strong, nonatomic, readwrite) NSString *rank;
@property (strong, nonatomic, readwrite) NSString *cardLabel;
@property (nonatomic, readwrite) NSUInteger cardValue;

@end

@implementation FISCard

- (instancetype)init {
    
    self = [self initWithSuit:@"!" rank:@"N"];
    
    return self;
    
}

- (instancetype)initWithSuit:(NSString *)suit rank:(NSString *)rank {
    
    /* 8. Assign `_cardLabel` and `_cardValue` in your initializer as follows:
     - `_cardLabel` should include the `suit` and `rank` properties together in such a way that the Queen of Spades will show `♥Q` and the Ten of Diamonds will show `♦10`.
     - `_cardValue` will be a little more complex. It will need to be `1` for an Ace, the face value of the numbered cards (i.e. `2` for a Two and `10` for a Ten), and `10` for the face cards (i.e. Jack, Queen, and King).
     **Hint:** *If the ranks are stored in an array, can you detect the index of a rank in that array? Then you could somehow use the index value to determine the card's value. Remember, if the Ace is first in the array, its index will be zero.*
     **Advanced:** *This is a case where Enums are most appropriate to use, however we don't cover them in the curriculum so we've taken a different route.*/
    
    self = [super init];
    
    if (self) {
        
        _suit = suit;
        _rank = rank;
        _cardLabel = [self cardLabelForSuitAndRank];
        _cardValue = [self cardValueForRank];
        // As opposed to trying to write out what _cardLabel & _cardValue are supposed to equal (=) here, I just created private methods to define said properties.
        
    }
    
    return self;
    
}

+ (NSArray *)validSuits {
    
    // 1. Write the implementation for the `validSuits` class method to return an array containing the four unicode characters for card suits ( ♠ ♥ ♣ ♦ ) inside strings.
    
    NSArray *cardSuits = @[@"♠", @"♥", @"♣", @"♦"];
    return cardSuits;
    
}

+ (NSArray *)validRanks {
    
    /*  2. Write the implementation for the `validRanks` class method to return an array containing a string representation of the thirteen card ranks from Ace to King.
     **Hint:** *Use digits to represent the numbered cards and abbreviate the face cards to "A", "J", "Q", "K". In this implementation, the Ace should be ordered as a low card.*/
    
    NSArray *ranks = @[@"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
    return ranks;
    
}

- (NSString *)description {
    
    return self.cardLabel;
    // Redefining the 'magical' method description.
    
}

- (NSString *)cardLabelForSuitAndRank {
    // Helper method for _cardLabel property
    
    return [NSString stringWithFormat:@"%@%@", self.suit, self.rank];
    
}

- (NSUInteger)cardValueForRank {
    // Helper method for _cardValue property
    
    NSArray *validRanks = [FISCard validRanks];
    // Since FISCard validRanks returns an NSArray, I was able to just declare the collection this way.
    
    NSUInteger index = [validRanks indexOfObject:self.rank];
    // Utilized the class method indexOfObject: to set the index of the validRanks array WITHOUT using a FOR loop.
    
    NSUInteger cardValue = 0;
    // Setting my return NSUInteger prior to starting my if statements.
    
    if (index <= 9) {
        // I was able to identify the items 0-9 in my array (represented as A-10) share the same problem, they need their index representation to go up one.
        
        cardValue = index + 1;
        
    } else {
        // The Joker, Queen & King cards all need to be equal to 10, so if it doesn't fall within the above if statement cardValue defaults to 10.
        
        cardValue = 10;
        
    }
    
    return cardValue;
}

@end
