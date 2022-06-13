#import "Macros.h"
#import "Vector3.h"
#include <OpenGLES/ES3/gl.h>
#include <OpenGLES/ES3/glext.h>
#include "dlfcn.h"

void (*_glDrawElements)(GLenum mode, GLsizei count, GLenum type, const void *indices);
GLint (*_glGetUniformLocation)(GLuint program,const GLchar *name);
GLint $glGetUniformLocation(GLuint program,const GLchar *name)
{
NSLog(@"%s",name);
return _glGetUniformLocation(program,name);
}
//disable metal framework for unity
%hook NSBundle
+ (id)bundleWithPath:(NSString *)fullPath
{
  if ([fullPath isEqual:@"/System/Library/Frameworks/Metal.framework"])
  {
    NSLog(@"distable metal framework");
    return NULL;
  }
  return %orig(fullPath);
}
%end
void $glDrawElements(GLenum mode, GLsizei count, GLenum type, const void *indices) {
    _glDrawElements(mode, count, type, indices);
    if (mode != GL_TRIANGLES || count < 1000) return;{
    GLint currProgram;
    glGetIntegerv(GL_CURRENT_PROGRAM, &currProgram);
    GLint id = _glGetUniformLocation(currProgram, "_BumpMap");
    if (id == -1) return;
    glDepthRangef(0.5, 1); 
    glColorMask(1, 1, 1, 1); 
    glDisable(GL_BLEND); 
}

#define _DRAW_R_ [[switches getValueFromSwitch:@"Red:"] floatValue]
#define _DRAW_G_ [[switches getValueFromSwitch:@"Green:"] floatValue]
#define _DRAW_B_ [[switches getValueFromSwitch:@"Blue:"] floatValue]

if([switches isSwitchOn:@"Set Chams Color"]){
    glDepthRangef(1, 0.5); 
 glBlendColor(GLfloat(_DRAW_R_/30), GLfloat(_DRAW_G_/30), GLfloat(_DRAW_B_/30), 1);
    glColorMask(_DRAW_R_,_DRAW_G_,_DRAW_B_, 0); 
    glEnable(GL_BLEND); 
    glBlendFunc(GL_SRC_ALPHA, GL_ONE); 
    _glDrawElements(mode, count, type, indices); 
    glDepthRangef(0.5, 1); 
    glColorMask(1, 1, 1, 1); 
    glDisable(GL_BLEND); 
}

#define _DRAW_WR_ [[switches getValueFromSwitch:@"WireFrame R:"] floatValue]
#define _DRAW_WG_ [[switches getValueFromSwitch:@"WireFrame G:"] floatValue]
#define _DRAW_WB_ [[switches getValueFromSwitch:@"WireFrame B:"] floatValue]

if([switches isSwitchOn:@"Set WireFrame Color"]){
    glDepthRangef(1, 0.5); 
 glBlendColor(GLfloat(_DRAW_WR_/30), GLfloat(_DRAW_WG_/30), GLfloat(_DRAW_WB_/30), 10);
    glColorMask(_DRAW_WR_,_DRAW_WG_,_DRAW_WB_, 0); 
    glEnable(GL_BLEND);
    glLineWidth( [[switches getValueFromSwitch:@"Width:"] floatValue] ); 
    glBlendFunc(GL_SRC_ALPHA, GL_ONE); 
    _glDrawElements(mode = GL_LINES, count = [[switches getValueFromSwitch:@"Count:"] floatValue], type, indices);
    glDepthRangef(0.5, 1); 
    glColorMask(1, 1, 1, 1); 
    glDisable(GL_BLEND); 

}
}

%ctor {
MSHookFunction((dlsym(RTLD_DEFAULT, "glDrawElements")), (void *)$glDrawElements, (void **)&_glDrawElements);
MSHookFunction((dlsym(RTLD_DEFAULT, "glGetUniformLocation")), (void *)$glGetUniformLocation, (void **)&_glGetUniformLocation);


}


