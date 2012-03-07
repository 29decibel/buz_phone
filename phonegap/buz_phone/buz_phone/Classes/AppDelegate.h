//
//  AppDelegate.h
//  buz_phone
//
//  Created by li dongbin on 11-12-19.
//  Copyright mac 2011年. All rights reserved.
//

#import <UIKit/UIKit.h>
#ifdef PHONEGAP_FRAMEWORK
#import <PhoneGap/PhoneGapDelegate.h>
#else
#import "PhoneGapDelegate.h"
#endif

@interface AppDelegate : PhoneGapDelegate {

	NSString* invokeString;
    NSDictionary *launchNotification;
}

// invoke string is passed to your app on launch, this is only valid if you 
// edit buz_phone.plist to add a protocol
// a simple tutorial can be found here : 
// http://iphonedevelopertips.com/cocoa/launching-your-own-application-via-a-custom-url-scheme.html

@property (copy)  NSString* invokeString;
@property (nonatomic, retain) NSDictionary *launchNotification;

@end

