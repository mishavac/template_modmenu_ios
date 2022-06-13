
#define timer(sec) dispatch_after(dispatch_time(DISPATCH_TIME_NOW, sec * NSEC_PER_SEC), dispatch_get_main_queue(), ^

#define UIColorFromHex(hexColor) [UIColor colorWithRed:((float)((hexColor & 0xFF0000) >> 16))/255.0 green:((float)((hexColor & 0xFF00) >> 8))/255.0 blue:((float)(hexColor & 0xFF))/255.0 alpha:1.0]

#import <Foundation/Foundation.h>
#import "Menu.h"

@interface Menu ()

@property (assign, nonatomic) CGPoint lastMenuLocation;
@property (strong, nonatomic) UILabel *menuTitle;
@property (strong, nonatomic) UILabel *buttonTitle;
@property (strong, nonatomic) UILabel *textTitle;
@property (strong, nonatomic) UIView *header;
@property (strong, nonatomic) UIView *border;
@property (strong, nonatomic) UIView *footer;
@property (strong, nonatomic) UILabel *footerText;

@end


@implementation Menu

NSUserDefaults *defaults;

UIScrollView *scrollView;
UIScrollView *scrollView2;
UIScrollView *scrollView3;
UIScrollView *scrollView4;
CGFloat menuWidth;
CGFloat scrollViewX;
NSString *credits;
UIColor *switchOnColor;
NSString *switchTitleFont;
UIColor *switchTitleColor;
UIColor *infoButtonColor;
NSString *menuIconBase64;
NSString *menuButtonBase64;
float scrollViewHeight = 0;
float scrollView2Height = 0;
float scrollView3Height = 0;
float scrollView4Height = 0;
BOOL hasRestoredLastSession = false;
UIButton *menuButton;
UILabel *buttonTitle;
const char *frameworkName = NULL;
UIButton *button7 = [UIButton buttonWithType:UIButtonTypeCustom];
UIButton *button6 = [UIButton buttonWithType:UIButtonTypeCustom];
UIButton *button8 = [UIButton buttonWithType:UIButtonTypeCustom];
UIWindow *mainWindow;
UILabel *watermark;
UIDevice *myDevice;
NSDateFormatter *ttime;
UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
UIButton *button11 = [UIButton buttonWithType:UIButtonTypeCustom];
UIButton *button12 = [UIButton buttonWithType:UIButtonTypeCustom];
UIButton *button13 = [UIButton buttonWithType:UIButtonTypeCustom];
UIView *menuRightBorder;
UIView *menuRightBorder1;
// init the menu
// global variabls, extern in Macros.h
Menu *menu = [[Menu alloc]init];
Switches *switches = [[Switches alloc]init];


-(id)initWithTitle:(NSString *)title_ titleColor:(UIColor *)titleColor_ titleFont:(NSString *)titleFont_ credits:(NSString *)credits_ headerColor:(UIColor *)headerColor_ switchOffColor:(UIColor *)switchOffColor_ switchOnColor:(UIColor *)switchOnColor_ switchTitleFont:(NSString *)switchTitleFont_ switchTitleColor:(UIColor *)switchTitleColor_ infoButtonColor:(UIColor *)infoButtonColor_ maxVisibleSwitches:(int)maxVisibleSwitches_ menuWidth:(CGFloat )menuWidth_ menuIcon:(NSString *)menuIconBase64_ menuButton:(NSString *)menuButtonBase64_ {
    mainWindow = [UIApplication sharedApplication].keyWindow;
    defaults = [NSUserDefaults standardUserDefaults];

    menuWidth = menuWidth_;
    switchOnColor = switchOnColor_;
    credits = credits_;
    switchTitleFont = switchTitleFont_;
    switchTitleColor = switchTitleColor_;
    infoButtonColor = infoButtonColor_;
    menuButtonBase64 = menuButtonBase64_;

NSString *bat = @"%";

    myDevice = [UIDevice currentDevice];
       [myDevice setBatteryMonitoringEnabled:YES];
           double batLeft = (float)[myDevice batteryLevel] * 100;

   ttime = [[NSDateFormatter alloc] init];
      [ttime setDateFormat:@"hh:mm a"];

watermark = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, 153.5, 25)];
watermark.textColor = [UIColor whiteColor];
watermark.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.45];
watermark.layer.borderColor = [UIColor blackColor].CGColor;
watermark.layer.borderWidth = 2.0f;
watermark.layer.cornerRadius = 1.0;
watermark.text = [NSString stringWithFormat:@" bymelon | %.0f%@ | %@",batLeft,bat,[ttime stringFromDate:[NSDate date]]];
watermark.adjustsFontSizeToFitWidth = YES;
watermark.layer.opacity = 0;
watermark.font = [UIFont fontWithName:@"Avenir-Heavy" size:13.0f];
watermark.center = CGPointMake(CGRectGetMaxX(mainWindow.frame)-(watermark.frame.size.width/2)-[[switches getValueFromSwitch:@"Watermark X:"] floatValue], CGRectGetMinY(mainWindow.frame)+(watermark.frame.size.height/2)+[[switches getValueFromSwitch:@"Watermark Y:"] floatValue]);
[mainWindow addSubview:watermark];

[NSTimer scheduledTimerWithTimeInterval:0.001f target:self selector:@selector(watermark) userInfo:nil repeats:YES];

        [UIView animateWithDuration:0.25 animations:^ {
if([switches isSwitchOn:@"Watermark"]){
watermark.layer.opacity = 1;
}else{
watermark.layer.opacity = 0;
}
}];

    // Base of the Menu UI.
    self = [super initWithFrame:CGRectMake(0,0,menuWidth_, maxVisibleSwitches_ * 50 + 50)];
    self.center = mainWindow.center;
    self.transform = CGAffineTransformMakeScale(0.001, 0.001);

    self.header = [[UIView alloc]initWithFrame:CGRectMake(0, 1, menuWidth_, 25)];
    self.header.backgroundColor = headerColor_;
    CAShapeLayer *headerLayer = [CAShapeLayer layer];
    headerLayer.path = [UIBezierPath bezierPathWithRoundedRect: self.header.bounds byRoundingCorners: UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii: (CGSize){0.0, 0.0}].CGPath;
    self.header.layer.mask = headerLayer;
    [self addSubview:self.header];

self.border = [[UIView alloc]initWithFrame:CGRectMake(0, 0, menuWidth_, 5)];
    self.border.backgroundColor = UIColorFromHex(0x0070bf);
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
     borderLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.border.bounds byRoundingCorners: UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii: (CGSize){-1.0, -1.0}].CGPath;
    self.border.layer.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:0.0].CGColor;
    self.border.layer.shadowRadius = 15.0f;
    self.border.layer.shadowOpacity = 1.0f;
    self.border.layer.shadowOffset = CGSizeMake(3, 0);
    self.border.layer.mask = borderLayer;
    [self addSubview:self.border];

    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.header.bounds), menuWidth_, CGRectGetHeight(self.bounds) - CGRectGetHeight(self.header.bounds))];
    scrollView.backgroundColor = switchOffColor_;
    [self addSubview:scrollView];

    scrollView2 = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.header.bounds)-25, menuWidth_, CGRectGetHeight(self.bounds) - CGRectGetHeight(self.header.bounds))];
    scrollView2.backgroundColor = switchOffColor_;
    scrollView2.transform = CGAffineTransformMakeScale(0.001, 1);
    [scrollView addSubview:scrollView2];

    scrollView3 = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.header.bounds)-25, menuWidth_, CGRectGetHeight(self.bounds) - CGRectGetHeight(self.header.bounds))];
    scrollView3.backgroundColor = switchOffColor_;
    scrollView3.transform = CGAffineTransformMakeScale(0.001, 1);
    [scrollView addSubview:scrollView3];

    scrollView4 = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.header.bounds)-25, menuWidth_, CGRectGetHeight(self.bounds) - CGRectGetHeight(self.header.bounds))];
    scrollView4.backgroundColor = switchOffColor_;
    scrollView4.transform = CGAffineTransformMakeScale(0.001, 1);
_textTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 125, 145, 20)];
_textTitle.text = @"Crosshair Color:";
_textTitle.textColor = [UIColor whiteColor];
_textTitle.font = [UIFont fontWithName:@"AppleSDGothicNeo-Bold" size:16.0f];
_textTitle.adjustsFontSizeToFitWidth = true;
_textTitle.textAlignment = NSTextAlignmentCenter;
[scrollView4 addSubview:_textTitle];
    [scrollView addSubview:scrollView4];

  menuRightBorder = [[UIView alloc]initWithFrame:CGRectMake(0.0, 0.0, 19, 2)];
   menuRightBorder.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.00];
   menuRightBorder.center = mainWindow.center;
    menuRightBorder.alpha = 0.0;
   [mainWindow addSubview: menuRightBorder];

   menuRightBorder1 = [[UIView alloc]initWithFrame:CGRectMake(0.0, 0.0, 2, 19)];
   menuRightBorder1.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.00];
   menuRightBorder1.center = mainWindow.center;
menuRightBorder1.alpha = 0.0;
   [mainWindow addSubview: menuRightBorder1];

        [UIView animateWithDuration:0.25 animations:^ {
if([switches isSwitchOn:@"Crosshair"]){

menuRightBorder.alpha = 1.0;

menuRightBorder1.alpha = 1.0;

}
else{

menuRightBorder.alpha = 0.0;

menuRightBorder1.alpha = 0.0;
}
}];

[button13 addTarget:self 
 action:@selector(ButtonClicked5:)
 forControlEvents:UIControlEventTouchUpInside];
[button13 setTitle:@"Black" forState:UIControlStateNormal];
[button13.titleLabel setFont:[UIFont fontWithName:@"AppleSDGothicNeo-Bold" size:16.0f]];
button13.frame = CGRectMake(/*x*/185, /*y*/125.0, 50, 20);
button13.layer.cornerRadius = 0.0;
button13.layer.masksToBounds = true;
button13.backgroundColor = [UIColor clearColor];
UITapGestureRecognizer *buttonTap13 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ButtonClicked13)];
[button13 addGestureRecognizer:buttonTap13];
[scrollView4 addSubview:button13];

[button11 addTarget:self 
 action:@selector(ButtonClicked5:)
 forControlEvents:UIControlEventTouchUpInside];
[button11 setTitle:@"◄" forState:UIControlStateNormal];
[button11.titleLabel setFont:[UIFont fontWithName:@"Avenir-Black" size:30.0f]];
button11.frame = CGRectMake(/*x*/150, /*y*/122.0, 20, 20);
button11.layer.cornerRadius = 0.0;
button11.layer.masksToBounds = true;
button11.backgroundColor = [UIColor clearColor];
UITapGestureRecognizer *buttonTap11 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ButtonClicked11)];
[button11 addGestureRecognizer:buttonTap11];
[scrollView4 addSubview:button11];

[button12 addTarget:self 
 action:@selector(ButtonClicked5:)
 forControlEvents:UIControlEventTouchUpInside];
[button12 setTitle:@"►" forState:UIControlStateNormal];
[button12.titleLabel setFont:[UIFont fontWithName:@"Avenir-Black" size:30.0f]];
button12.frame = CGRectMake(/*x*/255, /*y*/122, 20, 20);
button12.hidden = YES;
button12.layer.cornerRadius = 0.0;
button12.layer.masksToBounds = true;
button12.backgroundColor = [UIColor clearColor];
UITapGestureRecognizer *buttonTap12 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ButtonClicked12)];
[button12 addGestureRecognizer:buttonTap12];
[scrollView4 addSubview:button12];

[button7 addTarget:self 
 action:@selector(ButtonClicked5:)
 forControlEvents:UIControlEventTouchUpInside];
[button7 setTitle:@" " forState:UIControlStateNormal];
[button7.titleLabel setFont:[UIFont fontWithName:@"Avenir-Black" size:13.0f]];
button7.frame = CGRectMake(/*x*/50, /*y*/0, 300, 40);
button7.layer.cornerRadius = 0.0;
button7.alpha = 0;
button7.layer.masksToBounds = true;
button7.backgroundColor = [UIColor clearColor];
UITapGestureRecognizer *buttonTap7 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ButtonClicked7)];
[button7 addGestureRecognizer:buttonTap7];
[_header addSubview:button7];



[button addTarget:self 
 action:@selector(ButtonClicked5:)
 forControlEvents:UIControlEventTouchUpInside];
[button setTitle:@" " forState:UIControlStateNormal];
[button.titleLabel setFont:[UIFont fontWithName:@"Avenir-Black" size:13.0f]];
button.frame = CGRectMake(15, 15.0, 125, 250);
button.layer.borderColor = UIColorFromHex(0x0070bf).CGColor;
button.layer.borderWidth = 0.5f;
button.layer.cornerRadius = 13.0;
button.layer.masksToBounds = true;
button.backgroundColor = UIColorFromHex(0x152d7a);
UIImage *buttonImage = [UIImage imageNamed:@"/var/mobile/Documents/melon/1.png"];
[button setImage:buttonImage forState:UIControlStateNormal];
button.imageEdgeInsets = UIEdgeInsetsMake(80, 100, 80, 100);
UITapGestureRecognizer *buttonTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ButtonClicked)];
[button addGestureRecognizer:buttonTap];
_buttonTitle = [[UILabel alloc]initWithFrame:CGRectMake(31.25, 20, 62.5, 430)];
_buttonTitle.text = @"Global (No Work)";
_buttonTitle.textColor = [UIColor whiteColor];
_buttonTitle.font = [UIFont fontWithName:@"AppleSDGothicNeo-Bold" size:15.0f];
_buttonTitle.adjustsFontSizeToFitWidth = true;
_buttonTitle.textAlignment = NSTextAlignmentCenter;
[button addSubview:_buttonTitle];
[scrollView addSubview:button];



[button2 addTarget:self 
 action:@selector(ButtonClicked5:)
 forControlEvents:UIControlEventTouchUpInside];
[button2 setTitle:@" " forState:UIControlStateNormal];
[button2.titleLabel setFont:[UIFont fontWithName:@"Avenir-Black" size:13.0f]];
button2.frame = CGRectMake(150, 15.0, 125, 250);
button2.layer.borderColor = UIColorFromHex(0x0070bf).CGColor;
button2.layer.borderWidth = 0.5f;
button2.layer.cornerRadius = 13.0;
button2.layer.masksToBounds = true;
button2.backgroundColor = UIColorFromHex(0x152d7a);
UIImage *button2Image = [UIImage imageNamed:@"/var/mobile/Documents/melon/2.png"];
[button2 setImage:button2Image forState:UIControlStateNormal];
button2.imageEdgeInsets = UIEdgeInsetsMake(80, 100, 80, 100);
UITapGestureRecognizer *buttonTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ButtonClicked2)];
_buttonTitle = [[UILabel alloc]initWithFrame:CGRectMake(31.25, 20, 62.5, 430)];
_buttonTitle.text = @"Visual";
_buttonTitle.textColor = [UIColor whiteColor];
_buttonTitle.font = [UIFont fontWithName:@"AppleSDGothicNeo-Bold" size:15.0f];
_buttonTitle.adjustsFontSizeToFitWidth = true;
_buttonTitle.textAlignment = NSTextAlignmentCenter;
[button2 addSubview:_buttonTitle];
[button2 addGestureRecognizer:buttonTap2];
[scrollView addSubview:button2];

[button3 addTarget:self 
 action:@selector(ButtonClicked5:)
 forControlEvents:UIControlEventTouchUpInside];
