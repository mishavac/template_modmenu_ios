#import "Macros.h"

/**********************************

 SOURCE CODE MENU FOR ALL GAMES BY JAYCE (@GITDEV)

***********************************/


void setup() {


}


/**********************************************************************************************************
     
     You can customize the menu here
     Good site for specific UIColor: https://www.uicolor.xyz/#/rgb-to-ui
     NOTE: remove the ";" when you copy your UIColor from there!
     
     Site to find your perfect font for the menu: http://iosfonts.com/  --> view on mac or ios device
     See comment next to maxVisibleSwitches!!!!
     
menuIcon & menuButton is base64 data, upload a image to: https://www.browserling.com/tools/image-to-base64
     Then replace that string with mine.
          
************************************************************************************************************/
void setupMenu() {

  menu = [[Menu alloc]  initWithTitle:@"Hudware"
                        titleColor:[UIColor whiteColor]
                        titleFont:@"AvenirNext-Bold"
                        credits:@"https://t.me/hudware\n\nEnjoy!"
                        headerColor:[[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"/Library/MobileSubstrate/DynamicLibraries/HD.bundle/f1.png"]]
                        switchOffColor:[[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"/Library/MobileSubstrate/DynamicLibraries/HD.bundle/f2.png"]]
                        switchOnColor:[[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"/Library/MobileSubstrate/DynamicLibraries/HD.bundle/f3.png"]]
                        switchTitleFont:@"AvenirNext-Bold"
                        switchTitleColor:[UIColor whiteColor]
                        infoButtonColor:[UIColor colorWithRed:0.00 green:0.50 blue:1.00 alpha:1.00]
                        maxVisibleSwitches:5 // Less than max -> blank space, more than max -> you can scroll!
                        menuWidth:350



                        menuIcon:@""

                        menuButton:@""];    



    //once menu has been initialized, it will run the setup functions. In the setup function, you create your switches!
    setup();

}

static void didFinishLaunching(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef info) {

NSUserDefaults *check;
check = [NSUserDefaults standardUserDefaults];


timer(2) {
setupMenu();
  });
}


%ctor {

CFNotificationCenterAddObserver(CFNotificationCenterGetLocalCenter(), NULL, &didFinishLaunching, (CFStringRef)UIApplicationDidFinishLaunchingNotification, NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
}