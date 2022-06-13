//
//  Menu.h
//  ModMenu
//
//  Created by Jayce on 0/0/2022.
//  Copyright © 2021 Jayce. All rights reserved.
//

#import "UIKit/UIKit.h"
#import "KittyMemory/MemoryPatch.hpp"
#import "SCLAlertView/SCLAlertView.h"

#import <vector>
#import <initializer_list>

@class OffsetSwitch;
@class OffsetSwitch1;
@class OffsetSwitch2;
@class OffsetSwitch3;
@class OffsetSwitch4;
@class TextFieldSwitch;
@class TextFieldSwitch1;
@class TextFieldSwitch2;
@class TextFieldSwitch3;
@class TextFieldSwitch4;
@class SliderSwitch;
@class SliderSwitch1;
@class SliderSwitch2;
@class SliderSwitch3;
@class SliderSwitch4;
@class Switches;

@interface Menu : UIView

-(id)initWithTitle:(NSString *)title_ watermarkText:(NSString *)watermarkText_ watermarkTextColor:(UIColor *)watermarkTextColor_ watermarkVisible:(float)watermarkVisible_ titleColor:(UIColor *)titleColor_ titleFont:(NSString *)titleFont_ credits:(NSString *)credits_ initWithTitle:(NSString *)footerTitle_ titleColor:(UIColor *)footerTitleColor_ titleFont:(NSString *)footerTitleFont_ initWithTitle:(NSString *)footerTitle1_ titleColor:(UIColor *)footerTitleColor1_ titleFont:(NSString *)footerTitleFont1_
headerColor:(UIColor *)headerColor_ switchOffColor:(UIColor *)switchOffColor_ switchOnColor:(UIColor *)switchOnColor_ switchTitleFont:(NSString *)switchTitleFont_ switchTitleColor:(UIColor *)switchTitleColor_ infoButtonColor:(UIColor *)infoButtonColor_   maxVisibleSwitches:(int)maxVisibleSwitches_ menuWidth:(CGFloat )menuWidth_ menuIcon:(NSString *)menuIconBase64_ menuButton:(NSString *)menuButtonBase64_;
-(void)setFrameworkName:(const char *)name_;
-(const char *)getFrameworkName;


-(void)showMenuButton;
-(void)addSwitchToMenu:(id)switch_;
-(void)showPopup:(NSString *)title_ description:(NSString *)description_;

@end

@interface OffsetSwitch : UIButton {
	NSString *preferencesKey;
	NSString *description;
    UILabel *switchLabel;
}

- (id)initHackNamed:(NSString *)hackName_ description:(NSString *)description_ offsets:(std::vector<uint64_t>)offsets_ bytes:(std::vector<std::string>)bytes_;
-(void)showInfo:(UIGestureRecognizer *)gestureRec;

-(NSString *)getPreferencesKey;
-(NSString *)getDescription;
- (std::vector<MemoryPatch>)getMemoryPatches;


@end

@interface OffsetSwitch2 : UIButton {
	NSString *preferencesKey;
	NSString *description;
    UILabel *switchLabel;
}

- (id)initHackNamed2:(NSString *)hackName_ description:(NSString *)description_ offsets:(std::vector<uint64_t>)offsets_ bytes:(std::vector<std::string>)bytes_;
-(void)showInfo:(UIGestureRecognizer *)gestureRec;

-(NSString *)getPreferencesKey;
-(NSString *)getDescription;
- (std::vector<MemoryPatch>)getMemoryPatches;


@end

@interface OffsetSwitch3 : UIButton {
	NSString *preferencesKey;
	NSString *description;
    UILabel *switchLabel;
}

- (id)initHackNamed3:(NSString *)hackName_ description:(NSString *)description_ offsets:(std::vector<uint64_t>)offsets_ bytes:(std::vector<std::string>)bytes_;
-(void)showInfo:(UIGestureRecognizer *)gestureRec;

-(NSString *)getPreferencesKey;
-(NSString *)getDescription;
- (std::vector<MemoryPatch>)getMemoryPatches;


@end

@interface OffsetSwitch4 : UIButton {
	NSString *preferencesKey;
	NSString *description;
    UILabel *switchLabel;
}

- (id)initHackNamed4:(NSString *)hackName_ description:(NSString *)description_ offsets:(std::vector<uint64_t>)offsets_ bytes:(std::vector<std::string>)bytes_;
-(void)showInfo:(UIGestureRecognizer *)gestureRec;

-(NSString *)getPreferencesKey;
-(NSString *)getDescription;
- (std::vector<MemoryPatch>)getMemoryPatches;


@end

@interface TextFieldSwitch : OffsetSwitch<UITextFieldDelegate> {
	NSString *switchValueKey;
}

- (id)initTextfieldNamed:(NSString *)hackName_ description:(NSString *)description_ inputBorderColor:(UIColor *)inputBorderColor_;

-(NSString *)getSwitchValueKey;

@end

@interface TextFieldSwitch2 : OffsetSwitch<UITextFieldDelegate> {
	NSString *switchValueKey;
}