[button3 setTitle:@" " forState:UIControlStateNormal];
[button3.titleLabel setFont:[UIFont fontWithName:@"Avenir-Black" size:13.0f]];
button3.frame = CGRectMake(285, 15.0, 125, 250);
button3.layer.borderColor = UIColorFromHex(0x0070bf).CGColor;
button3.layer.borderWidth = 0.5f;
button3.layer.cornerRadius = 13.0; 
button3.layer.masksToBounds = true;
button3.backgroundColor = UIColorFromHex(0x152d7a);
UIImage *button3Image = [UIImage imageNamed:@"/var/mobile/Documents/melon/3.png"];
[button3 setImage:button3Image forState:UIControlStateNormal];
button3.imageEdgeInsets = UIEdgeInsetsMake(80, 100, 80, 100);
UITapGestureRecognizer *buttonTap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ButtonClicked3)];
[button3 addGestureRecognizer:buttonTap3];
_buttonTitle = [[UILabel alloc]initWithFrame:CGRectMake(31.25, 20, 62.5, 430)];
_buttonTitle.text = @"Settings";
_buttonTitle.textColor = [UIColor whiteColor];
_buttonTitle.font = [UIFont fontWithName:@"AppleSDGothicNeo-Bold" size:15.0f];
_buttonTitle.adjustsFontSizeToFitWidth = true;
_buttonTitle.textAlignment = NSTextAlignmentCenter;
[button3 addSubview:_buttonTitle];
[scrollView addSubview:button3];


    // we need this for the switches, do not remove.
    scrollViewX = CGRectGetMinX(scrollView.self.bounds);

    self.menuTitle = [[UILabel alloc]initWithFrame:CGRectMake(55, -2, menuWidth_ - 60, 50)];
    self.menuTitle.text = title_;
    self.menuTitle.textColor = titleColor_;
    self.menuTitle.font = [UIFont fontWithName:titleFont_ size:30.0f];
    self.menuTitle.adjustsFontSizeToFitWidth = true;
    self.menuTitle.textAlignment = NSTextAlignmentCenter;
    [self.header addSubview: self.menuTitle];

    self.footer = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.bounds) - 1, menuWidth_, 20)];
    self.footer.backgroundColor = headerColor_;
    CAShapeLayer *footerLayer = [CAShapeLayer layer];
    footerLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.footer.bounds byRoundingCorners: UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii: (CGSize){0.0, 0.0}].CGPath;
    self.footer.layer.mask = footerLayer;
    [self addSubview:self.footer];

self.footerText = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetHeight(self.bounds) - 0, menuWidth_, 20)];
    self.footerText.text = @"By melonwer";
    self.footerText.textColor = [UIColor whiteColor];
    self.footerText.font = [UIFont fontWithName:titleFont_ size:13.0f];
    self.footerText.adjustsFontSizeToFitWidth = true;
    self.footerText.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.footerText];

self.footerText = [[UILabel alloc]initWithFrame:CGRectMake(-5, CGRectGetHeight(self.bounds) - 0, menuWidth_, 20)];
    self.footerText.text = @"For Version: 0.19.1";
    self.footerText.textColor = [UIColor whiteColor];
    self.footerText.font = [UIFont fontWithName:titleFont_ size:13.0f];
    self.footerText.adjustsFontSizeToFitWidth = true;
    self.footerText.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.footerText];

    UIPanGestureRecognizer *dragMenuRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(menuDragged:)];
    [self.header addGestureRecognizer:dragMenuRecognizer];

    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideMenu:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [self.header addGestureRecognizer:tapGestureRecognizer];

    [mainWindow addSubview:self];
    [self showMenuButton];

    return self;
}

// Detects whether the menu is being touched and sets a lastMenuLocation.
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    self.lastMenuLocation = CGPointMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame));
    [super touchesBegan:touches withEvent:event];
}

// Update the menu's location when it's being dragged
- (void)menuDragged:(UIPanGestureRecognizer *)pan {
    CGPoint newLocation = [pan translationInView:self.superview];
    self.frame = CGRectMake(self.lastMenuLocation.x + newLocation.x, self.lastMenuLocation.y + newLocation.y, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
}

- (void)hideMenu:(UITapGestureRecognizer *)tap {
    if(tap.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.25 animations:^ {
    self.transform = CGAffineTransformMakeScale(0.001, 0.001);
            menuButton.alpha = 1.0f;
        }];
    }
}

-(void)ButtonClicked7{
timer(0.15){

button7.alpha = 0;
button.alpha = 1;
button2.alpha = 1;
button3.alpha = 1;

});

        [UIView animateWithDuration:0.15 animations:^ {
    scrollView.transform = CGAffineTransformMakeScale(1, 1);
    scrollView2.transform = CGAffineTransformMakeScale(0.001, 1);
    scrollView3.transform = CGAffineTransformMakeScale(0.001, 1);
    scrollView4.transform = CGAffineTransformMakeScale(0.001, 1);
}];
}

-(void)showMenu:(UITapGestureRecognizer *)tapGestureRecognizer {
    if(tapGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        menuButton.alpha = 0.0f;
        [UIView animateWithDuration:0.25 animations:^ {
    self.transform = CGAffineTransformMakeScale(1, 1);
        }];
    }
    // We should only have to do this once (first launch)
    if(!hasRestoredLastSession) {
        hasRestoredLastSession = true;
    }
}

-(void)ButtonClicked3{


button.alpha = 0;
button2.alpha = 0;
button3.alpha = 0;

        [UIView animateWithDuration:0.15 animations:^ {
button7.alpha = 1;
    scrollView4.transform = CGAffineTransformMakeScale(1, 1);

}];
}


-(void)ButtonClicked2{


button.alpha = 0;
button2.alpha = 0;
button3.alpha = 0;

        [UIView animateWithDuration:0.15 animations:^ {
button7.alpha = 1;
    scrollView3.transform = CGAffineTransformMakeScale(1, 1);

}];
}


-(void)ButtonClicked{


button.alpha = 0;
button2.alpha = 0;
button3.alpha = 0;

        [UIView animateWithDuration:0.15 animations:^ {
button7.alpha = 1;
    scrollView2.transform = CGAffineTransformMakeScale(1, 1);

}];

}


-(void)ButtonClicked6{

timer(0.15){

button.alpha = 1;
button2.alpha = 1;
button3.alpha = 1;

});

        [UIView animateWithDuration:0.15 animations:^ {
    scrollView.transform = CGAffineTransformMakeScale(1, 1);
    scrollView2.transform = CGAffineTransformMakeScale(0.001, 1);
    scrollView3.transform = CGAffineTransformMakeScale(0.001, 1);
    scrollView4.transform = CGAffineTransformMakeScale(0.001, 1);
}];

}


-(void)ButtonClicked8{

timer(0.15){

button.alpha = 1;
button2.alpha = 1;
button3.alpha = 1;

});

        [UIView animateWithDuration:0.15 animations:^ {
    scrollView.transform = CGAffineTransformMakeScale(1, 1);
    scrollView2.transform = CGAffineTransformMakeScale(0.001, 1);
    scrollView3.transform = CGAffineTransformMakeScale(0.001, 1);
    scrollView4.transform = CGAffineTransformMakeScale(0.001, 1);
}];

}

-(void)watermark{
NSString *bat = @"%";

    myDevice = [UIDevice currentDevice];
       [myDevice setBatteryMonitoringEnabled:YES];
           double batLeft = (float)[myDevice batteryLevel] * 100;

   ttime = [[NSDateFormatter alloc] init];
      [ttime setDateFormat:@"hh:mm a"];


watermark.text = [NSString stringWithFormat:@" bymelon | %.0f%@ | %@",batLeft,bat,[ttime stringFromDate:[NSDate date]]];
watermark.center = CGPointMake(CGRectGetMaxX(mainWindow.frame)-(watermark.frame.size.width/2)-[[switches getValueFromSwitch:@"Watermark X:"] floatValue], CGRectGetMinY(mainWindow.frame)+(watermark.frame.size.height/2)+[[switches getValueFromSwitch:@"Watermark Y:"] floatValue]);

        [UIView animateWithDuration:0.25 animations:^ {
if([switches isSwitchOn:@"Crosshair"]){
menuRightBorder.alpha = 1.0;

menuRightBorder1.alpha = 1.0;

}
else{

menuRightBorder.alpha = 0.0;

menuRightBorder1.alpha = 0.0;
}
}];
}

int anal = 0;int anall = 0;

