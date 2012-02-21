//
//  Copyright © 2010 Yuri Kotov
//  Licensed under the MIT license: http://opensource.org/licenses/MIT
//  Latest version can be found at http://github.com/advantis/BluetoothSwitcher
//

#import "ApplicationDelegate.h"
#import "UIApplication+Private.h"
#import "BluetoothManager.h"

static NSString *const BSBadgeEnabledKey                            = @"IsBadgeEnabled";
static NSString *const BluetoothAvailabilityChangedNotification     = @"BluetoothAvailabilityChangedNotification";

@implementation ApplicationDelegate

#pragma mark -
#pragma mark ApplicationDelegate
- (void) bluetoothAvailabilityDidChange:(NSNotification *)notification
{
    BluetoothManager *bluetoothManager = [BluetoothManager sharedInstance];
    BOOL shouldEnable = ![bluetoothManager enabled];
    [bluetoothManager setEnabled:shouldEnable];
    UIApplication *application = [UIApplication sharedApplication];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:BSBadgeEnabledKey])
    {
        NSString *bageString = shouldEnable ? @"on" : @"off";
        [application setApplicationBadgeString:bageString];
    }
    [application terminateWithSuccess];
}

#pragma mark -
#pragma mark NSObject
- (id) init
{
    self = [super init];
    if (self)
    {
        NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
        [defaultCenter addObserver:self
                          selector:@selector(bluetoothAvailabilityDidChange:)
                              name:BluetoothAvailabilityChangedNotification
                            object:nil];
        [BluetoothManager sharedInstance];
    }
    return self;
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

#pragma mark -
#pragma mark UIApplicationDelegate
- (void) applicationDidFinishLaunching:(UIApplication *)application
{
    [application setSuspensionAnimationDelay:0.0];
    [application setApplicationBadgeString:nil];
}

@end