void(*old_weap)(void *instance, int id);
void new_weap(void *instance, int id) {
 if([switches isSwitchOn:@"Set Weapon:"]) {
  id = [[switches getValueFromSwitch:@"Set Weapon:"] intValue];
 }
if([switches isSwitchOn:@"Usp - Genesis"]) {
  id = 12;
 }
if([switches isSwitchOn:@"AWM - Treasure Hunter"]) {
  id = 51;
 }
if([switches isSwitchOn:@"Karambit - Gold"]) {
  id = 72;
 }
if([switches isSwitchOn:@"G22 - Relic"]) {
  id = 11;
 }
if([switches isSwitchOn:@"AWM - Sport V2"]) {
  id = 51;
 }
if([switches isSwitchOn:@"FnFAL - Leather"]) {
  id = 49;
 }
if([switches isSwitchOn:@"M9 Bayonet - Dragon Glass"]) {
  id = 71;
 }
if([switches isSwitchOn:@"Butterfly - Dragon Glass"]) {
  id = 75;
 }
old_weap(instance, id);
}

void(*old_weapupdate)(void *instance, int id);
void new_weapupdate(void *instance, int id) {
 if([switches isSwitchOn:@"Set Weapon:"]) {
  new_weap(instance, id);
 }
if([switches isSwitchOn:@"Usp - Genesis"]) {
  new_weap(instance, id);
 }
if([switches isSwitchOn:@"AWM - Treasure Hunter"]) {
  new_weap(instance, id);
 }
if([switches isSwitchOn:@"Karambit - Gold"]) {
  new_weap(instance, id);
 }
if([switches isSwitchOn:@"G22 - Relic"]) {
  new_weap(instance, id);
 }
if([switches isSwitchOn:@"AWM - Sport V2"]) {
  new_weap(instance, id);
 }
if([switches isSwitchOn:@"FnFAL - Leather"]) {
  new_weap(instance, id);
 }
if([switches isSwitchOn:@"M9 Bayonet - Dragon Glass"]) {
  new_weap(instance, id);
 }
if([switches isSwitchOn:@"Butterfly - Dragon Glass"]) {
  new_weap(instance, id);
 }
old_weapupdate(instance, id);
}

void(*old_skin)(void *instance, int id, int skin);
void new_skin(void *instance, int id, int skin) {
 if([switches isSwitchOn:@"Set Skin:"]) {
  skin = [[switches getValueFromSwitch:@"Set Skin:"] intValue];
 }
if([switches isSwitchOn:@"Usp - Genesis"]) {
  skin = 12001;
 }
if([switches isSwitchOn:@"AWM - Treasure Hunter"]) {
  skin = 85104;
 }
if([switches isSwitchOn:@"Karambit - Gold"]) {
  skin = 72003;
 }
if([switches isSwitchOn:@"G22 - Relic"]) {
  skin = 41101;
 }
if([switches isSwitchOn:@"AWM - Sport V2"]) {
  skin = 51006;
 }
if([switches isSwitchOn:@"FnFAL - Leather"]) {
  skin = 44901;
 }
if([switches isSwitchOn:@"M9 Bayonet - Dragon Glass"]) {
  skin = 71005;
 }
if([switches isSwitchOn:@"Butterfly - Dragon Glass"]) {
  skin = 47503;
 }
old_skin(instance, id, skin);
}

int(*old_get_Gloves)(void *this_);
int get_Gloves(void *this_) {

  int userAmount = [[switches getValueFromSwitch:@"Set Gloves:"] intValue];

  if([switches isSwitchOn:@"Set Gloves:"]) {
    return userAmount;
  }
  return old_get_Gloves(this_);
}

void(*old_FirstLookUpdate)(void *instance); 
void FirstLookUpdate(void *instance) { 
 
  float handsFov = [[switches getValueFromSwitch:@"Fov:"]floatValue]; 
 
  if([switches isSwitchOn:@"Fov:"]) { 
   *(float *)((uint64_t) instance + 0x30) = handsFov;
  } 
  return old_FirstLookUpdate(instance); 
}

struct Vector3
{
    float x;
    float y;
    float z;
};

void (*old_b)(void* player, void* config);
void new_b(void* player, void* config){

if([switches isSwitchOn:@"Head Hitbox"]) {
(*(Vector3 *)((uint64_t)config + 0x24)).x += 999999999.0f;
}

if([switches isSwitchOn:@"Body Hitbox"]) {
(*(Vector3 *)((uint64_t)config + 0x24)).y += 999999999.0f;
}
	old_b(player, config);
}

