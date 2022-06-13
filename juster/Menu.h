//
//  Menu.h
//  ModMenu
//
//  Created by Joey on 3/14/19.
//  Copyright © 2019 Joey. All rights reserved.
//

#import "UIKit/UIKit.h"
#import "KittyMemory/MemoryPatch.hpp"
#import "SCLAlertView/SCLAlertView.h"

#import <vector>
#import <initializer_list>

@class OffsetSwitchRight;
@class OffsetSwitchRight2;
@class OffsetSwitchRight3;
@class OffsetSwitchRight4;
@class OffsetSwitch;
@class OffsetSwitch2;
@class OffsetSwitch3;
@class OffsetSwitch4;
@class TextFieldSwitch;
@class TextFieldSwitch2;
@class TextFieldSwitch3;
@class TextFieldSwitch4;
@class SliderSwitch;
@class SliderSwitch2;
@class SliderSwitch3;
@class SliderSwitch4;
@class SlidrSwitch;
@class SlidrSwitch2;
@class SlidrSwitch3;
@class SlidrSwitch4;
@class EachSwitch;
@class Switches;

@interface Menu : UIView

-(id)initWithTitle:(NSString *)title_ titleColor:(UIColor *)titleColor_ titleFont:(NSString *)titleFont_ credits:(NSString *)credits_ headerColor:(UIColor *)headerColor_ switchOffColor:(UIColor *)switchOffColor_ switchOnColor:(UIColor *)switchOnColor_ switchTitleFont:(NSString *)switchTitleFont_ switchTitleColor:(UIColor *)switchTitleColor_ infoButtonColor:(UIColor *)infoButtonColor_ maxVisibleSwitches:(int)maxVisibleSwitches_ menuWidth:(CGFloat )menuWidth_ menuIcon:(NSString *)menuIconBase64_ menuButton:(NSString *)menuButtonBase64_;
-(void)setFrameworkName:(const char *)name_;
-(const char *)getFrameworkName;


-(void)showMenuButton;
-(void)addSwitchToMenu:(id)switch_;
-(void)showPopup:(NSString *)title_ description:(NSString *)description_;

@end

@interface OffsetSwitchRight : UIButton {
	NSString *preferencesKey;
	NSString *description;
    UILabel *switchLabel;
}

- (id)initHackRightNamed:(NSString *)hackName_ description:(NSString *)description_ value:(float)value_ offsets:(std::vector<uint64_t>)offsets_ bytes:(std::vector<std::string>)bytes_;
-(void)showInfo:(UIGestureRecognizer *)gestureRec;

-(NSString *)getPreferencesKey;
-(NSString *)getDescription;
- (std::vector<MemoryPatch>)getMemoryPatches;


@end

@interface OffsetSwitchRight2 : UIButton {
	NSString *preferencesKey;
	NSString *description;
    UILabel *switchLabel;
}

- (id)initHackRightNamed:(NSString *)hackName_ description:(NSString *)description_ value:(float)value_ offsets:(std::vector<uint64_t>)offsets_ bytes:(std::vector<std::string>)bytes_;
-(void)showInfo:(UIGestureRecognizer *)gestureRec;

-(NSString *)getPreferencesKey;
-(NSString *)getDescription;
- (std::vector<MemoryPatch>)getMemoryPatches;


@end

@interface OffsetSwitchRight3 : UIButton {
	NSString *preferencesKey;
	NSString *description;
    UILabel *switchLabel;
}

- (id)initHackRightNamed:(NSString *)hackName_ description:(NSString *)description_ value:(float)value_ offsets:(std::vector<uint64_t>)offsets_ bytes:(std::vector<std::string>)bytes_;
-(void)showInfo:(UIGestureRecognizer *)gestureRec;

-(NSString *)getPreferencesKey;
-(NSString *)getDescription;
- (std::vector<MemoryPatch>)getMemoryPatches;


@end

@interface OffsetSwitchRight4 : UIButton {
	NSString *preferencesKey;
	NSString *description;
    UILabel *switchLabel;
}

- (id)initHackRightNamed:(NSString *)hackName_ description:(NSString *)description_ value:(float)value_ offsets:(std::vector<uint64_t>)offsets_ bytes:(std::vector<std::string>)bytes_;
-(void)showInfo:(UIGestureRecognizer *)gestureRec;

-(NSString *)getPreferencesKey;
-(NSString *)getDescription;
- (std::vector<MemoryPatch>)getMemoryPatches;


@end

@interface OffsetSwitch : UIButton {
	NSString *preferencesKey;
	NSString *description;
    UILabel *switchLabel;
}

- (id)initHackNamed:(NSString *)hackName_ description:(NSString *)description_ value:(float)value_ offsets:(std::vector<uint64_t>)offsets_ bytes:(std::vector<std::string>)bytes_;
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