-(void)ButtonClicked11{
if(anal == 0){
[button13 setTitle:@"Red" forState:UIControlStateNormal];

menuRightBorder1.backgroundColor = [UIColor redColor];
menuRightBorder.backgroundColor = [UIColor redColor];
button11.hidden = NO;
button12.hidden = NO;
anall = 1;
anal = 1;
}else if(anal == 1){

[button13 setTitle:@"Green" forState:UIControlStateNormal];

menuRightBorder1.backgroundColor = [UIColor greenColor];
menuRightBorder.backgroundColor = [UIColor greenColor];
button12.hidden = NO;
button11.hidden = YES;
anal = 2;
}else if(anall == 0){

[button13 setTitle:@"Green" forState:UIControlStateNormal];

menuRightBorder1.backgroundColor = [UIColor greenColor];
menuRightBorder.backgroundColor = [UIColor greenColor];
button12.hidden = NO;
button11.hidden = YES;
anal = 2;
anall = 1;
}
}

-(void)ButtonClicked12{

if(anal == 2){

[button13 setTitle:@"Red" forState:UIControlStateNormal];

menuRightBorder1.backgroundColor = [UIColor redColor];
menuRightBorder.backgroundColor = [UIColor redColor];
button11.hidden = NO;
button12.hidden = NO;
anall = 0;
anal = 3;
} else if(anal == 3){

[button13 setTitle:@"Black" forState:UIControlStateNormal];

menuRightBorder1.backgroundColor = [UIColor blackColor];
menuRightBorder.backgroundColor = [UIColor blackColor];
button11.hidden = NO;
button12.hidden = YES;
anal = 0;
} else if(anall == 1){

[button13 setTitle:@"Black" forState:UIControlStateNormal];

menuRightBorder1.backgroundColor = [UIColor blackColor];
menuRightBorder.backgroundColor = [UIColor blackColor];
button11.hidden = NO;
button12.hidden = YES;
anal = 0;
anall = 0;
}
}

/**********************************************************************************************
     This function will be called when the menu has been opened for the first time on launch.
     It'll handle the correct background color and patches the switches do.
***********************************************************************************************/

-(void)showMenuButton {
    NSData* data = [[NSData alloc] initWithBase64EncodedString:menuButtonBase64 options:0];
    UIImage* menuButtonImage = [UIImage imageWithData:data];

    menuButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    menuButton.frame = CGRectMake((mainWindow.frame.size.width/2-50), (mainWindow.frame.size.height/2-50), 100, 100);
    menuButton.backgroundColor = [UIColor clearColor];
    [menuButton setBackgroundImage:menuButtonImage forState:UIControlStateNormal];

    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showMenu:)];
    [menuButton addGestureRecognizer:tapGestureRecognizer];

    [menuButton addTarget:self action:@selector(buttonDragged:withEvent:)
       forControlEvents:UIControlEventTouchDragInside];
    [mainWindow addSubview:menuButton];
}

// handler for when the user is draggin the menu.
- (void)buttonDragged:(UIButton *)button withEvent:(UIEvent *)event {
    button.center = CGPointMake(button.center.x, button.center.y);
}

// When the menu icon(on the header) has been tapped, we want to show proper credits!
-(void)menuIconTapped {
    [self showPopup:self.menuTitle.text description:credits];
    self.layer.opacity = 0.0f;
}

-(void)showPopup:(NSString *)title_ description:(NSString *)description_ {
    SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];

    alert.shouldDismissOnTapOutside = NO;
    alert.customViewColor = [UIColor purpleColor];
    alert.showAnimationType = SCLAlertViewShowAnimationFadeIn;

    [alert addButton: @"Ok!" actionBlock: ^(void) {
        self.layer.opacity = 1.0f;
    }];

    [alert showInfo:title_ subTitle:description_ closeButtonTitle:nil duration:9999999.0f];
}

/*******************************************************************
    This method adds the given switch to the menu's scrollview.
    it also add's an action for when the switch is being clicked.
********************************************************************/
- (void)addSwitchToMenu:(id)switch_ {
    scrollViewHeight += 40;
    [scrollView addSubview:switch_];
}

- (void)addSwitchToMenu2:(id)switch_ {
    scrollView2Height += 50;
    scrollView2.contentSize = CGSizeMake(menuWidth, 350);
    [scrollView2 addSubview:switch_];
}

- (void)addSwitchToMenu3:(id)switch_ {
    scrollView3Height += 50;
    scrollView3.contentSize = CGSizeMake(menuWidth, 300+300+300+110);
    [scrollView3 addSubview:switch_];
}

- (void)addSwitchToMenu4:(id)switch_ {
    scrollView4Height += 50;
    scrollView4.contentSize = CGSizeMake(menuWidth, scrollViewHeight);
    [scrollView4 addSubview:switch_];
}


/*********************************************************************************************
    This method does the following handles the behaviour when a switch has been clicked
    TextfieldSwitch and SliderSwitch only change from color based on whether it's on or not.
    A OffsetSwitch does too, but it also applies offset patches
***********************************************************************************************/

-(void)setFrameworkName:(const char *)name_ {
    frameworkName = name_;
}

-(const char *)getFrameworkName {
    return frameworkName;
}
@end // End of menu class!


/********************************
    OFFSET SWITCH STARTS HERE!
*********************************/

@implementation OffsetSwitch {
    std::vector<MemoryPatch> memoryPatches;
}

- (id)initHackNamed:(NSString *)hackName_ description:(NSString *)description_ value:(float)value_ offsets:(std::vector<uint64_t>)offsets_ bytes:(std::vector<std::string>)bytes_ {
    description = description_;
    preferencesKey = hackName_;

    if(offsets_.size() != bytes_.size()){
        [menu showPopup:@"Invalid input count" description:[NSString stringWithFormat:@"Offsets array input count (%d) is not equal to the bytes array input count (%d)", (int)offsets_.size(), (int)bytes_.size()]];
    } else {
        // For each offset, we create a MemoryPatch.
        for(int i = 0; i < offsets_.size(); i++) {
            MemoryPatch patch = MemoryPatch::createWithHex([menu getFrameworkName], offsets_[i], bytes_[i]);
            if(patch.isValid()) {
              memoryPatches.push_back(patch);
            } else {
              [menu showPopup:@"Invalid patch" description:[NSString stringWithFormat:@"Failing offset: 0x%llx, please re-check the hex you entered.", offsets_[i]]];
            }
        }
    }


    self = [super initWithFrame:CGRectMake(-1, scrollViewX + scrollViewHeight - value_, 212.5, 40)];
    self.backgroundColor = [UIColor clearColor];
    self.layer.borderWidth = 0.5f;
    self.layer.borderColor = [UIColor clearColor].CGColor;

    switchLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, -4, menuWidth - 60, 50)];
    switchLabel.text = hackName_;
    switchLabel.textColor = switchTitleColor;
    switchLabel.font = [UIFont fontWithName:switchTitleFont size:16];
    switchLabel.adjustsFontSizeToFitWidth = true;
    switchLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:switchLabel];

UISwitch *toggleSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(3, 4, 0, 0)];
toggleSwitch.onTintColor = UIColorFromHex(0x202359);
toggleSwitch.layer.borderWidth = 1.5f;
toggleSwitch.layer.cornerRadius = 16.0;
toggleSwitch.layer.borderColor = UIColorFromHex(0x0070bf).CGColor;
[toggleSwitch setBackgroundColor:UIColorFromHex(0x202359)];
[toggleSwitch addTarget:self action:@selector(switchToggled:) forControlEvents: UIControlEventTouchUpInside];
[self addSubview:toggleSwitch];

    BOOL isOn = [defaults boolForKey:preferencesKey];
    if([[NSUserDefaults standardUserDefaults] objectForKey:preferencesKey] != nil)
    {
        [toggleSwitch setOn:isOn animated:YES];

        for(int Index = 0; Index < memoryPatches.size(); Index++)
        {
            if(isOn)
            {
                memoryPatches[Index].Modify();
            } else {
                memoryPatches[Index].Restore();
            }
        }
    }

    return self;
}
-(void)showInfo:(UIGestureRecognizer *)gestureRec {
    if(gestureRec.state == UIGestureRecognizerStateEnded) {
        [menu showPopup:[self getPreferencesKey] description:[self getDescription]];
        menu.layer.opacity = 0.0f;
    }
}

