#include "Vector3.hpp"
#import "Macros.h"
#include <OpenGLES/ES3/gl.h>
#include <OpenGLES/ES3/glext.h>
#include "dlfcn.h"

static float r = 255.0f;
static float g = 0.0f;
static float b = 0.0f;
static int w = 2;
static int a = 255;

float red = 255.0f;
float gren = 0.0f;
float blue =0.0f;
float mi = 0.0f;
// OutLine
static float reed = 0.0f;
static float green = 0.0f;
static float bluee = 0.0f;
//Chams
static float reeed = 0.0f;
static float greeen = 0.0f;
static float blueee = 0.0f;
//WireFrame
static float reeeed = 0.0f;
static float greeeen = 0.0f;
static float blueeee = 0.0f;
//Glow
static float reeeeed = 0.0f;
static float greeeeen = 0.0f;
static float blueeeee = 0.0f;
//Sky
static float reeeeeed = 0.0f;
static float greeeeeen = 0.0f;
static float blueeeeee = 0.0f;

void SetRedChams(int set){
    reeed = set;
}

void SetGreenChams(int set){
    greeen = set;
}

void SetBlueChams(int set){
    blueee = set;
}


void SetRedWireFrame(int set){
    reeeed = set;
}

void SetGreenWireFrame(int set){
    greeeen = set;
}

void SetBlueWireFrame(int set){
    blueeee = set;
}


void SetRedGlow(int set){
    reeeeed = set;
}

void SetGreenGlow(int set){
    greeeeen = set;
}

void SetBlueGlow(int set){
    blueeeee = set;
}

void SetRedSky(int set){
    reeeeeed = set;
}

void SetGreenSky(int set){
    greeeeeen = set;
}

void SetBlueSky(int set){
    blueeeeee = set;
}

void SetRedO(int set){
    reed = set;
}

void SetGreenO(int set){
    green = set;
}

void SetBlueO(int set){
    bluee = set;
}

void SetR(int set){
    r = set;
}

void SetG(int set){
    g = set;
}

void SetB(int set){
    b = set;
}

void SetW(int set){
    w = set;
}

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
    // draw elements on 2d screen coordinates level
    glDepthRangef(1, 0.5);

#define _DRAW_RGB_3 246,255,0

    glColorMask (_DRAW_RGB_3, 0);
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE);