- (id)initHackNamed:(NSString *)hackName_ description:(NSString *)description_ value:(float)value_ offsets:(std::vector<uint64_t>)offsets_ bytes:(std::vector<std::string>)bytes_;
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

- (id)initHackNamed:(NSString *)hackName_ description:(NSString *)description_ value:(float)value_ offsets:(std::vector<uint64_t>)offsets_ bytes:(std::vector<std::string>)bytes_;
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

- (id)initHackNamed:(NSString *)hackName_ description:(NSString *)description_ value:(float)value_ offsets:(std::vector<uint64_t>)offsets_ bytes:(std::vector<std::string>)bytes_;
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

- (id)initTextfieldNamed:(NSString *)hackName_ description:(NSString *)description_ inputBorderColor:(UIColor *)inputBorderColor_;

-(NSString *)getSwitchValueKey;

@end

@interface TextFieldSwitch3 : OffsetSwitch<UITextFieldDelegate> {
	NSString *switchValueKey;
}

- (id)initTextfieldNamed:(NSString *)hackName_ description:(NSString *)description_ inputBorderColor:(UIColor *)inputBorderColor_;

-(NSString *)getSwitchValueKey;

@end

@interface TextFieldSwitch4 : OffsetSwitch<UITextFieldDelegate> {
	NSString *switchValueKey;
}

- (id)initTextfieldNamed:(NSString *)hackName_ description:(NSString *)description_ inputBorderColor:(UIColor *)inputBorderColor_;

-(NSString *)getSwitchValueKey;

@end

@interface SlidrSwitch : TextFieldSwitch

- (id)initSlidrNamed:(NSString *)hackName_ description:(NSString *)description_ value:(float)value_ minimumValue:(float)minimumValue_ maximumValue:(float)maximumValue_ sliderColor:(UIColor *)sliderColor_;

@end

@interface SlidrSwitch2 : TextFieldSwitch

- (id)initSlidrNamed:(NSString *)hackName_ description:(NSString *)description_ value:(float)value_ minimumValue:(float)minimumValue_ maximumValue:(float)maximumValue_ sliderColor:(UIColor *)sliderColor_;

@end

@interface SlidrSwitch3 : TextFieldSwitch

- (id)initSlidrNamed:(NSString *)hackName_ description:(NSString *)description_ value:(float)value_ minimumValue:(float)minimumValue_ maximumValue:(float)maximumValue_ sliderColor:(UIColor *)sliderColor_;

@end

@interface SlidrSwitch4 : TextFieldSwitch

- (id)initSlidrNamed:(NSString *)hackName_ description:(NSString *)description_ value:(float)value_ minimumValue:(float)minimumValue_ maximumValue:(float)maximumValue_ sliderColor:(UIColor *)sliderColor_;

@end

@interface SliderSwitch : TextFieldSwitch

- (id)initSliderNamed:(NSString *)hackName_ description:(NSString *)description_ value:(float)value_ minimumValue:(float)minimumValue_ maximumValue:(float)maximumValue_ sliderColor:(UIColor *)sliderColor_;

@end

@interface SliderSwitch2 : TextFieldSwitch

- (id)initSliderNamed:(NSString *)hackName_ description:(NSString *)description_ value:(float)value_ minimumValue:(float)minimumValue_ maximumValue:(float)maximumValue_ sliderColor:(UIColor *)sliderColor_;

@end

@interface SliderSwitch3 : TextFieldSwitch

- (id)initSliderNamed:(NSString *)hackName_ description:(NSString *)description_ value:(float)value_ minimumValue:(float)minimumValue_ maximumValue:(float)maximumValue_ sliderColor:(UIColor *)sliderColor_;

@end

@interface SliderSwitch4 : TextFieldSwitch

- (id)initSliderNamed:(NSString *)hackName_ description:(NSString *)description_ value:(float)value_ minimumValue:(float)minimumValue_ maximumValue:(float)maximumValue_ sliderColor:(UIColor *)sliderColor_;

@end

@interface EachSwitch : UIButton {
	NSString *preferencesKey;
    UILabel *switchLabel;
}

- (id)initEachNamed:(NSString *)hackName_ ;

-(NSString *)getPreferencesKey;

@end

@interface Switches : UIButton

-(void)addEachSwitch:(NSString *)hackName_;


-(void)addSwitch:(NSString *)hackName_ description:(NSString *)description_ value:(float)value_;


- (void)addOffsetSwitchRight:(NSString *)hackName_ description:(NSString *)description_ value:(float)value offsets:(std::initializer_list<uint64_t>)offsets_ bytes:(std::initializer_list<std::string>)bytes_;


- (void)addOffsetSwitchRight2:(NSString *)hackName_ description:(NSString *)description_ value:(float)value offsets:(std::initializer_list<uint64_t>)offsets_ bytes:(std::initializer_list<std::string>)bytes_;