typedef struct Quaternion {
    float x;
    float y;
    float z;
    float w;
} Quaternion;

void (*old_Instantiate)(void* player, unsigned long long a, Vector3 b, Quaternion c, int d, int e, bool f, bool g, float Instantiate);
void new_Instantiate(void* player, unsigned long long a, Vector3 b, Quaternion c, int d, int e, bool f, bool g, float Instantiate) {
if([switches isSwitchOn:@"GodMode"]) {
    Instantiate = 999999999.0f;
old_Instantiate (player, a, b, c, d, e, f, g, Instantiate);
}
else old_Instantiate (player, a, b, c, d, e, f, g, Instantiate);
}

float(*old_get_SpeedDefault)(void *this_);
float get_SpeedDefault(void *this_) {

  float userAmount = [[switches getValueFromSwitch:@"Speed:"] floatValue];

  if([switches isSwitchOn:@"Speed:"]) {
    return userAmount;
  }

return old_get_SpeedDefault(this_);
}

float(*old_Jump)(void *this_);
float Jump(void *this_) {

  float userAmount = [[switches getValueFromSwitch:@"Jump:"] floatValue];

  if([switches isSwitchOn:@"Jump:"]) {
    return userAmount;
  }
return old_Jump(this_);
}

void (*Update1)(void *instance);
void Player_Update1 (void *instance){
if([switches isSwitchOn:@"Set Hands Position"]) {
 if([switches isSwitchOn:@"Hands X:"]) 
 if([switches isSwitchOn:@"Hands Y:"]) 
 if([switches isSwitchOn:@"Hands Z:"]) {
  void *armsdata = *(void **)((uint64_t) instance + 0x70);
  Vector3 hPos;
   hPos.x = [[switches getValueFromSwitch:@"Hands X:"] floatValue] / 100;
   hPos.y = [[switches getValueFromSwitch:@"Hands Y:"] floatValue] / 100;
   hPos.z = [[switches getValueFromSwitch:@"Hands Z:"] floatValue] / 100;
  *(Vector3 *)((uint64_t)armsdata + 0xE8) = hPos;

}
} 
}

void (*old_fly)(void* player, Vector3 b);
void new_fly(void* player, Vector3 b){
if([switches isSwitchOn:@"Custom Fly:"]){
  b.y= [[switches getValueFromSwitch:@"Custom Fly:"] intValue];
}
return old_fly(player, b);
}

int(*old_kills)(void *_this);

int kills(void *_this){

int userAmount = [[switches getValueFromSwitch:@"Kills:"] intValue];

  if([switches isSwitchOn:@"Kills:"]) {
    return userAmount;
  }

return old_kills(_this);
}

int(*old_Assists)(void *_this);

int Assists(void *_this){

int userAmount = [[switches getValueFromSwitch:@"Assists:"] intValue];

  if([switches isSwitchOn:@"Assists:"]) {
    return userAmount;
  }

return old_Assists(_this);
}

int(*old_Death)(void *_this);

int Death(void *_this){

int userAmount = [[switches getValueFromSwitch:@"Death:"] intValue];

  if([switches isSwitchOn:@"Death:"]) {
    return userAmount;
  }

return old_Death(_this);
}

int(*old_Score)(void *_this);

int Score(void *_this){

int userAmount = [[switches getValueFromSwitch:@"Score:"] intValue];

  if([switches isSwitchOn:@"Score:"]) {
    return userAmount;
  }

return old_Score(_this);
}

int(*old_Ping)(void *_this);

int Ping(void *_this){

int userAmount = [[switches getValueFromSwitch:@"Ping:"] intValue];

  if([switches isSwitchOn:@"Ping:"]) {
    return userAmount;
  }

return old_Ping(_this);
}

int(*old_Mvp)(void *_this);

int Mvp(void *_this){

int userAmount = [[switches getValueFromSwitch:@"MVP:"] intValue];

  if([switches isSwitchOn:@"MVP:"]) {
    return userAmount;
  }

return old_Mvp(_this);
}