if([switches isSwitchOn:@"ams"]) {
    _glDrawElements(mode = GL_LINES, count = 8000, type, indices);
}

    glDepthRangef(0.5, 1);
    glColorMask(1, 1, 1, 1);
    glDisable(GL_BLEND);

   /*if([switches isSwitchOn:@"Default Chams"]){
    glDepthRangef(1, 0.5);
    glLineWidth(1.0f);
    glColorMask (0, 255, 255, 0);
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE);
    _glDrawElements(mode = GL_LINES, count, type, indices);
    glDepthRangef(0.5, 1);
    glColorMask(1, 1, 1, 1);
    glDisable(GL_BLEND);
}
   if([switches isSwitchOn:@"OutLine Chams"]){
            glDepthRangef(1, 0);
            glLineWidth(6.0f);
            glEnable(GL_BLEND);
            glColorMask(1, 1, 1, 1);
            glEnable(GL_BLEND);
            glBlendFunc(GL_SRC_ALPHA, GL_ONE);
            glBlendFuncSeparate(GL_CONSTANT_COLOR, GL_CONSTANT_ALPHA, GL_ONE, GL_ZERO);
            glBlendColor(0, 0, 0, 1);
            _glDrawElements(GL_TRIANGLES, count, type, indices);
            glBlendColor(1, 1, 0, 1);
            glDepthRangef(1, 0.5);
            //glBlendColor(GLfloat(float(r)/255), GLfloat(float(g)/255), GLfloat(float(b)/255), 1);
            _glDrawElements(GL_LINES, count, type, indices);
    glDepthRangef(0.5, 1);
    glColorMask(1, 1, 1, 1);
    glDisable(GL_BLEND);
}*/
if([switches isSwitchOn:@"Cum WireFrame"]){
    glDepthRangef(1, 0.5);
    glColorMask (255, 0, 0, 0);
    _glDrawElements(mode = GL_LINES, count, type, indices);
    glDepthRangef(0.5, 1);
    glColorMask(1, 1, 1, 1);
    glDisable(GL_BLEND);
    glBlendFunc(GL_ONE_MINUS_CONSTANT_COLOR, GL_ONE_MINUS_CONSTANT_ALPHA);
}
}
   if([switches isSwitchOn:@"Set Chams Color"]){

float reeed = [[switches getValueFromSwitch:@"Red Chams:"] floatValue];
float greeen = [[switches getValueFromSwitch:@"Green Chams:"] floatValue];
float blueee = [[switches getValueFromSwitch:@"Blue Chams:"] floatValue];

               SetRedChams(reeed);
               SetGreenChams(greeen);
               SetBlueChams(blueee);

            glDepthRangef(1, 0);
            glLineWidth(0.0f);
            glEnable(GL_BLEND);
            glColorMask(1, 1, 1, 1);
            glEnable(GL_BLEND);
            glBlendFunc(GL_SRC_ALPHA, GL_ONE);
            glBlendFuncSeparate(GL_CONSTANT_COLOR, GL_CONSTANT_ALPHA, GL_ONE, GL_ZERO);
            _glDrawElements(GL_TRIANGLES, count, type, indices);
glBlendColor(GLfloat(reeed/255), GLfloat(greeen/255), GLfloat(blueee/255), GLfloat(a/255));
            glDepthRangef(1, 0.5);
    glDepthRangef(0.5, 1);
    glColorMask(1, 1, 1, 1);
    glDisable(GL_BLEND);
}
   if([switches isSwitchOn:@"Set WireFrame Color"]){

float reeeed = [[switches getValueFromSwitch:@"Red WireFrame:"] floatValue];
float greeeen = [[switches getValueFromSwitch:@"Green WireFrame:"] floatValue];
float blueeee = [[switches getValueFromSwitch:@"Blue WireFrame:"] floatValue];

               SetRedWireFrame(reeeed);
               SetGreenWireFrame(greeeen);
               SetBlueWireFrame(blueeee);

            glDepthRangef(1, 0.5);
            glBlendColor(GLfloat(reeeed/255), GLfloat(greeeen/255), GLfloat(blueeee/255), 1);
            glColorMask(1, 1, 1, 1);
            glEnable(GL_BLEND);
            glBlendFuncSeparate(GL_CONSTANT_COLOR, GL_CONSTANT_ALPHA, GL_ONE, GL_ZERO);
            glLineWidth(1.0f);
            _glDrawElements(GL_LINES, count, type, indices);
            glDepthRangef(0.5,1);
            glDisable(GL_BLEND);
}