- (void) switchToggled:(id)sender_
{
    BOOL isOn = [sender_ isOn];
    for(int Index = 0; Index < memoryPatches.size(); Index++)
    {
        if(isOn)
        {
            memoryPatches[Index].Modify();
        } else {
            memoryPatches[Index].Restore();
        }
    }

    [defaults setBool:isOn forKey:preferencesKey];

        [UIView animateWithDuration:0.25 animations:^ {
if([switches isSwitchOn:@"Watermark"]){
watermark.layer.opacity = 1;
}else{
watermark.layer.opacity = 0;
}
}];
}



-(NSString *)getPreferencesKey {
    return preferencesKey;
}

-(NSString *)getDescription {
    return description;
}

- (std::vector<MemoryPatch>)getMemoryPatches {
    return memoryPatches;
}

@end //end of OffsetSwitch class


@implementation OffsetSwitchRight {
    std::vector<MemoryPatch> memoryPatches;
}

- (id)initHackRightNamed:(NSString *)hackName_ description:(NSString *)description_ value:(float)value_ offsets:(std::vector<uint64_t>)offsets_ bytes:(std::vector<std::string>)bytes_ {
    description = description_;
    preferencesKey = hackName_;

    if(offsets_.size() != bytes_.size()){
        [menu showPopup:@"Invalid input count" description:[NSString stringWithFormat:@"Offsets array input count (%d) is not equal to the bytes array input count (%d)", (int)offsets_.size(), (int)bytes_.size()]];
    } else {
        // For each offset, we create a MemoryPatch.
        for(int i = 0; i < offsets_.size(); i++) {
            MemoryPatch patch = MemoryPatch::createWithHex([menu getFrameworkName], offsets_[i], bytes_[i]);
            if(patch.isValid()) {
              memoryPatches.push_back(patch);
            } else {
              [menu showPopup:@"Invalid patch" description:[NSString stringWithFormat:@"Failing offset: 0x%llx, please re-check the hex you entered.", offsets_[i]]];
            }
        }
    }


    self = [super initWithFrame:CGRectMake(211.5, scrollViewX + scrollViewHeight - value_, 212.5, 40)];
    self.backgroundColor = [UIColor clearColor];
    self.layer.borderWidth = 0.5f;
    self.layer.borderColor = [UIColor clearColor].CGColor;

    switchLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, -4, menuWidth - 60, 50)];
    switchLabel.text = hackName_;
    switchLabel.textColor = switchTitleColor;
    switchLabel.font = [UIFont fontWithName:switchTitleFont size:16];
    switchLabel.adjustsFontSizeToFitWidth = true;
    switchLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:switchLabel];

UISwitch *toggleSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(3, 4, 0, 0)];
toggleSwitch.onTintColor = UIColorFromHex(0x202359);
toggleSwitch.layer.borderWidth = 1.5f;
toggleSwitch.layer.cornerRadius = 16.0;
toggleSwitch.layer.borderColor = UIColorFromHex(0x0070bf).CGColor;
[toggleSwitch setBackgroundColor:UIColorFromHex(0x202359)];
[toggleSwitch addTarget:self action:@selector(switchToggled:) forControlEvents: UIControlEventTouchUpInside];
[self addSubview:toggleSwitch];

    BOOL isOn = [defaults boolForKey:preferencesKey];
    if([[NSUserDefaults standardUserDefaults] objectForKey:preferencesKey] != nil)
    {
        [toggleSwitch setOn:isOn animated:YES];

        for(int Index = 0; Index < memoryPatches.size(); Index++)
        {
            if(isOn)
            {
                memoryPatches[Index].Modify();
            } else {
                memoryPatches[Index].Restore();
            }
        }
    }

    return self;
}
-(void)showInfo:(UIGestureRecognizer *)gestureRec {
    if(gestureRec.state == UIGestureRecognizerStateEnded) {
        [menu showPopup:[self getPreferencesKey] description:[self getDescription]];
        menu.layer.opacity = 0.0f;
    }
}

- (void) switchToggled:(id)sender_
{
    BOOL isOn = [sender_ isOn];
    for(int Index = 0; Index < memoryPatches.size(); Index++)
    {
        if(isOn)
        {
            memoryPatches[Index].Modify();
        } else {
            memoryPatches[Index].Restore();
        }
    }

    [defaults setBool:isOn forKey:preferencesKey];
}


-(NSString *)getPreferencesKey {
    return preferencesKey;
}

-(NSString *)getDescription {
    return description;
}

- (std::vector<MemoryPatch>)getMemoryPatches {
    return memoryPatches;
}

@end //end of OffsetSwitch class


/**************************************
    TEXTFIELD SWITCH STARTS HERE!
    - Note that this extends from OffsetSwitch.
***************************************/

@implementation TextFieldSwitch {
    UITextField *textfieldValue;
}

- (id)initTextfieldNamed:(NSString *)hackName_ description:(NSString *)description_ inputBorderColor:(UIColor *)inputBorderColor_ {
    preferencesKey = hackName_;
    switchValueKey = [hackName_ stringByApplyingTransform:NSStringTransformLatinToCyrillic reverse:false];
    description = description_;

    self = [super initWithFrame:CGRectMake(-1, scrollViewX + scrollViewHeight -1, menuWidth + 2, 40)];
    self.backgroundColor = [UIColor clearColor];
    self.layer.borderWidth = 0.5f;
    self.layer.borderColor = [UIColor clearColor].CGColor;

    switchLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 4, menuWidth - 60, 30)];
    switchLabel.text = hackName_;
    switchLabel.textColor = switchTitleColor;
    switchLabel.font = [UIFont fontWithName:switchTitleFont size:16];
    switchLabel.adjustsFontSizeToFitWidth = true;
    switchLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:switchLabel];

    textfieldValue = [[UITextField alloc]initWithFrame:CGRectMake(menuWidth / 3 - -20, switchLabel.self.bounds.origin.x - 20 + switchLabel.self.bounds.size.height, menuWidth / 4, 20)];
    textfieldValue.layer.borderWidth = 2.0f;
    textfieldValue.layer.borderColor = UIColorFromHex(0x0070bf).CGColor;
    textfieldValue.layer.cornerRadius = 8.0f;
    textfieldValue.textColor = switchTitleColor;
    textfieldValue.textAlignment = NSTextAlignmentCenter;
    textfieldValue.delegate = self;
    textfieldValue.backgroundColor = [UIColor clearColor];

    // get value from the plist & show it (if it's not empty).
    if([[NSUserDefaults standardUserDefaults] objectForKey:switchValueKey] != nil) {
        textfieldValue.text = [[NSUserDefaults standardUserDefaults] objectForKey:switchValueKey];
    }

    [self addSubview:textfieldValue];

UISwitch *toggleSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(3, 4, 0, 0)];
toggleSwitch.onTintColor = UIColorFromHex(0x202359);
toggleSwitch.layer.borderWidth = 1.5f;
toggleSwitch.layer.cornerRadius = 16.0;
toggleSwitch.layer.borderColor = UIColorFromHex(0x0070bf).CGColor;
[toggleSwitch setBackgroundColor:UIColorFromHex(0x202359)];
[toggleSwitch addTarget:self action:@selector(switchToggled:) forControlEvents: UIControlEventTouchUpInside];
[self addSubview:toggleSwitch];


    BOOL isOn = [defaults boolForKey:preferencesKey];
    if([[NSUserDefaults standardUserDefaults] objectForKey:preferencesKey] != nil)
    {
        [toggleSwitch setOn:isOn animated:YES];
    }


    return self;
}

// so when click "return" the keyboard goes way, got it from internet. Common thing apparantly
-(BOOL)textFieldShouldReturn:(UITextField*)textfieldValue_ {
    switchValueKey = [[self getPreferencesKey] stringByApplyingTransform:NSStringTransformLatinToCyrillic reverse:false];
    [defaults setObject:textfieldValue_.text forKey:[self getSwitchValueKey]];
    [textfieldValue_ resignFirstResponder];

    return true;
}

-(void) switchToggled:(id)sender_
{
    BOOL isOn = [sender_ isOn];
    [defaults setBool:isOn forKey:preferencesKey];
}