void setup() {

HOOK(0x1c0b3b0, new_weap, old_weap); 

HOOK(0x1c125b4, new_weapupdate, old_weapupdate); 

HOOK(0x18cc530, new_skin, old_skin);

HOOK(0x1ac3754, get_Gloves, old_get_Gloves);

HOOK(0x18b7e14, FirstLookUpdate, old_FirstLookUpdate);

HOOK(0x1a0c2c8, new_b, old_b);

HOOK(0x1a1d650, new_Instantiate, old_Instantiate);

HOOK(0x1a161d4, get_SpeedDefault, old_get_SpeedDefault);

HOOK(0x1aa58d4, Jump, old_Jump);

HOOK(0x1a1915c, Player_Update1,Update1);

HOOK(0x2690fd0, new_fly, old_fly);

HOOK(0x1ab96c8, kills, old_kills);

HOOK(0x1ab995c, Assists, old_Assists);

HOOK(0x1ab9bf0, Death, old_Death);

HOOK(0x1ab94cc, Score, old_Score);

HOOK(0x1ab8d94, Ping, old_Ping);

HOOK(0x1ab954c, Mvp, old_Mvp);

patchOffset(0x1a1932c, "0xC0035FD6");
patchOffset(0x18747b8, "0xC0035FD6");
patchOffset(0x187537c, "0xC0035FD6");
patchOffset(0x1874b8c, "0xC0035FD6");
patchOffset(0x1874604, "0xC0035FD6");
patchOffset(0x1874a88, "0xC0035FD6");
patchOffset(0x18743c4, "0xC0035FD6");
patchOffset(0x1874c64, "0xC0035FD6");
patchOffset(0x18741ac, "0xC0035FD6");
patchOffset(0x1874d4c, "0xC0035FD6");
patchOffset(0x18749b4, "0xC0035FD6");
patchOffset(0x1874708, "0xC0035FD6");
patchOffset(0x1875170, "0xC0035FD6");
patchOffset(0x1874ffc, "0xC0035FD6");
patchOffset(0x18744ac, "0xC0035FD6");
patchOffset(0x187489c, "0xC0035FD6");
patchOffset(0x1874e68, "0xC0035FD6");
patchOffset(0x1bbe990, "0xC0035FD6");


 [switches addOffsetSwitch2:@"No Recoil"
              description:@"No Recoil"
                offsets:{0x18ccca4}
                  bytes:{"0xC0035FD6"}];

 [switches addSliderSwitch3:@"Fov:"
            description:@"Fov"
              minimumValue:0
                maximumValue:150
                  sliderColor:UIColorFromHex(0x7000E8)];

 [switches addSwitch4:@"Usp - Genesis"
            description:@"Usp - Genesis"];

 [switches addSwitch:@"GodMode"
            description:@"GodMode"];

 [switches addOffsetSwitch2:@"No Camera Recoil"
              description:@"No Camera Recoil"
                offsets:{0x18ceb18}
                  bytes:{"0x20008052C0035FD6"}];

 [switches addTextfieldSwitch3:@"Set Gloves:"
            description:@"Set your custom gloves"
              inputBorderColor:UIColorFromHex(0x7000E8)];

 [switches addSwitch4:@"AWM - Treasure Hunter"
            description:@"AWM - Treasure Hunter"];

 [switches addSliderSwitch:@"Speed:"
            description:@"Speed"
              minimumValue:0
                maximumValue:40
                  sliderColor:UIColorFromHex(0x7000E8)];

 [switches addOffsetSwitch2:@"Shoot Through Walls"
              description:@"Shoot Through Walls"
                offsets:{0x1adc554}
                  bytes:{"0x00F0271EC0035FD6"}];

 [switches addOffsetSwitch3:@"Fps Hack"
              description:@"Fps Hack"
                offsets:{0x19901bc}
                  bytes:{"0x200080D2C0035FD6"}];

 [switches addSwitch4:@"Karambit - Gold"
            description:@"Karamdit - Gold"];

 [switches addOffsetSwitch:@"Move Before Time"
              description:@"Move Before Time"
                offsets:{0x1c0fbb8}
                  bytes:{"0x00008052C0035FD6"}];

 [switches addTextfieldSwitch2:@"Set Weapon:"
              description:@"Set Weapon"
                inputBorderColor:UIColorFromHex(0x7000E8)];

 [switches addOffsetSwitch3:@"Always Arcane"
              description:@"Always Arcane"
                offsets:{0x194549c,0x19405e8,0x1ad26e8}
                  bytes:{"0xC00080D2C0035FD6","0xC00080D2C0035FD6","0xC00080D2C0035FD6"}];

 [switches addSwitch4:@"G22 - Relic"
            description:@"G22 - Relic"];

 [switches addOffsetSwitch:@"Don't Return To Spawn"
              description:@"Don't Return To Spawn"
                offsets:{0x1c10ac0}
                  bytes:{"0x00008052C0035FD6"}];

 [switches addTextfieldSwitch2:@"Set Skin:"
              description:@""
                inputBorderColor:UIColorFromHex(0x7000E8)];

 [switches addOffsetSwitch3:@"Always StatTrack"
              description:@"Always StatTrack"
                offsets:{0x193b47c,0x1ad3550}
                  bytes:{"0x20008052C0035FD6","0x20008052C0035FD6"}];

 [switches addSwitch4:@"AWM - Sport V2"
            description:@"AWM - Sport V2"];

 [switches addOffsetSwitch:@"Play MM no 5lvl"
              description:@"Play MM no 5lvl"
                offsets:{0x194532c}
                  bytes:{"0x200080D2C0035FD6"}];

 [switches addSwitch2:@"Head Hitbox"
            description:@"Head Hitbox"];

 [switches addSwitch3:@"Set WireFrame Color"
            description:@"Enemies will become visible through walls. Use medium graphics settings"];

 [switches addSwitch4:@"FnFAL - Leather"
            description:@"FnFAL - Leather"];

 [switches addOffsetSwitch:@"Radar Hack"
              description:@"Radar Hack"
                offsets:{0x1c30d44}
                  bytes:{"0x200080D2C0035FD6"}];

 [switches addSwitch2:@"Body Hitbox"
            description:@"Body Hitbox"];

 [switches addSliderSwitch3:@"WireFrame R:"
            description:@"Enemies will become visible through walls. Use medium graphics settings"
              minimumValue:0
                maximumValue:1
                  sliderColor:UIColorFromHex(0x7000E8)];

 [switches addSwitch4:@"M9 Bayonet - Dragon Glass"
            description:@"M9 Bayonet - Dragon Glass"];

 [switches addOffsetSwitch:@"Team Radar"
              description:@"You Have To Look Towards Opponents"
                offsets:{0x19db5d8, 0x1c30d44}
                  bytes:{"0xC0035FD6","0x20008052C0035FD6"}];

 [switches addOffsetSwitch2:@"OneHitKill"
              description:@"OneHittKill"
                offsets:{0x1ac67d4, 0x1ac6b24, 0x1ac6b04, 0x1ac67b4}
                  bytes:{"0xE003271EC0035FD6", "0xE003271EC0035FD6", "0xE003271EC0035FD6", "0xE003271EC0035FD6"}];

 [switches addSliderSwitch3:@"WireFrame G:"
            description:@"Enemies will become visible through walls. Use medium graphics settings"
              minimumValue:0
                maximumValue:1
                  sliderColor:UIColorFromHex(0x7000E8)];

 [switches addSwitch4:@"Butterfly - Dragon Glass"
            description:@"Butterfly - Dragon Glass"];

 [switches addOffsetSwitch:@"Float"
              description:@"Float"
                offsets:{0x1a168e4}
                  bytes:{"0xC0035FD6"}];

 [switches addOffsetSwitch2:@"Unlimited Ammo"
              description:@"Unlimited Ammo"
                offsets:{0x1ad45ec,0x1ad459c}
                  bytes: {"0xE0E184D2C0035FD6","0xE0E184D2C0035FD6"}];

 [switches addSliderSwitch3:@"WireFrame B:"
            description:@"Enemies will become visible through walls. Use medium graphics settings"
              minimumValue:0
                maximumValue:1
                  sliderColor:UIColorFromHex(0x7000E8)];

 [switches addOffsetSwitch:@"Plant Anywhere"
              description:@"Plant Anywhere"
                offsets:{0x18b5e14,0x18b5db0,0x18b5dec}
                  bytes:{"0x20008052C0035FD6", "0x20008052C0035FD6", "0x20008052C0035FD6"}];  

 [switches addOffsetSwitch2:@"Fire Rate"
              description:@"Fire Rate"
                offsets:{0x18cde30}
                  bytes:{"0xC0035FD6"}];

 [switches addSliderSwitch3:@"Count:"
            description:@"Set your custom wireframe count"
              minimumValue:100
                maximumValue:6000
                  sliderColor:UIColorFromHex(0x7000E8)];

 [switches addOffsetSwitch:@"Bomb Immunity"
              description:@"Bomb Immunity"
                offsets:{0x18b26ec}
                  bytes:{"0x20008052C0035FD6"}];

 [switches addOffsetSwitch2:@"No Shooting Sounds"
              description:@"No Shooting Sounds"
                offsets:{0x18cc2d8}
                  bytes:{"0x20008052C0035FD6"}];

 [switches addSliderSwitch3:@"Width:"
            description:@"Set your custom wireframe count"
              minimumValue:1
                maximumValue:20
                  sliderColor:UIColorFromHex(0x7000E8)];

 [switches addOffsetSwitch:@"Bomb Explodes"
              description:@"Bomb Explodes"
                offsets:{0x18b2e88}
                  bytes:{"0x20008052C0035FD6"}];

 [switches addOffsetSwitch2:@"Friendly Fire"
              description:@"Friendly Fire"
                offsets:{0x1a0d0d4}
                  bytes:{"0x200080D2C0035FD6"}];

 [switches addSwitch3:@"Set Chams Color"
            description:@"Enemies will become visible through walls. Use medium graphics settings"];

 [switches addOffsetSwitch:@"Fast Plant"
              description:@"Fast Plant"
                offsets:{0x18b07b0}
                  bytes:{"0xE003271EC0035FD6"}];

 [switches addOffsetSwitch2:@"Arm Race Win"
              description:@"Arm Race Win"
                offsets:{0x1b5454c}
                  bytes:{"0xE00180D2C0035FD6"}];

 [switches addSliderSwitch3:@"Red:"
            description:@"Enemies will become visible through walls. Use medium graphics settings"
              minimumValue:0
                maximumValue:1
                  sliderColor:UIColorFromHex(0x7000E8)];

 [switches addOffsetSwitch:@"Buy Anywhere"
              description:@"Buy Anywhere"
                offsets:{0x1c04d94,0x1c041d8}
                  bytes:{"0x20008052C0035FD6","0x20008052C0035FD6"}];

 [switches addOffsetSwitch2:@"No Drop Weapon"
              description:@"No Drop Weapon"
                offsets:{0x1a36e8c,0x1a357e8}
                  bytes:{"0x200080D2C0035FD6","0x200080D2C0035FD6"}];

 [switches addSliderSwitch3:@"Green:"
            description:@"Enemies will become visible through walls. Use medium graphics settings"
              minimumValue:0
                maximumValue:1
                  sliderColor:UIColorFromHex(0x7000E8)];

 [switches addOffsetSwitch:@"Anti Flash"
              description:@"Anti Flash"
                offsets:{0x18c17d8}
                  bytes:{"0xC0035FD6"}];

 [switches addOffsetSwitch2:@"Drop Knife"
              description:@"No Drop Weapon"
                offsets:{0x18d43b8}
                  bytes:{"0x20008052C0035FD6"}];

 [switches addSliderSwitch3:@"Blue:"
            description:@"Enemies will become visible through walls. Use medium graphics settings"
              minimumValue:0
                maximumValue:1
                  sliderColor:UIColorFromHex(0x7000E8)];

 [switches addOffsetSwitch:@"He Immunity"
              description:@"He Immunity"
                offsets:{0x18c4c3c}
                  bytes:{"0xC0035FD6"}];

 [switches addSwitch3:@"Set Hands Position"
            description:@"Set your custom hands pos"];

 [switches addOffsetSwitch:@"Fast Grenade"
              description:@"Fast Grenade"
                offsets:{0x18c0bac}
                  bytes:{"0x20008052C0035FD6"}];

 [switches addSliderSwitch3:@"Hands X:"
            description:@"Set your custom hands pos"
              minimumValue:-100
                maximumValue:100
                  sliderColor:UIColorFromHex(0x7000E8)];

 [switches addOffsetSwitch:@"No Grenade"
              description:@"No Grenade"
                offsets:{0x18c5c30}
                  bytes:{"0xC0035FD6"}];

 [switches addSliderSwitch3:@"Hands Y:"
            description:@"Set your custom hands pos"
              minimumValue:-100
                maximumValue:100
                  sliderColor:UIColorFromHex(0x7000E8)];

 [switches addOffsetSwitch:@"No Grenade Sounds"
              description:@"No Grenade Sounds"
                offsets:{0x18bec98}
                  bytes:{"0x20008052C0035FD6"}];

 [switches addSliderSwitch3:@"Hands Z:"
            description:@"Set your custom hands pos"
              minimumValue:-100
                maximumValue:100
                  sliderColor:UIColorFromHex(0x7000E8)];

 [switches addOffsetSwitch:@"Infinity Jump"
              description:@"Infinity Jump"
                offsets:{0x2691128}
                  bytes:{"0x20008052C0035FD6"}];

 [switches addOffsetSwitch3:@"Hide Avatar"
              description:@"Hide Avatar"
                offsets:{0x1ab9c70}
                  bytes:{"0x20008052C0035FD6"}];

 [switches addOffsetSwitch:@"Long Jump"
              description:@"Long Jump"
                offsets:{0x1aa58d4}
                  bytes:{"0x00F0271EC0035FD6"}];

 [switches addSliderSwitch:@"Jump:"
            description:@"Set your custom jump"
              minimumValue:0
                maximumValue:150
                  sliderColor:UIColorFromHex(0x7000E8)];

 [switches addSliderSwitch:@"Custom Fly:"
            description:@"Enemies will become visible through walls. Use medium graphics settings"
              minimumValue:0
                maximumValue:100
                  sliderColor:UIColorFromHex(0x7000E8)];

 [switches addOffsetSwitch:@"Money"
              description:@"Money"
                offsets:{0x1c11e88}
                  bytes:{"0x00008052C0035FD6"}];

 [switches addOffsetSwitch:@"Medal Hack"
              description:@"Medal Hack"
                offsets:{0x1a39e84}
                  bytes:{"0x200080D2C0035FD6"}];

 [switches addOffsetSwitch:@"Always Respawn"
              description:@"Always Respawn"
                offsets:{0x1c027f8}
                  bytes:{"0x20008052C0035FD6"}];

 [switches addTextfieldSwitch:@"Kills:"
            description:@"Set your custom kills"
              inputBorderColor:UIColorFromHex(0x7000E8)];

[switches addTextfieldSwitch:@"Assists:"
            description:@"Set your custom assists"
              inputBorderColor:UIColorFromHex(0x7000E8)];

 [switches addTextfieldSwitch:@"Death:"
            description:@"Set your custom death"
              inputBorderColor:UIColorFromHex(0x7000E8)];

 [switches addTextfieldSwitch:@"Ping:"
            description:@"Set your custom ping"
              inputBorderColor:UIColorFromHex(0x7000E8)];

[switches addTextfieldSwitch:@"Score:"
            description:@"Set your custom score"
              inputBorderColor:UIColorFromHex(0x7000E8)];

[switches addTextfieldSwitch:@"MVP:"
            description:@"Set your custom mvp"
              inputBorderColor:UIColorFromHex(0x7000E8)];

}