if([switches isSwitchOn:@"Clear Chams"]){

glDepthRangef(1, 0.5); 
glBlendColor(GLfloat(0), GLfloat(0), GLfloat(0), GLfloat(a/255));
    glEnable(GL_BLEND); 
    glBlendFunc(GL_ONE_MINUS_CONSTANT_COLOR, GL_ONE_MINUS_CONSTANT_ALPHA);
    _glDrawElements(mode, count, type, indices); 
    glDepthRangef(0.5, 1); 
    glColorMask(1, 1, 1, 1); 
    glDisable(GL_BLEND); 
            
            
}  

   if([switches isSwitchOn:@"Set Glow Color"]){

float reeeeed = [[switches getValueFromSwitch:@"Red Glow:"] floatValue];
float greeeeen = [[switches getValueFromSwitch:@"Green Glow:"] floatValue];
float blueeeee = [[switches getValueFromSwitch:@"Blue Glow:"] floatValue];

               SetRedGlow(reeeeed);
               SetGreenGlow(greeeeen);
               SetBlueGlow(blueeeee);

glDepthRangef(1, 0.5); 
glBlendColor(GLfloat(reeeeed/255), GLfloat(greeeeen/255), GLfloat(blueeeee/255), GLfloat(a/255));
    glEnable(GL_BLEND); 
    glBlendFunc(GL_ONE_MINUS_CONSTANT_COLOR, GL_ONE_MINUS_CONSTANT_ALPHA);
    _glDrawElements(mode, count, type, indices); 
    glDepthRangef(0.5, 1); 
    glColorMask(1, 1, 1, 1); 
    glDisable(GL_BLEND); 
}
   if([switches isSwitchOn:@"Set Sky Color"]){

float reeeeeed = [[switches getValueFromSwitch:@"Red Sky:"] floatValue];
float greeeeeen = [[switches getValueFromSwitch:@"Green Sky:"] floatValue];
float blueeeeee = [[switches getValueFromSwitch:@"Blue Sky:"] floatValue];

               SetRedSky(reeeeeed);
               SetGreenSky(greeeeeen);
               SetBlueSky(blueeeeee);

            glDepthRangef(1, 0);
            glLineWidth(0.0f);
            glEnable(GL_BLEND);
            glColorMask(1, 1, 1, 1);
            glEnable(GL_BLEND);
            glBlendFunc(GL_SRC_ALPHA, GL_ONE);
            glBlendFuncSeparate(GL_CONSTANT_COLOR, GL_CONSTANT_ALPHA, GL_ONE, GL_ZERO);
            glBlendColor(0, 0, 0, 1);
            glDepthRangef(1, 0.5);
            glBlendColor(GLfloat(reeeeeed/255), GLfloat(greeeeeen/255), GLfloat(blueeeeee/255), 1);
            glDepthRangef(0.5, 1);
            glColorMask(1, 1, 1, 1);
}
 if([switches isSwitchOn:@"Set OutLine Color"]){

float reed = [[switches getValueFromSwitch:@"Red OutLine:"] floatValue];
float green = [[switches getValueFromSwitch:@"Green OutLine:"] floatValue];
float bluee = [[switches getValueFromSwitch:@"Blue OutLine:"] floatValue];

              SetRedO(reed);
              SetGreenO(gren);
              SetBlueO(bluee);

float line = [[switches getValueFromSwitch:@"OutLine Width:"] floatValue];

            glDepthRangef(1, 0);
            glLineWidth(line);
            glEnable(GL_BLEND);
            glColorMask(1, 1, 1, 1);
            glEnable(GL_BLEND);
            glBlendFunc(GL_SRC_ALPHA, GL_ONE);
            glBlendFuncSeparate(GL_CONSTANT_COLOR, GL_CONSTANT_ALPHA, GL_ONE, GL_ZERO);
            glBlendColor(0, 0, 0, 1);
            _glDrawElements(GL_TRIANGLES, count, type, indices);
glBlendColor(GLfloat(reed/255), GLfloat(green/255), GLfloat(bluee/255), GLfloat(255));
            glDepthRangef(1, 0.5);
            _glDrawElements(GL_LINES, count, type, indices);
    glDepthRangef(0.5, 1);
    glColorMask(1, 1, 1, 1);
    glDisable(GL_BLEND);
}

 if([switches isSwitchOn:@"Rainbow OutLine"]){


              if (red == 255){
                   if (blue == 0 ){
                       if (gren == 255){} else{
                           gren = gren+1;
                       }
                   }
               }
               if (gren == 255){
                   if (red == 0){} else{
                       red = red-1;
                   }
               }
               if (gren == 255) {
                   if (red == 0) {
                       if (blue==255){} else{
                           blue = blue+1;
                       }
                   }
               }
               if (blue == 255) {
                   if (gren == 0) {
                       mi = 1;
                       red = red+1;
                   } 
                   else{
                        gren = gren-1;
                   }
               }
               if (mi == 1){
                   if (red == 255){
                       if (blue == 0){} else{
                           blue = blue-1;
                       }
                   }
               }
               SetR(red);
               SetG(gren);
               SetB(blue);

float line = [[switches getValueFromSwitch:@"OutLine Width:"] floatValue];

            glDepthRangef(1, 0);
            glLineWidth(line);
            glEnable(GL_BLEND);
            glColorMask(1, 1, 1, 1);
            glEnable(GL_BLEND);
            glBlendFunc(GL_SRC_ALPHA, GL_ONE);
            glBlendFuncSeparate(GL_CONSTANT_COLOR, GL_CONSTANT_ALPHA, GL_ONE, GL_ZERO);
            glBlendColor(0, 0, 0, 1);
            _glDrawElements(GL_TRIANGLES, count, type, indices);
glBlendColor(GLfloat(r/255), GLfloat(g/255), GLfloat(b/255), GLfloat(a/255));
            glDepthRangef(1, 0.5);
            //glBlendColor(GLfloat(float(r)/255), GLfloat(float(g)/255), GLfloat(float(b)/255), 1);
            _glDrawElements(GL_LINES, count, type, indices);
    glDepthRangef(0.5, 1);
    glColorMask(1, 1, 1, 1);
    glDisable(GL_BLEND);
}