- (void)addOffsetSwitchRight3:(NSString *)hackName_ description:(NSString *)description_ value:(float)value offsets:(std::initializer_list<uint64_t>)offsets_ bytes:(std::initializer_list<std::string>)bytes_;

- (void)addOffsetSwitchRight4:(NSString *)hackName_ description:(NSString *)description_ value:(float)value offsets:(std::initializer_list<uint64_t>)offsets_ bytes:(std::initializer_list<std::string>)bytes_;

-(void)addRightSwitch:(NSString *)hackName_ description:(NSString *)description_ value:(float)value_;

-(void)addRightSwitch2:(NSString *)hackName_ description:(NSString *)description_ value:(float)value_;

-(void)addRightSwitch3:(NSString *)hackName_ description:(NSString *)description_ value:(float)value_;

-(void)addRightSwitch4:(NSString *)hackName_ description:(NSString *)description_ value:(float)value_ ;

-(void)addSwitch2:(NSString *)hackName_ description:(NSString *)description_ value:(float)value_;

-(void)addSwitch3:(NSString *)hackName_ description:(NSString *)description_ value:(float)value_;

-(void)addSwitch4:(NSString *)hackName_ description:(NSString *)description_ value:(float)value_;

- (void)addOffsetSwitch:(NSString *)hackName_ description:(NSString *)description_ value:(float)value_ offsets:(std::initializer_list<uint64_t>)offsets_ bytes:(std::initializer_list<std::string>)bytes_;

- (void)addOffsetSwitch2:(NSString *)hackName_ description:(NSString *)description_ value:(float)value_ offsets:(std::initializer_list<uint64_t>)offsets_ bytes:(std::initializer_list<std::string>)bytes_;

- (void)addOffsetSwitch3:(NSString *)hackName_ description:(NSString *)description_ value:(float)value_ offsets:(std::initializer_list<uint64_t>)offsets_ bytes:(std::initializer_list<std::string>)bytes_;

- (void)addOffsetSwitch4:(NSString *)hackName_ description:(NSString *)description_ value:(float)value_ offsets:(std::initializer_list<uint64_t>)offsets_ bytes:(std::initializer_list<std::string>)bytes_;

- (void)addTextfieldSwitch:(NSString *)hackName_ description:(NSString *)description_ inputBorderColor:(UIColor *)inputBorderColor_;

- (void)addTextfieldSwitch2:(NSString *)hackName_ description:(NSString *)description_ inputBorderColor:(UIColor *)inputBorderColor_;

- (void)addTextfieldSwitch3:(NSString *)hackName_ description:(NSString *)description_ inputBorderColor:(UIColor *)inputBorderColor_;

- (void)addTextfieldSwitch4:(NSString *)hackName_ description:(NSString *)description_ inputBorderColor:(UIColor *)inputBorderColor_;

- (void)addSliderSwitch:(NSString *)hackName_ description:(NSString *)description_ value:(float)value_ minimumValue:(float)minimumValue_ maximumValue:(float)maximumValue_ sliderColor:(UIColor *)sliderColor_;

- (void)addSliderSwitch2:(NSString *)hackName_ description:(NSString *)description_ value:(float)value_ minimumValue:(float)minimumValue_ maximumValue:(float)maximumValue_ sliderColor:(UIColor *)sliderColor_;

- (void)addSliderSwitch3:(NSString *)hackName_ description:(NSString *)description_ value:(float)value_ minimumValue:(float)minimumValue_ maximumValue:(float)maximumValue_ sliderColor:(UIColor *)sliderColor_;

- (void)addSliderSwitch4:(NSString *)hackName_ description:(NSString *)description_ value:(float)value_ minimumValue:(float)minimumValue_ maximumValue:(float)maximumValue_ sliderColor:(UIColor *)sliderColor_;

- (void)addSlidrSwitch:(NSString *)hackName_ description:(NSString *)description_ value:(float)value_ minimumValue:(float)minimumValue_ maximumValue:(float)maximumValue_ sliderColor:(UIColor *)sliderColor_;

- (void)addSlidrSwitch2:(NSString *)hackName_ description:(NSString *)description_ value:(float)value_ minimumValue:(float)minimumValue_ maximumValue:(float)maximumValue_ sliderColor:(UIColor *)sliderColor_;

- (void)addSlidrSwitch3:(NSString *)hackName_ description:(NSString *)description_ value:(float)value_ minimumValue:(float)minimumValue_ maximumValue:(float)maximumValue_ sliderColor:(UIColor *)sliderColor_;

- (void)addSlidrSwitch4:(NSString *)hackName_ description:(NSString *)description_ value:(float)value_ minimumValue:(float)minimumValue_ maximumValue:(float)maximumValue_ sliderColor:(UIColor *)sliderColor_;


- (NSString *)getValueFromSwitch:(NSString *)name;
-(bool)isSwitchOn:(NSString *)switchName;

@end