void setupMenu() {


[menu setFrameworkName:"UnityFramework"];
menu = [[Menu alloc]              initWithTitle:@""
watermarkText:@""
watermarkTextColor:UIColorFromHex(0xc72c36)
watermarkVisible:1.0
titleColor:[UIColor whiteColor]
titleFont:@"Avenir-Black"
credits:@""
initWithTitle:@""
titleColor:[UIColor whiteColor]
titleFont:@"Avenir-Black"
initWithTitle:@"v0.17.4"
titleColor:[UIColor whiteColor]
titleFont:@"Avenir-Black"
headerColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.7]
switchOffColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5]
switchOnColor:UIColorFromHex(0x000000)
switchTitleFont:@"AppleSDGothicNeo-Bold"
switchTitleColor:[UIColor whiteColor]
infoButtonColor:[UIColor clearColor]
maxVisibleSwitches:5
menuWidth:500
menuIcon:@""
menuButton:@""]; 

    setup();
}


static void didFinishLaunching(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef info) {

    NSUserDefaults *check;
check = [NSUserDefaults standardUserDefaults];

timer(5) {

SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindowWidth:250];

alert.customViewColor = UIColorFromHex(0x7000E8);
alert.showAnimationType = SCLAlertViewShowAnimationSlideInFromCenter;
alert.hideAnimationType = SCLAlertViewHideAnimationFadeOut;
alert.shouldDismissOnTapOutside = NO;
alert.backgroundType = SCLAlertViewBackgroundBlur;
alert.cornerRadius = 10.0f;
alert.backgroundViewColor = [UIColor colorWithRed:0.00 green:0.00 blue:0.00 alpha:1.00];

SCLAlertView *bad = [[SCLAlertView alloc] initWithNewWindowWidth:300];

bad.customViewColor = UIColorFromHex(0x7000E8);
bad.showAnimationType = SCLAlertViewShowAnimationSlideInFromCenter;
alert.hideAnimationType = SCLAlertViewHideAnimationFadeOut;
bad.shouldDismissOnTapOutside = NO;
bad.backgroundType = SCLAlertViewBackgroundBlur;
bad.cornerRadius = 10.0f;
bad.backgroundViewColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];

