//
//  Copyright © 2010 Yuri Kotov
//  Licensed under the MIT license: http://opensource.org/licenses/MIT
//  Latest version can be found at http://github.com/advantis/BluetoothSwitcher
//

#import "ApplicationDelegate.h"

int main (int argc, char *argv[])
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, NSStringFromClass([ApplicationDelegate class]));
    [pool release];
    return retVal;
}