-(NSString *)getSwitchValueKey {
    return switchValueKey;
}

@end // end of TextFieldSwitch Class


/*******************************
    SLIDER SWITCH STARTS HERE!
    - Note that this extends from TextFieldSwitch
 *******************************/

@implementation SliderSwitch {
    UISlider *sliderValue;
    float valueOfSlider;
}

- (id)initSliderNamed:(NSString *)hackName_ description:(NSString *)description_ value:(float)value_ minimumValue:(float)minimumValue_ maximumValue:(float)maximumValue_ sliderColor:(UIColor *)sliderColor_{
    preferencesKey = hackName_;
    switchValueKey = [hackName_ stringByApplyingTransform:NSStringTransformLatinToCyrillic reverse:false];
    description = description_;

    self = [super initWithFrame:CGRectMake(-1, scrollViewX + scrollViewHeight - value_, menuWidth + 2, 40)];
    self.backgroundColor = [UIColor clearColor];
    self.layer.borderWidth = 0.5f;
    self.layer.borderColor = [UIColor clearColor].CGColor;

    switchLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 4, menuWidth - 60, 30)];
    switchLabel.text = hackName_;
    switchLabel.textColor = switchTitleColor;
    switchLabel.font = [UIFont fontWithName:switchTitleFont size:16];
    switchLabel.adjustsFontSizeToFitWidth = true;
    switchLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:switchLabel];

    switchLabel = [[UILabel alloc]initWithFrame:CGRectMake(385, 10, 30, 20)];
    switchLabel.text = [NSString stringWithFormat:@"%.1f", sliderValue.value];
    switchLabel.textColor = switchTitleColor;
    switchLabel.font = [UIFont fontWithName:switchTitleFont size:16];
    switchLabel.layer.cornerRadius = 8.0;
    switchLabel.adjustsFontSizeToFitWidth = true;
    switchLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:switchLabel];

    sliderValue = [[UISlider alloc]initWithFrame:CGRectMake(menuWidth / 3 - -50, switchLabel.self.bounds.origin.x - 10 + switchLabel.self.bounds.size.height, menuWidth / 4 + 20, 20)];
    sliderValue.thumbTintColor = [UIColor clearColor];
    sliderValue.minimumTrackTintColor = UIColorFromHex(0x0070bf);
    sliderValue.maximumTrackTintColor = UIColorFromHex(0xffffff);
    sliderValue.minimumValue = minimumValue_;
    sliderValue.maximumValue = maximumValue_;
    sliderValue.continuous = true;
    [sliderValue addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    valueOfSlider = sliderValue.value;

    // get value from the plist & show it (if it's not empty).
    if([[NSUserDefaults standardUserDefaults] objectForKey:switchValueKey] != nil) {
        sliderValue.value = [[NSUserDefaults standardUserDefaults] floatForKey:switchValueKey];
        switchLabel.text = [NSString stringWithFormat:@"%.1f", sliderValue.value];
    }

    [self addSubview:sliderValue];

UISwitch *toggleSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(3, 4, 0, 0)];
toggleSwitch.onTintColor = UIColorFromHex(0x202359);
toggleSwitch.layer.borderWidth = 1.5f;
toggleSwitch.layer.cornerRadius = 16.0;
toggleSwitch.layer.borderColor = UIColorFromHex(0x0070bf).CGColor;
[toggleSwitch setBackgroundColor:UIColorFromHex(0x202359)];
[toggleSwitch addTarget:self action:@selector(switchToggled:) forControlEvents: UIControlEventTouchUpInside];
[self addSubview:toggleSwitch];


    BOOL isOn = [defaults boolForKey:preferencesKey];
    if([[NSUserDefaults standardUserDefaults] objectForKey:preferencesKey] != nil)
    {
        [toggleSwitch setOn:isOn animated:YES];
    }


    return self;
}

-(void)sliderValueChanged:(UISlider *)slider_ {
    switchValueKey = [[self getPreferencesKey] stringByApplyingTransform:NSStringTransformLatinToCyrillic reverse:false];
    switchLabel.text = [NSString stringWithFormat:@"%.1f", slider_.value];
    [defaults setFloat:slider_.value forKey:[self getSwitchValueKey]];
}

-(void) switchToggled:(id)sender_
{
    BOOL isOn = [sender_ isOn];
    [defaults setBool:isOn forKey:preferencesKey];
}

@end // end of SliderSwitch class

@implementation SlidrSwitch {
    UISlider *sliderValue;
    float valueOfSlider;
}

- (id)initSlidrNamed:(NSString *)hackName_ description:(NSString *)description_ value:(float)value_ minimumValue:(float)minimumValue_ maximumValue:(float)maximumValue_ sliderColor:(UIColor *)sliderColor_{
    preferencesKey = hackName_;
    switchValueKey = [hackName_ stringByApplyingTransform:NSStringTransformLatinToCyrillic reverse:false];
    description = description_;

    self = [super initWithFrame:CGRectMake(-1, scrollViewX + scrollViewHeight - value_, menuWidth + 2, 40)];
    self.backgroundColor = [UIColor clearColor];
    self.layer.borderWidth = 0.5f;
    self.layer.borderColor = [UIColor clearColor].CGColor;

    switchLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, menuWidth - 60, 20)];
    switchLabel.text = [NSString stringWithFormat:@"%@ %.1f", hackName_, sliderValue.value];
    switchLabel.textColor = switchTitleColor;
    switchLabel.font = [UIFont fontWithName:switchTitleFont size:16];
    switchLabel.layer.cornerRadius = 8.0;
    switchLabel.adjustsFontSizeToFitWidth = true;
    switchLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:switchLabel];

    sliderValue = [[UISlider alloc]initWithFrame:CGRectMake(menuWidth / 3 - -50, switchLabel.self.bounds.origin.x - 10 + switchLabel.self.bounds.size.height, menuWidth / 4 + 20, 20)];
    sliderValue.thumbTintColor = [UIColor clearColor];
    sliderValue.minimumTrackTintColor = UIColorFromHex(0x0070bf);
    sliderValue.maximumTrackTintColor = UIColorFromHex(0xffffff);
    sliderValue.minimumValue = minimumValue_;
    sliderValue.maximumValue = maximumValue_;
    sliderValue.continuous = true;
    [sliderValue addTarget:self action:@selector(slidrValueChanged:) forControlEvents:UIControlEventValueChanged];
    valueOfSlider = sliderValue.value;

    // get value from the plist & show it (if it's not empty).
    if([[NSUserDefaults standardUserDefaults] objectForKey:switchValueKey] != nil) {
        sliderValue.value = [[NSUserDefaults standardUserDefaults] floatForKey:switchValueKey];
        switchLabel.text = [NSString stringWithFormat:@"%@ %.1f", hackName_, sliderValue.value];
    }

    [self addSubview:sliderValue];

    return self;
}

-(void)slidrValueChanged:(UISlider *)slider_ {
    switchValueKey = [[self getPreferencesKey] stringByApplyingTransform:NSStringTransformLatinToCyrillic reverse:false];
    switchLabel.text = [NSString stringWithFormat:@"%@ %.1f", [self getPreferencesKey], slider_.value];
    [defaults setFloat:slider_.value forKey:[self getSwitchValueKey]];
}

@end // end of SliderSwitch class

@implementation EachSwitch {
}

- (id)initEachNamed:(NSString *)hackName_ {
    preferencesKey = hackName_;

    self = [super initWithFrame:CGRectMake(0, scrollViewX + scrollViewHeight - 0, menuWidth, 35)];
    self.backgroundColor = [UIColor clearColor];
    self.layer.borderWidth = 0.5f;
    self.hidden = YES;

    switchLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, -6, menuWidth - 60, 50)];
    switchLabel.text = hackName_;
    switchLabel.textColor = switchTitleColor;
    switchLabel.font = [UIFont fontWithName:@"AvenirNextCondensed-DemiBold" size:16];
    switchLabel.adjustsFontSizeToFitWidth = true;
    switchLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:switchLabel];

    return self;
}


-(NSString *)getPreferencesKey {
    return preferencesKey;
}

@end


@implementation Switches