- (id)initTextfieldNamed2:(NSString *)hackName_ description:(NSString *)description_ inputBorderColor:(UIColor *)inputBorderColor_;

-(NSString *)getSwitchValueKey;

@end

@interface TextFieldSwitch3 : OffsetSwitch<UITextFieldDelegate> {
	NSString *switchValueKey;
}

- (id)initTextfieldNamed3:(NSString *)hackName_ description:(NSString *)description_ inputBorderColor:(UIColor *)inputBorderColor_;

-(NSString *)getSwitchValueKey;

@end

@interface TextFieldSwitch4 : OffsetSwitch<UITextFieldDelegate> {
	NSString *switchValueKey;
}

- (id)initTextfieldNamed4:(NSString *)hackName_ description:(NSString *)description_ inputBorderColor:(UIColor *)inputBorderColor_;

-(NSString *)getSwitchValueKey;

@end

@interface SliderSwitch : TextFieldSwitch

- (id)initSliderNamed:(NSString *)hackName_ description:(NSString *)description_ minimumValue:(float)minimumValue_ maximumValue:(float)maximumValue_ sliderColor:(UIColor *)sliderColor_;

@end
@interface SliderSwitch2 : TextFieldSwitch

- (id)initSliderNamed2:(NSString *)hackName_ description:(NSString *)description_ minimumValue:(float)minimumValue_ maximumValue:(float)maximumValue_ sliderColor:(UIColor *)sliderColor_;

@end

@interface SliderSwitch3 : TextFieldSwitch

- (id)initSliderNamed3:(NSString *)hackName_ description:(NSString *)description_ minimumValue:(float)minimumValue_ maximumValue:(float)maximumValue_ sliderColor:(UIColor *)sliderColor_;

@end

@interface SliderSwitch4 : TextFieldSwitch

- (id)initSliderNamed4:(NSString *)hackName_ description:(NSString *)description_ minimumValue:(float)minimumValue_ maximumValue:(float)maximumValue_ sliderColor:(UIColor *)sliderColor_;

@end

@interface Switches : UIButton

-(void)addSwitch:(NSString *)hackName_ description:(NSString *)description_;

-(void)addSwitch1:(NSString *)hackName_ description:(NSString *)description_;

-(void)addSwitch2:(NSString *)hackName_ description:(NSString *)description_;

-(void)addSwitch3:(NSString *)hackName_ description:(NSString *)description_;

-(void)addSwitch4:(NSString *)hackName_ description:(NSString *)description_;

- (void)addOffsetSwitch:(NSString *)hackName_ description:(NSString *)description_ offsets:(std::initializer_list<uint64_t>)offsets_ bytes:(std::initializer_list<std::string>)bytes_;

- (void)addOffsetSwitch2:(NSString *)hackName_ description:(NSString *)description_ offsets:(std::initializer_list<uint64_t>)offsets_ bytes:(std::initializer_list<std::string>)bytes_;

- (void)addOffsetSwitch3:(NSString *)hackName_ description:(NSString *)description_ offsets:(std::initializer_list<uint64_t>)offsets_ bytes:(std::initializer_list<std::string>)bytes_;

- (void)addOffsetSwitch4:(NSString *)hackName_ description:(NSString *)description_ offsets:(std::initializer_list<uint64_t>)offsets_ bytes:(std::initializer_list<std::string>)bytes_;

- (void)addTextfieldSwitch:(NSString *)hackName_ description:(NSString *)description_ inputBorderColor:(UIColor *)inputBorderColor_;

- (void)addTextfieldSwitch2:(NSString *)hackName_ description:(NSString *)description_ inputBorderColor:(UIColor *)inputBorderColor_;

- (void)addTextfieldSwitch3:(NSString *)hackName_ description:(NSString *)description_ inputBorderColor:(UIColor *)inputBorderColor_;

- (void)addTextfieldSwitch4:(NSString *)hackName_ description:(NSString *)description_ inputBorderColor:(UIColor *)inputBorderColor_;

- (void)addSliderSwitch:(NSString *)hackName_ description:(NSString *)description_ minimumValue:(float)minimumValue_ maximumValue:(float)maximumValue_ sliderColor:(UIColor *)sliderColor_;

- (void)addSliderSwitch2:(NSString *)hackName_ description:(NSString *)description_ minimumValue:(float)minimumValue_ maximumValue:(float)maximumValue_ sliderColor:(UIColor *)sliderColor_;

- (void)addSliderSwitch3:(NSString *)hackName_ description:(NSString *)description_ minimumValue:(float)minimumValue_ maximumValue:(float)maximumValue_ sliderColor:(UIColor *)sliderColor_;

- (void)addSliderSwitch4:(NSString *)hackName_ description:(NSString *)description_ minimumValue:(float)minimumValue_ maximumValue:(float)maximumValue_ sliderColor:(UIColor *)sliderColor_;

- (NSString *)getValueFromSwitch:(NSString *)name;
-(bool)isSwitchOn:(NSString *)switchName;

@end
