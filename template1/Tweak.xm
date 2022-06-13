#import "Macros.h"

/***********************************************************
  INSIDE THE FUNCTION BELOW YOU'LL HAVE TO ADD YOUR SWITCHES!
***********************************************************/
void setup() {

  //See sample.xm for a example Tweak.xm

  //patching offsets directly, without switch
  patchOffset(0x1002DB3C8, "0xC0035FD6");
  patchOffset(0x10020D2D4, "0x00008052C0035FD6");

  // You can write as many bytes as you want to an offset
  patchOffset(0x10020D3A8, "0x00F0271E0008201EC0035FD6");
  // or  
  patchOffset(0x10020D3A8, "00F0271E0008201EC0035FD6");
  // spaces are fine too
  patchOffset(0x10020D3A8, "00 F0 27 1E 00 08 20 1E C0 03 5F D6");


  // Empty switch - usefull with hooking
  [switches addSwitch:@"Masskill"
              description:@"Teleport all enemies to you without them knowing"];

  // Offset Switch with one patch
  [switches addOffsetSwitch:@"God Mode"
              description:@"You can't die"
                offsets:{0x1005AB148}
                  bytes:{"0x00E0BF12C0035FD6"}];

  // Offset switch with multiple patches
  [switches addOffsetSwitch:@"One Hit Kill"
              description:@"Enemy will die instantly"
                offsets:{0x1001BB2C0, 0x1002CB3B0, 0x1002CB3B8}
                  bytes:{"0x00E0BF12C0035FD6", "0xC0035FD6", "0x00F0271E0008201EC0035FD6"}];

  // Textfield Switch - used in hooking
  [switches addTextfieldSwitch:@"Custom Gold"
              description:@"Here you can enter your own gold amount"
                inputBorderColor:UIColorFromHex(0xBD0000)];

  // Slider Switch - used in hooking
  [switches addSliderSwitch:@"Custom Move Speed"
              description:@"Set your custom move speed"
                minimumValue:0
                  maximumValue:10
                    sliderColor:UIColorFromHex(0xBD0000)];
}


/**********************************************************************************************************
     You can customize the menu here
     For colors, you can use hex color codes or UIColor itself
      - For the hex color #BD0000 you'd use: UIColorFromHex(0xBD0000)
      - For UIColor you can visit this site: https://www.uicolor.xyz/#/rgb-to-ui
        NOTE: remove the ";" when you copy your UIColor from there!
     
     Site to find your perfect font for the menu: http://iosfonts.com/  --> view on mac or ios device
     See comment next to maxVisibleSwitches!!!!

     menuIcon & menuButton is base64 data, upload a image to: https://www.browserling.com/tools/image-to-base64 \
     then replace that string with mine.
************************************************************************************************************/
void setupMenu() {

  // If a game uses a framework as base executable, you can enter the name here.
  // For example: UnityFramework, in that case you have to replace NULL with "UnityFramework" (note the quotes)
  [menu setFrameworkName:NULL];

  menu = [[Menu alloc]  
            initWithTitle:@"Hello Letovsky!"
            titleColor:[UIColor whiteColor]
            titleFont:@"Copperplate-Bold"
            credits:@"This Mod Menu has been made by Yourname, do not share this without proper credits and my permission. \n\nEnjoy!"
            headerColor:UIColorFromHex(0x1f1f1f)
            switchOffColor:[UIColor grayColor]
            switchOnColor:UIColorFromHex(0x1f1f1f)
            switchTitleFont:@"Copperplate-Bold"
            switchTitleColor:[UIColor whiteColor]
            infoButtonColor:[UIColor clearColor]
            maxVisibleSwitches:4
            menuWidth:350
            menuIcon:@""
            menuButton:@""];


    /********************************************************************
        Once menu has been initialized, it will run the setup functions. 
        All of your switches should be entered in the setup() function!
    *********************************************************************/
    setup();
}

// If the menu button doesn't show up; Change the timer to a bigger amount.
static void didFinishLaunching(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef info) {
  timer(5) {
    SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];

    // Website link, remove it if you don't need it.
    [alert addButton: @"Visit Me!" actionBlock: ^(void) {
      [[UIApplication sharedApplication] openURL: [NSURL URLWithString: @"your site"]];
      timer(2) {
        setupMenu();
      });        
    }];

    [alert addButton: @"Thankyou, understood." actionBlock: ^(void) {
      timer(2) {
        setupMenu();
      });
    }];    

    alert.shouldDismissOnTapOutside = NO;
    alert.customViewColor = [UIColor purpleColor];  
    alert.showAnimationType = SCLAlertViewShowAnimationSlideInFromCenter;   
    
    [alert showSuccess: nil
            subTitle:@"So2 - Mod Menu \n\nThis Mod Menu has been made by Yourname, do not share this without proper credits and my permission. \n\nEnjoy!" 
              closeButtonTitle:nil
                duration:99999999.0f];
  });
}


%ctor {
  CFNotificationCenterAddObserver(CFNotificationCenterGetLocalCenter(), NULL, &didFinishLaunching, (CFStringRef)UIApplicationDidFinishLaunchingNotification, NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
}