-(void)addSwitch:(NSString *)hackName_ description:(NSString *)description_ value:(float)value_{
    OffsetSwitch *offsetPatch = [[OffsetSwitch alloc]initHackNamed:hackName_ description:description_ value:value_ offsets:std::vector<uint64_t>{} bytes:std::vector<std::string>{}];
    [menu addSwitchToMenu:offsetPatch];

}

-(void)addSwitch2:(NSString *)hackName_ description:(NSString *)description_ value:(float)value_{
    OffsetSwitch *offsetPatch = [[OffsetSwitch alloc]initHackNamed:hackName_ description:description_ value:value_ offsets:std::vector<uint64_t>{} bytes:std::vector<std::string>{}];
    [menu addSwitchToMenu2:offsetPatch];

}

-(void)addSwitch3:(NSString *)hackName_ description:(NSString *)description_ value:(float)value_{
    OffsetSwitch *offsetPatch = [[OffsetSwitch alloc]initHackNamed:hackName_ description:description_
value:value_ offsets:std::vector<uint64_t>{} bytes:std::vector<std::string>{}];
    [menu addSwitchToMenu3:offsetPatch];

}

-(void)addSwitch4:(NSString *)hackName_ description:(NSString *)description_ value:(float)value_{
    OffsetSwitch *offsetPatch = [[OffsetSwitch alloc]initHackNamed:hackName_ description:description_ value:value_ offsets:std::vector<uint64_t>{} bytes:std::vector<std::string>{}];
    [menu addSwitchToMenu4:offsetPatch];

}

-(void)addRightSwitch:(NSString *)hackName_ description:(NSString *)description_ value:(float)value_{
    OffsetSwitchRight *offsetRightPatch = [[OffsetSwitchRight alloc]initHackRightNamed:hackName_ description:description_ value:value_ offsets:std::vector<uint64_t>{} bytes:std::vector<std::string>{}];
    [menu addSwitchToMenu:offsetRightPatch];

}

-(void)addRightSwitch2:(NSString *)hackName_ description:(NSString *)description_ value:(float)value_{
    OffsetSwitchRight *offsetRightPatch = [[OffsetSwitchRight alloc]initHackRightNamed:hackName_ description:description_ value:value_ offsets:std::vector<uint64_t>{} bytes:std::vector<std::string>{}];
    [menu addSwitchToMenu2:offsetRightPatch];

}

-(void)addRightSwitch3:(NSString *)hackName_ description:(NSString *)description_ value:(float)value_{
    OffsetSwitchRight *offsetRightPatch = [[OffsetSwitchRight alloc]initHackRightNamed:hackName_ description:description_ value:value_ offsets:std::vector<uint64_t>{} bytes:std::vector<std::string>{}];
    [menu addSwitchToMenu3:offsetRightPatch];

}

-(void)addRightSwitch4:(NSString *)hackName_ description:(NSString *)description_ value:(float)value_{
    OffsetSwitchRight *offsetRightPatch = [[OffsetSwitchRight alloc]initHackRightNamed:hackName_ description:description_ value:value_ offsets:std::vector<uint64_t>{} bytes:std::vector<std::string>{}];
    [menu addSwitchToMenu4:offsetRightPatch];

}

- (void)addOffsetSwitchRight:(NSString *)hackName_ description:(NSString *)description_ value:(float)value_ offsets:(std::initializer_list<uint64_t>)offsets_ bytes:(std::initializer_list<std::string>)bytes_ {
    std::vector<uint64_t> offsetVector;
    std::vector<std::string> bytesVector;

    offsetVector.insert(offsetVector.begin(), offsets_.begin(), offsets_.end());
    bytesVector.insert(bytesVector.begin(), bytes_.begin(), bytes_.end());

    OffsetSwitchRight *offsetRightPatch = [[OffsetSwitchRight alloc]initHackRightNamed:hackName_ description:description_ value:value_ offsets:offsetVector bytes:bytesVector];
    [menu addSwitchToMenu:offsetRightPatch];
}

- (void)addOffsetSwitchRight2:(NSString *)hackName_ description:(NSString *)description_ value:(float)value_ offsets:(std::initializer_list<uint64_t>)offsets_ bytes:(std::initializer_list<std::string>)bytes_ {
    std::vector<uint64_t> offsetVector;
    std::vector<std::string> bytesVector;

    offsetVector.insert(offsetVector.begin(), offsets_.begin(), offsets_.end());
    bytesVector.insert(bytesVector.begin(), bytes_.begin(), bytes_.end());

    OffsetSwitchRight *offsetRightPatch = [[OffsetSwitchRight alloc]initHackRightNamed:hackName_ description:description_ value:value_ offsets:offsetVector bytes:bytesVector];
    [menu addSwitchToMenu2:offsetRightPatch];
}

- (void)addOffsetSwitchRight3:(NSString *)hackName_ description:(NSString *)description_ value:(float)value_ offsets:(std::initializer_list<uint64_t>)offsets_ bytes:(std::initializer_list<std::string>)bytes_ {
    std::vector<uint64_t> offsetVector;
    std::vector<std::string> bytesVector;

    offsetVector.insert(offsetVector.begin(), offsets_.begin(), offsets_.end());
    bytesVector.insert(bytesVector.begin(), bytes_.begin(), bytes_.end());

    OffsetSwitchRight *offsetRightPatch = [[OffsetSwitchRight alloc]initHackRightNamed:hackName_ description:description_ value:value_ offsets:offsetVector bytes:bytesVector];
    [menu addSwitchToMenu3:offsetRightPatch];
}


- (void)addOffsetSwitchRight4:(NSString *)hackName_ description:(NSString *)description_ value:(float)value_ offsets:(std::initializer_list<uint64_t>)offsets_ bytes:(std::initializer_list<std::string>)bytes_ {
    std::vector<uint64_t> offsetVector;
    std::vector<std::string> bytesVector;

    offsetVector.insert(offsetVector.begin(), offsets_.begin(), offsets_.end());
    bytesVector.insert(bytesVector.begin(), bytes_.begin(), bytes_.end());

    OffsetSwitchRight *offsetRightPatch = [[OffsetSwitchRight alloc]initHackRightNamed:hackName_ description:description_ value:value_ offsets:offsetVector bytes:bytesVector];
    [menu addSwitchToMenu4:offsetRightPatch];
}

- (void)addOffsetSwitch:(NSString *)hackName_ description:(NSString *)description_ value:(float)value_ offsets:(std::initializer_list<uint64_t>)offsets_ bytes:(std::initializer_list<std::string>)bytes_ {
    std::vector<uint64_t> offsetVector;
    std::vector<std::string> bytesVector;

    offsetVector.insert(offsetVector.begin(), offsets_.begin(), offsets_.end());
    bytesVector.insert(bytesVector.begin(), bytes_.begin(), bytes_.end());

    OffsetSwitch *offsetPatch = [[OffsetSwitch alloc]initHackNamed:hackName_ description:description_ value:value_ offsets:offsetVector bytes:bytesVector];
    [menu addSwitchToMenu:offsetPatch];
}

- (void)addOffsetSwitch2:(NSString *)hackName_ description:(NSString *)description_ value:(float)value_ offsets:(std::initializer_list<uint64_t>)offsets_ bytes:(std::initializer_list<std::string>)bytes_ {
    std::vector<uint64_t> offsetVector;
    std::vector<std::string> bytesVector;

    offsetVector.insert(offsetVector.begin(), offsets_.begin(), offsets_.end());
    bytesVector.insert(bytesVector.begin(), bytes_.begin(), bytes_.end());

    OffsetSwitch *offsetPatch = [[OffsetSwitch alloc]initHackNamed:hackName_ description:description_ value:value_ offsets:offsetVector bytes:bytesVector];
    [menu addSwitchToMenu2:offsetPatch];
}

- (void)addOffsetSwitch3:(NSString *)hackName_ description:(NSString *)description_ value:(float)value_ offsets:(std::initializer_list<uint64_t>)offsets_ bytes:(std::initializer_list<std::string>)bytes_ {
    std::vector<uint64_t> offsetVector;
    std::vector<std::string> bytesVector;

    offsetVector.insert(offsetVector.begin(), offsets_.begin(), offsets_.end());
    bytesVector.insert(bytesVector.begin(), bytes_.begin(), bytes_.end());

    OffsetSwitch *offsetPatch = [[OffsetSwitch alloc]initHackNamed:hackName_ description:description_ value:value_ offsets:offsetVector bytes:bytesVector];
    [menu addSwitchToMenu3:offsetPatch];
}

