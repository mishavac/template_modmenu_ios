#import "Macros.h"

/***********************************************************
  INSIDE THE FUNCTION BELOW YOU'LL HAVE TO ADD YOUR SWITCHES!
***********************************************************/
void setup() {

  //patching offsets directly, without switch
  patchOffset(ENCRYPTOFFSET("0x1002DB3C8"), ENCRYPTHEX("0xC0035FD6"));
  patchOffset(ENCRYPTOFFSET("0x10020D2D4"), ENCRYPTHEX("0x00008052C0035FD6"));

  // You can write as many bytes as you want to an offset
  patchOffset(ENCRYPTOFFSET("0x10020D3A8"), ENCRYPTHEX("0x00F0271E0008201EC0035FD6"));
  // or  
  patchOffset(ENCRYPTOFFSET("0x10020D3A8"), ENCRYPTHEX("00F0271E0008201EC0035FD6"));
  // spaces are fine too
  patchOffset(ENCRYPTOFFSET("0x10020D3A8"), ENCRYPTHEX("00 F0 27 1E 00 08 20 1E C0 03 5F D6"));


  // Empty switch - usefull with hooking
  [switches addSwitch:NSSENCRYPT("Masskill")
    description:NSSENCRYPT("Teleport all enemies to you without them knowing")
  ];

  // Offset Switch with one patch
  [switches addOffsetSwitch:NSSENCRYPT("God Mode")
    description:NSSENCRYPT("You can't die")
    offsets: {
      ENCRYPTOFFSET("0x1005AB148")
    }
    bytes: {
      ENCRYPTHEX("0x00E0BF12C0035FD6")
    }
  ];

  // Offset switch with multiple patches
  [switches addOffsetSwitch:NSSENCRYPT("One Hit Kill")
    description:NSSENCRYPT("Enemy will die instantly")
    offsets: {
      ENCRYPTOFFSET("0x1001BB2C0"),
      ENCRYPTOFFSET("0x1002CB3B0"),
      ENCRYPTOFFSET("0x1002CB3B8")
    }
    bytes: {
      ENCRYPTHEX("0x00E0BF12C0035FD6"),
      ENCRYPTHEX("0xC0035FD6"),
      ENCRYPTHEX("0x00F0271E0008201EC0035FD6")
    }
  ];

  // Textfield Switch - used in hooking
  [switches addTextfieldSwitch:NSSENCRYPT("Custom Gold")
    description:NSSENCRYPT("Here you can enter your own gold amount")
    inputBorderColor:UIColorFromHex(0xBD0000)
  ];

  // Slider Switch - used in hooking
  [switches addSliderSwitch:NSSENCRYPT("Custom Move Speed")
    description:NSSENCRYPT("Set your custom move speed")
    minimumValue:0
    maximumValue:10
    sliderColor:UIColorFromHex(0xBD0000)
  ];
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
            initWithTitle:NSSENCRYPT("Source - Mod Menu")
            titleColor:UIColorFromHex(0xff9a01)
            titleFont:NSSENCRYPT("Copperplate-Bold")
            credits:NSSENCRYPT("This Mod Menu has been made by Jayce, do not share this without proper credits and my permission. \n\nEnjoy!")
            headerColor:UIColorFromHex(0x8b342e)
            switchOffColor:UIColorFromHex(0xff9a01)
            switchOnColor:UIColorFromHex(0xf08502)
            switchTitleFont:NSSENCRYPT("Copperplate-Bold")
            switchTitleColor:UIColorFromHex(0x8b342e)
            infoButtonColor:UIColorFromHex(0x8b342e)
            maxVisibleSwitches:4 // Less than max -> blank space, more than max -> you can scroll!
            menuWidth:250
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
    [alert addButton: NSSENCRYPT("Visit Me!") actionBlock: ^(void) {
      [[UIApplication sharedApplication] openURL: [NSURL URLWithString: NSSENCRYPT("")]];
      timer(2) {
        setupMenu();
      });        
    }];

    [alert addButton: NSSENCRYPT("Thankyou, understood.") actionBlock: ^(void) {
      timer(2) {
        setupMenu();
      });
    }];    

    alert.shouldDismissOnTapOutside = NO;
    alert.customViewColor = [UIColor purpleColor];  
    alert.showAnimationType = SCLAlertViewShowAnimationSlideInFromCenter;   
    
    [alert showSuccess: nil
            subTitle:NSSENCRYPT("Source - Mod Menu \n\nThis Mod Menu has been made by Jayce, do not share this without proper credits and my permission. \n\nEnjoy!") 
              closeButtonTitle:nil
                duration:99999999.0f];
  });
}


%ctor {
  CFNotificationCenterAddObserver(CFNotificationCenterGetLocalCenter(), NULL, &didFinishLaunching, (CFStringRef)UIApplicationDidFinishLaunchingNotification, NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
}