SCLAlertView *nice = [[SCLAlertView alloc] initWithNewWindowWidth:250];

nice.customViewColor = UIColorFromHex(0x7000E8);
nice.showAnimationType = SCLAlertViewShowAnimationSlideInFromCenter;
alert.hideAnimationType = SCLAlertViewHideAnimationFadeOut;
nice.shouldDismissOnTapOutside = NO;
nice.backgroundType = SCLAlertViewBackgroundBlur;
nice.cornerRadius = 10.0f;
nice.backgroundViewColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];

[nice addButton: @"Anemone" validationBlock: ^BOOL {
[[UIApplication sharedApplication] openURL: [NSURL URLWithString:@"https://discord.gg/qnFA9tgttX"]];
BOOL shouldClosePopup = false;
return shouldClosePopup;
} actionBlock:^{}];
    [nice addButton: @"Thanks:3" actionBlock: ^(void) {
      timer(1) {
        setupMenu();
      });
    }];    


NSString *loggedin = [check stringForKey:@"loggedin"];
timer(1) {
if([loggedin isEqualToString:@"1"]) {
[nice showSuccess:@"Anemone" subTitle:@"\n Anemone Hack By Anemone Team" closeButtonTitle:nil duration:999999999.0f];
[nice.view setTintColor:[UIColor yellowColor]];

}
});