- (void)addOffsetSwitch4:(NSString *)hackName_ description:(NSString *)description_ value:(float)value_ offsets:(std::initializer_list<uint64_t>)offsets_ bytes:(std::initializer_list<std::string>)bytes_ {
    std::vector<uint64_t> offsetVector;
    std::vector<std::string> bytesVector;

    offsetVector.insert(offsetVector.begin(), offsets_.begin(), offsets_.end());
    bytesVector.insert(bytesVector.begin(), bytes_.begin(), bytes_.end());

    OffsetSwitch *offsetPatch = [[OffsetSwitch alloc]initHackNamed:hackName_ description:description_ value:value_ offsets:offsetVector bytes:bytesVector];
    [menu addSwitchToMenu4:offsetPatch];
}

- (void)addTextfieldSwitch:(NSString *)hackName_ description:(NSString *)description_ inputBorderColor:(UIColor *)inputBorderColor_ {
    TextFieldSwitch *textfieldSwitch = [[TextFieldSwitch alloc]initTextfieldNamed:hackName_ description:description_ inputBorderColor:inputBorderColor_];
    [menu addSwitchToMenu:textfieldSwitch];
}

- (void)addTextfieldSwitch2:(NSString *)hackName_ description:(NSString *)description_ inputBorderColor:(UIColor *)inputBorderColor_ {
    TextFieldSwitch *textfieldSwitch = [[TextFieldSwitch alloc]initTextfieldNamed:hackName_ description:description_ inputBorderColor:inputBorderColor_];
    [menu addSwitchToMenu2:textfieldSwitch];
}


- (void)addTextfieldSwitch3:(NSString *)hackName_ description:(NSString *)description_ inputBorderColor:(UIColor *)inputBorderColor_ {
    TextFieldSwitch *textfieldSwitch = [[TextFieldSwitch alloc]initTextfieldNamed:hackName_ description:description_ inputBorderColor:inputBorderColor_];
    [menu addSwitchToMenu3:textfieldSwitch];
}


- (void)addTextfieldSwitch4:(NSString *)hackName_ description:(NSString *)description_ inputBorderColor:(UIColor *)inputBorderColor_ {
    TextFieldSwitch *textfieldSwitch = [[TextFieldSwitch alloc]initTextfieldNamed:hackName_ description:description_ inputBorderColor:inputBorderColor_];
    [menu addSwitchToMenu4:textfieldSwitch];
}


- (void)addSliderSwitch:(NSString *)hackName_ description:(NSString *)description_ value:(float)value_ minimumValue:(float)minimumValue_ maximumValue:(float)maximumValue_ sliderColor:(UIColor *)sliderColor_ {
    SliderSwitch *sliderSwitch = [[SliderSwitch alloc] initSliderNamed:hackName_ description:description_ value:value_ minimumValue:minimumValue_ maximumValue:maximumValue_ sliderColor:sliderColor_];
    [menu addSwitchToMenu:sliderSwitch];
}

- (void)addSliderSwitch2:(NSString *)hackName_ description:(NSString *)description_ value:(float)value_ minimumValue:(float)minimumValue_ maximumValue:(float)maximumValue_ sliderColor:(UIColor *)sliderColor_ {
    SliderSwitch *sliderSwitch = [[SliderSwitch alloc] initSliderNamed:hackName_ description:description_ value:value_ minimumValue:minimumValue_ maximumValue:maximumValue_ sliderColor:sliderColor_];
    [menu addSwitchToMenu2:sliderSwitch];
}

- (void)addSliderSwitch3:(NSString *)hackName_ description:(NSString *)description_ value:(float)value_ minimumValue:(float)minimumValue_ maximumValue:(float)maximumValue_ sliderColor:(UIColor *)sliderColor_ {
    SliderSwitch *sliderSwitch = [[SliderSwitch alloc] initSliderNamed:hackName_ description:description_ value:value_ minimumValue:minimumValue_ maximumValue:maximumValue_ sliderColor:sliderColor_];
    [menu addSwitchToMenu3:sliderSwitch];
}

- (void)addSliderSwitch4:(NSString *)hackName_ description:(NSString *)description_ value:(float)value_ minimumValue:(float)minimumValue_ maximumValue:(float)maximumValue_ sliderColor:(UIColor *)sliderColor_ {
    SliderSwitch *sliderSwitch = [[SliderSwitch alloc] initSliderNamed:hackName_ description:description_ value:value_ minimumValue:minimumValue_ maximumValue:maximumValue_ sliderColor:sliderColor_];
    [menu addSwitchToMenu4:sliderSwitch];
}

- (void)addSlidrSwitch:(NSString *)hackName_ description:(NSString *)description_ value:(float)value_ minimumValue:(float)minimumValue_ maximumValue:(float)maximumValue_ sliderColor:(UIColor *)sliderColor_ {
    SlidrSwitch *slidrSwitch = [[SlidrSwitch alloc] initSlidrNamed:hackName_ description:description_ value:value_ minimumValue:minimumValue_ maximumValue:maximumValue_ sliderColor:sliderColor_];
    [menu addSwitchToMenu:slidrSwitch];
}
- (void)addSlidrSwitch2:(NSString *)hackName_ description:(NSString *)description_ value:(float)value_ minimumValue:(float)minimumValue_ maximumValue:(float)maximumValue_ sliderColor:(UIColor *)sliderColor_ {
    SlidrSwitch *slidrSwitch = [[SlidrSwitch alloc] initSlidrNamed:hackName_ description:description_ value:value_ minimumValue:minimumValue_ maximumValue:maximumValue_ sliderColor:sliderColor_];
    [menu addSwitchToMenu2:slidrSwitch];
}

- (void)addSlidrSwitch3:(NSString *)hackName_ description:(NSString *)description_ value:(float)value_ minimumValue:(float)minimumValue_ maximumValue:(float)maximumValue_ sliderColor:(UIColor *)sliderColor_ {
    SlidrSwitch *slidrSwitch = [[SlidrSwitch alloc] initSlidrNamed:hackName_ description:description_ value:value_ minimumValue:minimumValue_ maximumValue:maximumValue_ sliderColor:sliderColor_];
    [menu addSwitchToMenu3:slidrSwitch];
}

- (void)addSlidrSwitch4:(NSString *)hackName_ description:(NSString *)description_ value:(float)value_ minimumValue:(float)minimumValue_ maximumValue:(float)maximumValue_ sliderColor:(UIColor *)sliderColor_ {
    SlidrSwitch *slidrSwitch = [[SlidrSwitch alloc] initSlidrNamed:hackName_ description:description_ value:value_ minimumValue:minimumValue_ maximumValue:maximumValue_ sliderColor:sliderColor_];
    [menu addSwitchToMenu4:slidrSwitch];
}



- (void)addEachSwitch:(NSString *)hackName_ {
    EachSwitch *eachSwitch = [[EachSwitch alloc] initEachNamed:hackName_];
    [menu addSwitchToMenu:eachSwitch];
}

- (NSString *)getValueFromSwitch:(NSString *)name {

    //getting the correct key for the saved input.
    NSString *correctKey =  [name stringByApplyingTransform:NSStringTransformLatinToCyrillic reverse:false];

    if([[NSUserDefaults standardUserDefaults] objectForKey:correctKey]) {
        return [[NSUserDefaults standardUserDefaults] objectForKey:correctKey];
    }
    else if([[NSUserDefaults standardUserDefaults] floatForKey:correctKey]) {
        NSString *sliderValue = [NSString stringWithFormat:@"%f", [[NSUserDefaults standardUserDefaults] floatForKey:correctKey]];
        return sliderValue;
    }

    return 0;
}

-(bool)isSwitchOn:(NSString *)switchName {
    return [[NSUserDefaults standardUserDefaults] boolForKey:switchName];
}

@end