void(*old_weap)(void *instance, int id);
void new_weap(void *instance, int id) {
 if([switches isSwitchOn:@"Set Weapon:"]) {
  id = [[switches getValueFromSwitch:@"Set Weapon:"] intValue];
 }
old_weap(instance, id);
}

void(*old_weapupdate)(void *instance, int id);
void new_weapupdate(void *instance, int id) {
 if([switches isSwitchOn:@"Set Weapon:"]) {
  new_weap(instance, id);
 }
old_weapupdate(instance, id);
}

void(*old_skin)(void *instance, int id, int skin);
void new_skin(void *instance, int id, int skin) {
 if([switches isSwitchOn:@"Set Skin:"]) {
  skin = [[switches getValueFromSwitch:@"Set Skin:"] intValue];
 }
old_skin(instance, id, skin);
}

if([switches isSwitchOn:@"Rainbow Glow"]){

              if (red == 255){
                   if (blue == 0 ){
                       if (gren == 255){} else{
                           gren = gren+1;
                       }
                   }
               }
               if (gren == 255){
                   if (red == 0){} else{
                       red = red-1;
                   }
               }
               if (gren == 255) {
                   if (red == 0) {
                       if (blue==255){} else{
                           blue = blue+1;
                       }
                   }
               }
               if (blue == 255) {
                   if (gren == 0) {
                       mi = 1;
                       red = red+1;
                   } 
                   else{
                        gren = gren-1;
                   }
               }
               if (mi == 1){
                   if (red == 255){
                       if (blue == 0){} else{
                           blue = blue-1;
                       }
                   }
               }
               SetR(red);
               SetG(gren);
               SetB(blue);

glDepthRangef(1, 0.5); 
glBlendColor(GLfloat(r/255), GLfloat(g/255), GLfloat(b/255), GLfloat(a/255));
    glEnable(GL_BLEND); 
    glBlendFunc(GL_ONE_MINUS_CONSTANT_COLOR, GL_ONE_MINUS_CONSTANT_ALPHA);
    _glDrawElements(mode, count, type, indices); 
    glDepthRangef(0.5, 1); 
    glColorMask(1, 1, 1, 1); 
    glDisable(GL_BLEND); 
            
            
}  
   /*if([switches isSwitchOn:@"Rainbow WireFrame"]){

               if (red == 255){
                   if (blue == 0 ){
                       if (gren == 255){} else{
                           gren = gren+rainbowspeed;
                       }
                   }
               }
               if (gren == 255){
                   if (red == 0){} else{
                       red = red-rainbowspeed;
                   }
               }
               if (gren == 255) {
                   if (red == 0) {
                       if (blue==255){} else{
                           blue = blue+rainbowspeed;
                       }
                   }
               }
               if (blue == 255) {
                   if (gren == 0) {
                       mi = 1;
                       red = red+rainbowspeed;
                   } 
                   else{
                        gren = gren-rainbowspeed;
                   }
               }
               if (mi == 1){
                   if (red == 255){
                       if (blue == 0){} else{
                           blue = blue-rainbowspeed;
                       }
                   }
               }
               SetR(red);
               SetG(gren);
               SetB(blue);

            glDepthRangef(1, 0);
            glLineWidth(6.0f);
            glEnable(GL_BLEND);
            glColorMask(1, 1, 1, 1);
            glBlendFunc(GL_SRC_ALPHA, GL_ONE);
            glBlendFuncSeparate(GL_CONSTANT_COLOR, GL_CONSTANT_ALPHA, GL_ONE, GL_ZERO);
            glBlendColor(0, 0, 0, 1);
            //_glDrawElements(GL_TRIANGLES, count, type, indices);
            glDepthRangef(0.5, 1);
            glBlendColor(GLfloat(r/255), GLfloat(g/255), GLfloat(b/255), 1);
            _glDrawElements(GL_LINES, count, type, indices);
    glDepthRangef(0.5, 1);
    glColorMask(1, 1, 1, 1);
}*/
   if([switches isSwitchOn:@"Rainbow WireFrame"]){



              if (red == 255){
                   if (blue == 0 ){
                       if (gren == 255){} else{
                           gren = gren+1;
                       }
                   }
               }
               if (gren == 255){
                   if (red == 0){} else{
                       red = red-1;
                   }
               }
               if (gren == 255) {
                   if (red == 0) {
                       if (blue==255){} else{
                           blue = blue+1;
                       }
                   }
               }
               if (blue == 255) {
                   if (gren == 0) {
                       mi = 1;
                       red = red+1;
                   } 
                   else{
                        gren = gren-1;
                   }
               }
               if (mi == 1){
                   if (red == 255){
                       if (blue == 0){} else{
                           blue = blue-1;
                       }
                   }
               }
               SetR(red);
               SetG(gren);
               SetB(blue);

            glDepthRangef(1, 0.5);
            glBlendColor(GLfloat(r/255), GLfloat(g/255), GLfloat(b/255), 1);
            glColorMask(1, 1, 1, 1);
            glEnable(GL_BLEND);
            glBlendFuncSeparate(GL_CONSTANT_COLOR, GL_CONSTANT_ALPHA, GL_ONE, GL_ZERO);
            glLineWidth(1.0f);
            _glDrawElements(GL_LINES, count, type, indices);
            glDepthRangef(0.5,1);
            glDisable(GL_BLEND);
}
   if([switches isSwitchOn:@"Rainbow Chams"]){

              if (red == 255){
                   if (blue == 0 ){
                       if (gren == 255){} else{
                           gren = gren+1;
                       }
                   }
               }
               if (gren == 255){
                   if (red == 0){} else{
                       red = red-1;
                   }
               }
               if (gren == 255) {
                   if (red == 0) {
                       if (blue==255){} else{
                           blue = blue+1;
                       }
                   }
               }
               if (blue == 255) {
                   if (gren == 0) {
                       mi = 1;
                       red = red+1;
                   } 
                   else{
                        gren = gren-1;
                   }
               }
               if (mi == 1){
                   if (red == 255){
                       if (blue == 0){} else{
                           blue = blue-1;
                       }
                   }
               }
               SetR(red);
               SetG(gren);
               SetB(blue);

            glDepthRangef(1, 0);
            glLineWidth(0.0f);
            glEnable(GL_BLEND);
            glColorMask(1, 1, 1, 1);
            glEnable(GL_BLEND);
            glBlendFunc(GL_SRC_ALPHA, GL_ONE);
            glBlendFuncSeparate(GL_CONSTANT_COLOR, GL_CONSTANT_ALPHA, GL_ONE, GL_ZERO);
            _glDrawElements(GL_TRIANGLES, count, type, indices);
glBlendColor(GLfloat(r/255), GLfloat(g/255), GLfloat(b/255), GLfloat(a/255));
            glDepthRangef(1, 0.5);
            //glBlendColor(GLfloat(float(r)/255), GLfloat(float(g)/255), GLfloat(float(b)/255), 1);
            //_glDrawElements(GL_LINES, count, type, indices);
    glDepthRangef(0.5, 1);
    glColorMask(1, 1, 1, 1);
    glDisable(GL_BLEND);
}
if([switches isSwitchOn:@"Rainbow Sky"]) {


              if (red == 255){
                   if (blue == 0 ){
                       if (gren == 255){} else{
                           gren = gren+1;
                       }
                   }
               }
               if (gren == 255){
                   if (red == 0){} else{
                       red = red-1;
                   }
               }
               if (gren == 255) {
                   if (red == 0) {
                       if (blue==255){} else{
                           blue = blue+1;
                       }
                   }
               }
               if (blue == 255) {
                   if (gren == 0) {
                       mi = 1;
                       red = red+1;
                   } 
                   else{
                        gren = gren-1;
                   }
               }
               if (mi == 1){
                   if (red == 255){
                       if (blue == 0){} else{
                           blue = blue-1;
                       }
                   }
               }
               SetR(red);
               SetG(gren);
               SetB(blue);


            glDepthRangef(1, 0);
            glLineWidth(0.0f);
            glEnable(GL_BLEND);
            glColorMask(1, 1, 1, 1);
            glEnable(GL_BLEND);
            glBlendFunc(GL_SRC_ALPHA, GL_ONE);
            glBlendFuncSeparate(GL_CONSTANT_COLOR, GL_CONSTANT_ALPHA, GL_ONE, GL_ZERO);
            glBlendColor(0, 0, 0, 1);
           // _glDrawElements(GL_TRIANGLES, count, type, indices);
            //glBlendColor(GLfloat(r/255), GLfloat(g/255), GLfloat(b/255), 0);
            glDepthRangef(1, 0.5);
            glBlendColor(GLfloat(float(r)/255), GLfloat(float(g)/255), GLfloat(float(b)/255), 1);
            //_glDrawElements(GL_LINES, count, type, indices);
            glDepthRangef(0.5, 1);
            glColorMask(1, 1, 1, 1);
}
}
%ctor {
MSHookFunction((dlsym(RTLD_DEFAULT, "glDrawElements")), (void *)$glDrawElements, (void **)&_glDrawElements);
MSHookFunction((dlsym(RTLD_DEFAULT, "glGetUniformLocation")), (void *)$glGetUniformLocation, (void **)&_glGetUniformLocation);

void(*old_weap)(void *instance, int id);
void new_weap(void *instance, int id) {
 if([switches isSwitchOn:@"Set Weapon:"]) {
  id = [[switches getValueFromSwitch:@"Set Weapon:"] intValue];
 }
old_weap(instance, id);
}

void(*old_weapupdate)(void *instance, int id);
void new_weapupdate(void *instance, int id) {
 if([switches isSwitchOn:@"Set Weapon:"]) {
  new_weap(instance, id);
 }
old_weapupdate(instance, id);
}


}