UITextField *text1 = [alert addTextField:@"Password"];

[alert addButton: @"Discord" validationBlock: ^BOOL {
[[UIApplication sharedApplication] openURL: [NSURL URLWithString:@"https://discord.gg/qnFA9tgttX"]];
BOOL shouldClosePopup = false;
return shouldClosePopup;
} actionBlock:^{}];

[alert addButton:@"Unlock" actionBlock:^ (void) {
if ([text1.text isEqualToString:@"6398480454398374"]) {
[check setObject:@"1" forKey:@"1"];
[check synchronize];
timer(1) {
[nice showSuccess:@"Success" subTitle:@"hehe" closeButtonTitle:nil duration:999999999.0f];
});
}
else
{
timer(1) {
[bad showError:@"Wrong Password:(" subTitle:@"\n Game will crash now. \n After that you can try again" closeButtonTitle:nil duration:999999999.0f];
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
exit(0);
});
});
}
}];

if(![loggedin isEqualToString:@"1"]) {
NSData* data = [[NSData alloc] f options:0];

UIImage* customAlertImage = [UIImage imageWithData:data];   

[alert showCustom:alert image:customAlertImage color:[UIColor redColor] title:@"Anemone Hack" subTitle:@"\n Enter a Passoword" closeButtonTitle:nil duration:9999999999.0f];
}
});
}

%ctor {
  CFNotificationCenterAddObserver(CFNotificationCenterGetLocalCenter(), NULL, &didFinishLaunching, (CFStringRef)UIApplicationDidFinishLaunchingNotification, NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
}