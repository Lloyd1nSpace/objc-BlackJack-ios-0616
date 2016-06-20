//  FISAppDelegate.m

#import "FISAppDelegate.h"
#import "FISBlackjackGame.h"

@implementation FISAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    FISBlackjackPlayer *player = [[FISBlackjackPlayer alloc] initWithName:@"Lloyd"];
    NSLog(@"\n\n\n\n%@\n\n\n\n\n", player.description);
    
    FISCardDeck *deck = [FISCardDeck new];
    FISCard *card = [FISCard new];
    
    [deck drawNextCard];
    [player acceptCard:card];
    
    
    return YES;
}

@end