void setup() {
HOOK(0x1C706B4, new_weapupdate, old_weapupdate);
HOOK(0x1C671B8, new_weap, old_weap);


[switches addTextfieldSwitch:@"Set Weapon:"
              description:@"Set Weapon"
                inputBorderColor:UIColorFromHex(0x7000E8)];


[switches addEachSwitch:NSSENCRYPT("Radar Hack")];


  [switches addSwitch4:NSSENCRYPT("Watermark")
    description:NSSENCRYPT("Here you can enter your own gold amount")
    value:1];


[switches addEachSwitch:NSSENCRYPT("Radar Hack")];



  [switches addRightSwitch4:NSSENCRYPT("Crosshair")
    description:NSSENCRYPT("Here you can enter your own gold amount")
    value:40];

[switches addEachSwitch:NSSENCRYPT("Radar Hack")];


  [switches addSwitch3:NSSENCRYPT("Rainbow Chams")
    description:NSSENCRYPT("Here you can enter your own gold amount")
    value:40];

  [switches addSlidrSwitch4:NSSENCRYPT("Watermark X:")
    description:NSSENCRYPT("Set your custom move speed")
    value:1
    minimumValue:0
    maximumValue:200
    sliderColor:UIColorFromHex(0xBD0000)]; 

  [switches addSlidrSwitch4:NSSENCRYPT("Watermark Y:")
    description:NSSENCRYPT("Set your custom move speed")
    value:40
    minimumValue:0
    maximumValue:200
    sliderColor:UIColorFromHex(0xBD0000)]; 

[switches addEachSwitch:NSSENCRYPT("Radar Hack")];

  [switches addRightSwitch3:NSSENCRYPT("Rainbow WireFrame")
    description:NSSENCRYPT("Here you can enter your own gold amount")
    value:80];

[switches addEachSwitch:NSSENCRYPT("Radar Hack")];

  [switches addSwitch3:NSSENCRYPT("Rainbow Glow")
    description:NSSENCRYPT("Here you can enter your own gold amount")
    value:80];

[switches addEachSwitch:NSSENCRYPT("Radar Hack")];



  [switches addRightSwitch3:NSSENCRYPT("Rainbow Sky")
    description:NSSENCRYPT("Here you can enter your own gold amount")
    value:120];

[switches addEachSwitch:NSSENCRYPT("Radar Hack")];



  [switches addSwitch3:NSSENCRYPT("Rainbow OutLine")
    description:NSSENCRYPT("Here you can enter your own gold amount")
    value:120];

[switches addEachSwitch:NSSENCRYPT("Radar Hack")];



  [switches addSliderSwitch3:NSSENCRYPT("OutLine Width:")
    description:NSSENCRYPT("Set your custom move speed")
    value:120
    minimumValue:0
    maximumValue:15
    sliderColor:UIColorFromHex(0xBD0000)]; 

[switches addEachSwitch:NSSENCRYPT("Radar Hack")];



  [switches addSwitch3:NSSENCRYPT("Set Chams Color")
    description:NSSENCRYPT("Here you can enter your own gold amount")
    value:120];

[switches addEachSwitch:NSSENCRYPT("Radar Hack")];

 

  [switches addSlidrSwitch3:NSSENCRYPT("Red Chams:")
    description:NSSENCRYPT("Set your custom move speed")
    value:120
    minimumValue:0
    maximumValue:255
    sliderColor:UIColorFromHex(0xBD0000)]; 

[switches addEachSwitch:NSSENCRYPT("Radar Hack")];



  [switches addSlidrSwitch3:NSSENCRYPT("Green Chams:")
    description:NSSENCRYPT("Set your custom move speed")
    value:120
    minimumValue:0
    maximumValue:255
    sliderColor:UIColorFromHex(0xBD0000)]; 

[switches addEachSwitch:NSSENCRYPT("Radar Hack")];

  [switches addSlidrSwitch3:NSSENCRYPT("Blue Chams:")
    description:NSSENCRYPT("Set your custom move speed")
    value:120
    minimumValue:0
    maximumValue:255
    sliderColor:UIColorFromHex(0xBD0000)]; 

[switches addEachSwitch:NSSENCRYPT("Radar Hack")];

  [switches addSwitch3:NSSENCRYPT("Set WireFrame Color")
    description:NSSENCRYPT("Here you can enter your own gold amount")
    value:120];

[switches addEachSwitch:NSSENCRYPT("Radar Hack")];

  [switches addSlidrSwitch3:NSSENCRYPT("Red W.F:")
    description:NSSENCRYPT("Set your custom move speed")
    value:120
    minimumValue:0
    maximumValue:255
    sliderColor:UIColorFromHex(0xBD0000)]; 

[switches addEachSwitch:NSSENCRYPT("Radar Hack")];

  [switches addSlidrSwitch3:NSSENCRYPT("Green W.F:")
    description:NSSENCRYPT("Set your custom move speed")
    value:120
    minimumValue:0
    maximumValue:255
    sliderColor:UIColorFromHex(0xBD0000)]; 

[switches addEachSwitch:NSSENCRYPT("Radar Hack")];

  [switches addSlidrSwitch3:NSSENCRYPT("Blue W.F:")
    description:NSSENCRYPT("Set your custom move speed")
    value:120
    minimumValue:0
    maximumValue:255
    sliderColor:UIColorFromHex(0xBD0000)]; 

[switches addEachSwitch:NSSENCRYPT("Radar Hack")];

  [switches addSwitch3:NSSENCRYPT("Set Glow Color")
    description:NSSENCRYPT("Here you can enter your own gold amount")
    value:120];

[switches addEachSwitch:NSSENCRYPT("Radar Hack")];

  [switches addSlidrSwitch3:NSSENCRYPT("Red Glow:")
    description:NSSENCRYPT("Set your custom move speed")
    value:120
    minimumValue:0
    maximumValue:255
    sliderColor:UIColorFromHex(0xBD0000)]; 

[switches addEachSwitch:NSSENCRYPT("Radar Hack")];

  [switches addSlidrSwitch3:NSSENCRYPT("Green Glow:")
    description:NSSENCRYPT("Set your custom move speed")
    value:120
    minimumValue:0
    maximumValue:255
    sliderColor:UIColorFromHex(0xBD0000)]; 

[switches addEachSwitch:NSSENCRYPT("Radar Hack")];

  [switches addSlidrSwitch3:NSSENCRYPT("Blue Glow:")
    description:NSSENCRYPT("Set your custom move speed")
    value:120
    minimumValue:0
    maximumValue:255
    sliderColor:UIColorFromHex(0xBD0000)]; 

[switches addEachSwitch:NSSENCRYPT("Radar Hack")];

  [switches addSwitch3:NSSENCRYPT("Set Sky Color")
    description:NSSENCRYPT("Here you can enter your own gold amount")
    value:120];

[switches addEachSwitch:NSSENCRYPT("Radar Hack")];

  [switches addSlidrSwitch3:NSSENCRYPT("Red Sky:")
    description:NSSENCRYPT("Set your custom move speed")
    value:120
    minimumValue:0
    maximumValue:255
    sliderColor:UIColorFromHex(0xBD0000)]; 

[switches addEachSwitch:NSSENCRYPT("Radar Hack")];

  [switches addSlidrSwitch3:NSSENCRYPT("Green Sky:")
    description:NSSENCRYPT("Set your custom move speed")
    value:120
    minimumValue:0
    maximumValue:255
    sliderColor:UIColorFromHex(0xBD0000)]; 

[switches addEachSwitch:NSSENCRYPT("Radar Hack")];

  [switches addSlidrSwitch3:NSSENCRYPT("Blue Sky:")
    description:NSSENCRYPT("Set your custom move speed")
    value:120
    minimumValue:0
    maximumValue:255
    sliderColor:UIColorFromHex(0xBD0000)]; 

[switches addEachSwitch:NSSENCRYPT("Radar Hack")];

  [switches addSwitch3:NSSENCRYPT("Set OutLine Color")
    description:NSSENCRYPT("Here you can enter your own gold amount")
    value:120];

[switches addEachSwitch:NSSENCRYPT("Radar Hack")];

  [switches addSlidrSwitch3:NSSENCRYPT("Red OutLine:")
    description:NSSENCRYPT("Set your custom move speed")
    value:120
    minimumValue:0
    maximumValue:255
    sliderColor:UIColorFromHex(0xBD0000)]; 

[switches addEachSwitch:NSSENCRYPT("Radar Hack")];

  [switches addSlidrSwitch3:NSSENCRYPT("Green OutLine:")
    description:NSSENCRYPT("Set your custom move speed")
    value:120
    minimumValue:0
    maximumValue:255
    sliderColor:UIColorFromHex(0xBD0000)]; 

[switches addEachSwitch:NSSENCRYPT("Radar Hack")];

  [switches addSlidrSwitch3:NSSENCRYPT("Blue OutLine:")
    description:NSSENCRYPT("Set your custom move speed")
    value:120
    minimumValue:0
    maximumValue:255
    sliderColor:UIColorFromHex(0xBD0000)]; 




}
void setupMenu() {
  
  [menu setFrameworkName:"UnityFramework"];

  menu = [[Menu alloc]  
            initWithTitle:NSSENCRYPT(" ")
            titleColor:[UIColor whiteColor]
            titleFont:NSSENCRYPT("Copperplate-Bold")
            credits:NSSENCRYPT("This Mod Menu has been made by melonwer, do not share this without proper credits and my permission. \n\nEnjoy!")
            headerColor:UIColorFromHex(0x000000)//(0x000000)
            switchOffColor:UIColorFromHex(0x110631)
            switchOnColor:UIColorFromHex(0x231747)
            switchTitleFont:NSSENCRYPT("AppleSDGothicNeo-Bold")
            switchTitleColor:[UIColor whiteColor]
            infoButtonColor:UIColorFromHex(0x473A6F)
            maxVisibleSwitches:5 
            menuWidth:500
            menuIcon:@""
            menuButton:@""];

    setup();
}
static void didFinishLaunching(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef info) {

NSUserDefaults *check;
check = [NSUserDefaults standardUserDefaults];


timer(0.5) {
setupMenu();
  });
}


%ctor {

CFNotificationCenterAddObserver(CFNotificationCenterGetLocalCenter(), NULL, &didFinishLaunching, (CFStringRef)UIApplicationDidFinishLaunchingNotification, NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
}