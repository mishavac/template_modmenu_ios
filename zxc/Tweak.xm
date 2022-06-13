#import "Macros.h"
#include <OpenGLES/ES3/gl.h>
#include <OpenGLES/ES3/glext.h>
#include "dlfcn.h"
#include "Unity.h"
#include "Vector3.h"

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

#define _DRAW_R_ [[switches getValueFromSwitch:@"Red:"] floatValue]
#define _DRAW_G_ [[switches getValueFromSwitch:@"Green:"] floatValue]
#define _DRAW_B_ [[switches getValueFromSwitch:@"Blue:"] floatValue]

if([switches isSwitchOn:@"Set Chams Color"]){
    glDepthRangef(1, 0.5); 
 glBlendColor(GLfloat(_DRAW_R_), GLfloat(_DRAW_G_), GLfloat(_DRAW_B_), 1);
    glColorMask(_DRAW_R_,_DRAW_G_,_DRAW_B_, 0); 
    glEnable(GL_BLEND); 
    glBlendFunc(GL_SRC_ALPHA, GL_ONE); 
    _glDrawElements(mode, count, type, indices); 
    glDepthRangef(0.5, 1); 
    glColorMask(1, 1, 1, 1); 
    glDisable(GL_BLEND); 
}

if([switches isSwitchOn:@"WireFrame Red Chams"]){
    glDepthRangef(1, 0.5);
    glColorMask (255, 0, 0, 0);
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE);
    _glDrawElements(mode = GL_LINES, count = 8000, type, indices);
    glDepthRangef(0.5, 1);
    glColorMask(1, 1, 1, 1);
    glDisable(GL_BLEND);
}
    if([switches isSwitchOn:@"WireFrame Green Chams"]){
    glDepthRangef(1, 0.5);
    glColorMask (0, 255, 0, 0);
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE);
    _glDrawElements(mode = GL_LINES, count = 8000, type, indices);
    glDepthRangef(0.5, 1);
    glColorMask(1, 1, 1, 1);
    glDisable(GL_BLEND);
}
    if([switches isSwitchOn:@"WireFrame Blue Chams"]){
    glDepthRangef(1, 0.5);
    glColorMask (0, 0, 255, 0);
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE);
    _glDrawElements(mode = GL_LINES, count = 8000, type, indices);
    glDepthRangef(0.5, 1);
    glColorMask(1, 1, 1, 1);
    glDisable(GL_BLEND);
}
if([switches isSwitchOn:@"Width:"]){
float line = [[switches getValueFromSwitch:@"Width:"] floatValue];

glLineWidth(line);
}
}
}
%ctor {
MSHookFunction((dlsym(RTLD_DEFAULT, "glDrawElements")), (void *)$glDrawElements, (void **)&_glDrawElements);
MSHookFunction((dlsym(RTLD_DEFAULT, "glGetUniformLocation")), (void *)$glGetUniformLocation, (void **)&_glGetUniformLocation);
}

void (*_aim)(void* player, void* player1, int player2, float player3);
void aim(void* player, void* player1, int player2, float player3) {
	if([switches isSwitchOn:@"HitBox Body Aim"]) {
	  *(float *)((uint64_t) player1 + 0x2C) = 2.5f;
   }
	_aim(player, player1, player2, player3);
}

int(*old_get_Gloves)(void *this_);
int get_Gloves(void *this_) {

  int userAmount = [[switches getValueFromSwitch:@"Set Gloves:"] intValue];

  if([switches isSwitchOn:@"Set Gloves:"]) {
    return userAmount;
  }
  return old_get_Gloves(this_);

}



void setup() {

[switches addOffsetSwitch:@"Radar Hack"
              description:@"Radar Hack"
                offsets:{0x1C7CE48}
                  bytes:{"0x200080D2C0035FD6"}];

[switches addOffsetSwitch:NSSENCRYPT("AntiFlash")
    description:NSSENCRYPT("")
    offsets: {
      ENCRYPTOFFSET("0x18C452C")
      // Шифровка + офсет
    }
    bytes: {
      ENCRYPTHEX("0x000080D2C0035FD6")
      // Шифровка + офсет
    }

];  


[switches addOffsetSwitch:@"Money Hack"
              description:@"Money"
                offsets:{0x1C64824}
                  bytes:{"0x00008052C0035FD6"}];


}



void setupMenu() {


  [menu setFrameworkName:"UnityFramework"];

  menu = [[Menu alloc]  
            initWithTitle:NSSENCRYPT("REZOLVER")
            titleColor:UIColorFromHex(0x000000)
            titleFont:NSSENCRYPT("Copperplate-Bold")
            credits:NSSENCRYPT("never tap 3000")
            headerColor:UIColorFromHex(0xc72c36)
            switchOffColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5]
            switchOnColor:UIColorFromHex(0xFBE1E1)
            switchTitleFont:NSSENCRYPT("Copperplate-Bold")
            switchTitleColor:[UIColor whiteColor]
            infoButtonColor:UIColorFromHex(0xFFFFFFDD)
            maxVisibleSwitches:5
            menuWidth:270
            menuIcon:@""
            menuButton:@"/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAkGBwgHBgkIBwgKCgkLDRYPDQwMDRsUFRAWIB0iIiAdHx8kKDQsJCYxJx8fLT0tMTU3Ojo6Iys/RD84QzQ5Ojf/2wBDAQoKCg0MDRoPDxo3JR8lNzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzf/wgARCAH0AfQDASIAAhEBAxEB/8QAGwABAAIDAQEAAAAAAAAAAAAAAAMFAgQGAQf/xAAaAQEAAwEBAQAAAAAAAAAAAAAAAQMEAgUG/9oADAMBAAIQAxAAAAHhgAAAAAAAAAHuScE2UdwZyo6w9yOvPRIJ9x9Ix8zIjxmI1/NnyeNdLg5xE8gAAAAAAAAAAAAAAAAAGUsdRSZotB2NiGu6G3454d9LseOfk+x9W95j5bF9X56KeGj7RGfh/O4g67450+n3dSN3Tt0eCevI5TnX82Ypqje+TwAAAAAAAAAAAAAAJE4S5ubgdlj11fPG3fc5U8Ulzkq4CIAAc90PPc5dYc4AAEMyZp67qVunh/Oxpr9tOyxv1+RTHOsnhmnwTyAAAAAAAAAAAezR15mRee9Jyoe2vdnNV56VcAAAAAOe6HnucusOcAAAAAEPPdOsv4Z09Bs9TX89WXw4bMc0xCawAAAAAAAAGSaO3pF6bZ+jV86twZKQiAAAAAAHPdDz3ObWHPngAAAAAMchzdV3NJr9KhGn0MIdnCaoRNQAAAAAAD3yeOvfSNC2fS6eIdgy1AgAAAAAABz3QUPGbUEeeAAAAAAABVc729do3cu982epHFswzTgJrAAAAAEicsznQ39b6fXE2wY6QQAAAPD1yFBa+nOc6OsEHnutwxh9efXVw3FVqwYC2kAAAAAAACo53uef1ejTDV6MGOxrznCeQAAAPdjDPm9750vPXTXBioCIAAAAVFvRdPmA9CM/snxj7Bmnc891sbyE8+sOTHIiqiuKvZhjFtIAAAAAAAHL13Y8hu9jGORdp1nvnWYAABljPHWQjRP9T4vp8eK2Y5V2AAAADAfOMKDXAXnX8g5fY4OK7XwuQzwAAwzIp8bas24MBZUAAAAAAAorrV02cmng1+7hDswTViJrAAynwz5vbWr0tddoPP8AEmt6JNvVKC663yibQHK9R8duWmrWtUB0AAWtU5XnUfO7TLH0geJyAAjkTFPjdQaclY3YbKoHvndYAAAh7S68Xm7kNMaNH1XOV+pBhm59DWe+dZgHvmaZhzp2Ow5/ocXkhRjAZYixtOay609O0vKd218p+lxI+UPouptnhWeGyQkAbXcZ4+e9B01njjMeZAAAAAHkUyedWCxd11GF1hbVURZafp5c8DdwEgFfYRxZzL3yr6GOLY15oCeE0OxFnpLzb0u/575vgBHIAAFhtVtlj3hVcBzvDfW+X9KeLHq9Jofo2ePbU8LkOQAAAAAAAA1e+aPA+n8kJAAAc/q3FPV7zX2IXeAmn3Yhmi5aVfQ013AweKAAAB7cU1lRo2Bl2gKi31+3ytLF9H2+qfOPp3mc+jzIAAAAAAAAAVNtzu/NAPcwAAAAQ831XM8enHHJjx6MA6zSyY5c6HWcn2ufFIMfmAAAANrVy56uBg9IEgV9P1C5q7RUCAAAAAAAAAEPOW1T7nnhvzgAAAKG+p+dlaK/Z1nrrLP757zpz7bjeyyeaGbAAAAABaTaO9h9EOLAAAAAAAAAAAABhMUer759P5Qd8gAAAK2y0OdFIK/dgZJzSvPY07fXcj12Pywz4QAAAAJLamuc2sM+oAAAAAAAAAAABob9Xpqqh9F5gAAAADS3dKLqIVe/G9TTl757Fuz2HF9pk80M2AAAAACez1drHvCq4AAAAAAAAAAABr7DrnlksX0/lB1AAAADR3q7m+mFfvYMU588o5Iu97fh+xzYdgZPNAAAAEsTZ5Hn+mCQAAAAAAAAAAAAKeuvaL3/ADg2UAAAAKq1pOdegK/ageOsucsE/N7puZu6aL4YfHAAAAb2ja03yjJuAAAAAAAAAAAAAAcx09J6OXRHtYQAAAHO9BzHHo+ee4cenCOszZ1p4sy3dL3mzuEM3m+AEQAABnb6G/k2hToAAAAAAAAAAAAAAaG/jbxzD3z6XygkAABp0NjXVe2ilgi/EdUJYsomcRp6G45bqcPjBTmAAEPcXM9BtVbLVqbWPR6OOgAAAAAAAAAAABq9RtKfQ2V7OprT+35+Q64AAee60dUUZV9F5rzQzUE1gT5Qzc6Pew464ozdCMXkDCWcMUe3nLE1wEnviE+xoKu7ra5tlu6lze1kuukM2HQHMgAAAAFNWehV1Wly3m2q60tJtrliNHITAEuzo+8c76CeusIhS23Nceh4ecerFgdZgQA2NeSO5csUX9nLy93m8OWE2Zg7AAAAAASX/OSZLula+x4PoBz0AAAocab28wexnAAAAAAZYjblr/KuYK33zN7iKTXkE0gAAbHsE/Ohe0U01dI89t8EAAAAAAACXoOamxX9Gwz8L0AiQFNnznr5w9zMAAAAAAAAq9qvz+iMadseB1mBAAACaFHWy89jRYXXK23XnWgs8sAAAAAAACe95ufFf0THLwfQU8vM+vQHuZgAAAAAAAEWdVXp8xMvqoMo5pCawAAAAMp9aSLJRF13v8te9+TuDvAAAAAAAABtb1Pp578PD0AAAAAAAADxXcXYwmT12GWvPATSAAAAAABLJrSxbJ74i25seVsu/MuB35oAAAAAADT3NPvuMW2AAAAAAAMcK2vTnCZfUeIHLw6oAAAAAAAAAlk1s4smEXbtvzfs5OpVVpZ5XomoAAAABp7mn33GLbAAAAABFHUurqw0b8sSnax8hmv3wmkAAAAAAAAAAD2aBHWyjki9PALze5Wfrz+jV+5358gmsAABp7mn33GLbAAABFHUuOjrVa9rV8UbhjHeUWOM0hNYAAAAAAAAAAAAD3wTZ62UWzsM4se+E7W9Tpo6SblZOsnTKGeaLdWSK9/T81+0rXxss2mnHFlh5Vx8W2WvqONGeBXePE++RxzXJGTUCAAAAAAAAAAAAAAAAHvglz10d7LXzjuVhk79CQAAADzxGSLFzPhCnjPAngEAAAAAAAAAAAAAAAAAAAAAAPQ9yI7z9ItxwJr88J48CAAAAAAAAAAAAAP/xAArEAACAQIGAQMFAQEBAQAAAAABAgMABBAREiAwQAUTITEUIjIzUDQjFTX/2gAIAQEAAQUC7GVaa01lvyrTWmtNZfztNaay6GVaay/kZVp4Qjmha3Br6G6o2s4P081GNxxFf4gFAbooZZqi8PcvUfhIxUfjLRKWGJNlz+7DLOmhiamsYTTePNPazJvK/wAELtgtZriofCzGoPF2sVABRvuf3b3iR6ksFNPZzLR9tpXuhdttZT3NW3iIY6UBRxXP7uKSGOWpbFhRBU4kUR2gNkMUkz2XiY4wPbluf3ckkSSi4tGj2kdcDOgMsQCTZ+JllMEMcCc1z+7mntEkqSF4thXqgZ0MYonmexsI7Vehc/u5yAwu7X09hHTAz2WlpJdyWlrHax9G5/d0bqz2EdEDOhjY2Ml28MSQR9K5/d0ru19SiCDgw6AGWPj7NruVQFHTuR/06d5B6q4sOZRjZ2r3U0MSQR9N2zojMSJoPTvbbXsI5FGMMTTSWdstrDyX/mPTYeXuw3j/ACiXJ2O2eLDUGUqenfW+nE8YxAJPjbMWsPJ5VyljgjaXibVHg7Z7WAYOhQ9O8g9J8GHEox8LamSbl81/8/G0OdrTtvZQwdSp6U8fqxEEHA8C4wxNNLbwrBFyMwRfK+Q+pbHxPkxEGcEcDLqBBB6XkIcWHAMfHx+ksV1QOfGzBR5O/a5k2+KvircLoGDKVPQZsqY6hMnpvgdy420Xqy4RyNHUVwr8HkfK/TufLXhqa+uZl3p5C5RV8rcg2N8t0N7qHDAqeUnKmfG6TVHg25cbCPTFsinZKSRXGw+wncvNx+NbTe8JiQ0YKMTjiZ6+dsyaJMDvgj9WUDIbQSCl0wpHVxgxGV9bPbzcfiLdnuOTLOjElGBaMLUVIxZ8qLE77xM0wbYuPjkzk4ASpWQsuEkaSA+NtjVx4qJo3Uo222ha4lj8Zbqg8dbAqoQdEopq5yD8Ei6kwPxivxhZJot+G3P27fJ2PrAgg4xRtK9hZrap1XOp+G5XTLgcRhGuuQew4YTk+7y9onp4+PtUgh6ty2mLivV+3Bvmhj49c5+Me42+V/xY2/6Oret78Uy6osHwX5w8av2ccBzTbcRetDLG0T1aQNPMPYdWZtUvG40vR+KXGzXTb8cB+7dc2cVzX/jR6oLeOBerM2iPkuhlNivxggyTjU5HvXre3Jej7sD8j4pPduWI5p3bltU3Je/jg3zhB7zctue67aV+eW8/VgfnC1/0cqHJ+5eNlHy3f6cDQwtf9H8q9HNd/pwNDC2/0csIzfuTrqi5bz9OBofFRe0vLbj7e7KumTkvf14H5X4oUPccijJe7er9/JfHE/K4251Q8cYzfvXS6ouS8P8A1xXHx7Z2/Hbj+Aw0txznOajgPnDxrfdxxDJO/drlLxMchg3xstG0XHEozb+BeLnHxXTZQ4PivxhC+uLhtx7/AMBhqX44r1s3wPzguPjnzThhGSfwbldM3C7a32j5wsW03HAXpZ5FpbuluYzQIPce4iSnv1p72Zq9ViQwPBcHTDg20fFD2MEnqxbWeiSdoJFCaQUt04pbpDSyI3TZgtPeQrT+QNG7nNNI7bg5oEHdePm+DbVx8fLk+JYCixPIsjrS3TiopBIvLNfaWe6mej78fxSybJG0ITmaO8YAkGGQSxn2pn6COUaKQSLx3l1n0ASKV88LyTNsG3qcbScxMTn0kdkMMolXhursnpvMUX5wPCMbaXWnSjkMbI4dd97c5dSRtTYMeFTjE+hwcx0opDGyMHXbeXWjqTtkMDxqcbafR1IpTGY3Ei43V3o6jvoBOZwJz5B742s3Uhk9N1YMKvLj016bEKHbUcGPKDlstp9fUglMZubpY0JJPSJyEj6zgx51OI9jDOJOpJ+XSJyEkmvEnLoqdkFxq6cn5dFiFEjl9h6QOyC5y6Un5dB3CBmLHEnqA7IZzHUcqydCT8ud5gKJJOBOXXB2A5GK6oHMcsn5cruFp5C2wnsg0DsjlaOo7lG5ZPy42YLTTbS3cDbUleOo7pTSurcUn5cJkUU0xO0mic+9nQO5LiRaS7WllRt8n5bfijKgozmixO4t/CzoHeHZaFzIKF21fWCvq46+qipp0J9ZK9da9evXajI54C38bOtVZ9TVWr+XnWqtVZ8mqtVZ/wBPOszWeOdZ1n3f/8QALBEAAQMCBgEEAQUBAQAAAAAAAQACEQMEEBIgITAxQRMyQFEiBTNCYXEUUv/aAAgBAwEBPwHiAJQplemFlCgYQsoXphGmi0j4gaSgwDHMF6i9RVrh1MSF/wB7vpC/HkJt5SKa5rusC0FFhHwAJQYBgXAIvKnRd+zQCR0mXdVv9qneMd3tgWgpzSOVrZQEImEXzru/ZrpXD6fSpXDKmDmfXG1s4OdHDd+zht7v+L8Hs8jha2cHOjiuvZxW11l/F3WD2+dYEoCE50cZ3VallMjritLj+DsHNjUwQETHCEdFWll664rWr6jIPYREjS0ScHXLC/LxHQRKqUizhpVfSfmTXBwkKoPOhggK4qenTnCnWcxU6zX8pEp1sfCNJ48apwsKsjIUROIEnC9fL8v1op3Lm9rMpU6Z1loPaNFhRtvop2xjRRfkeHYVBvhTG6JgSnuzOJ00HSzEHlcYErvTbPz0gVUG2FPpXTstI6rd28aTx3LoZGr9Pd21O6wZ0r8/iBqYcrp+Bcul8arExVxHSvzuNdJ0t53GTOq1MVhg7vC+9412x75qxOQ66H7rcHdodK/9w10GwzmIkQiIMarb90YO7TelfjYHUBJhDbnuGw/VZCawwKp9K8bNLVbiXfAuW/jOr9PbuXI9YUynNzNhEQY027YbPwHtzNI1WbMtL/VUO2DTBwu2Zav+6WV2RCDmnrmmEarQnjedDG5nAICBCqHfFpkK8p5mT9YzoFR48oXLh2hctPaBkSNZqtCNc+EXuPnQWoiMLClLs5wJnFhg4XFL0nxw0quT/ECCJGmpV8DhFIuMNVKmKbMoVQ+NLTIVxR9VkcVGrk2PS7xqVPA4rSlAzlHZEzpaYOF5bT+beKjWybHrCrUjYcVvR9QyesHu8a2OjbC6tcpzs64qdVwGXio0TUP9JrQ0QE90bcLH+Dhc2f8AKnws74aNuam56TWhogJzo42v+8K1oypuNiqtF9M/lrZ3ra0uMBUrQDd+Dnx1ytdCBBTmhwgqrYA7sT6L2e4aWd6Q0u6VOzJ3cmU2s9qlOf8AXwBU+0DOD7ak/sJ36f8A+SnWNUI2tYeE2hUnpehU+kLWqULI+Sm2tNqAAwNT6RM/DFQoVAsw1SEagRqFEz8kEoIkqef/xAAsEQACAQIFAgYCAgMAAAAAAAABAgMAEQQSIDAxECEFEzJAQVEiIxRhQlBx/9oACAECAQE/Adu9X1Xq/uTIorzxXn0ZzX8g/VfyP6oTIaBB49s0irRmPxRJOg6L2oTOKWdTz7IsBzTyk8azrSQrSSK2+8mWiSdg7MU3w27JJl7DaYjjailt2O3I+XWIWNMpXsejuEF6LEm5qKTN2O1DJ/idljYXom51J6h0xHAp3CC5pmLG56xyZtqF8w2JZLm2uKK3c9GUMLGsUjI/5aOKjkzbMEbk36DTK2Vel6v1hQMe9ZRoZVbkVPhoyhsO+gG1CcfNCRTpRC5sKjwyr3PRhqnb8raL02IAqLGFG7jtQx0R0TYhIvVU2OVlsmsEihKwoT/dQQBgGagAOOp0Hoxub6ZRZuuDxVv1t0xE/krencucx2o1zsFoCwtpPNDoalNk1TjtfrE2VweniLDsu34emaXN9am0Yg9tTC4toTESILA0SSbnb8PjyxZvvU3GjEcjXILNvAXNqjXIoXUeNGI9Wuf43sGAZlvrPGjEcjXKbtvI2Vg1KcwvqPGjEcDUTYewwL5of+am46mphdNUxsvsPDns5X71N1NEXFqPbTMfyt7CF8kgbU3OmYWfQiM/FSYGa9x3po3T1DeVGf0ik8Onb4tSRsiAHUNE63XoAT2FR4b5egAOOrQRNytP4dGfT2p/DpB6TemUqbHXF4dM/c9qTwlB6zSYSBOFoADjqUoi3RjrGGu39UiKg7bGKwomFxzTKUOU6cDgLfsk2WW3foNQNtrF4USi45ogg2PXAYG/7JNqVvjZU7WLwolGYc0e1YDBB/2ScbUj5dsHabBxyyBztO+Wib7gbZTnZeTLRN94G1A31pzrJtTS/Xsg1X0pzpJAppvqixPPsrdbms1ZhVxSML1nWvNWjN9UZGPW3tbbNv8AWf/EADYQAAECAgcGBQMEAgMAAAAAAAEAAhEwAyAhIjFAURIyQVBhcRATI4GRM6GxQlJwcgRiY4KS/9oACAEBAAY/Av4asY4+ysoKT/yvoPUDROX03K1jvjmvpUbndgr+yzuV6lK49rF9KP8Aa1XaNg9qjvG1W0bVZEK4/wCVuR7ct9KjJ6r1XtaOlq3Ns6uUGgAdJDpF9oK9N0O6wj2UDyf02Xf3HBRpvUd9lBogOkt0u+33UaM7XRQIgeR7FE0uKDqe+/TgJzpsHhRbebyCAtKjT+mzTiVsUTQ0T3T4tuuV9vvnQyjbtOKjvUnF2RdkIERC2qPd/Gb2WYcXaLZoxbxdrknZLbovduZ/bR8XIMoxBoybsnts3/yoGw5b/jG8UA0QAyhdwOUi3fH3yuw3D9R0Qo6MQaMrArplPMZvcRrk20dGIuKDG+51m7H+OA48XKO2D0gtikGzSfmrAeMCoHKeYzDjkYDFW/UdvGbSFuPiHDgU12o8bKsDlYt3DkPOduMw6mc+pRf18ICvAq3JlvwoHGc2jZi5No2YCbtOMAF5dH9MfeoKGn3eDtFdMmBUDk/Nb/2nebg8/hQpPlWSyXGACLWH0h963k0rrpwlWqByUDgiPiYG8OPjdKgbDINFQiLhiSvqfZbNJSEiQGh+CtIPsoEQeOEmBn2eMeLZm2cXVdQrpqlPceJmUcrBWFYSrKxEprNVAVohX7QotPjCKMd04GYKQi62basFYSrLVaJe1xEpz9BJiDBA+MHtBC3EfKuuRa4QIrBjUA5sTqo+WoNEBkrQtluEkjWUNTbKhpW8yj3x91A41AxgiStXnE5YnWUetshrdSoSu9c07bHD71ARa53HLHrZLDtJEf2iZGs+oztlmtluHSQ52pmdqzmHiEWOFo8A1vuoZZxmEda7OtsyGte+LdV9QwUKMQyxM09a7R0mA59rZrT0rDvOGePSya2szvOIzpdpO961H3nA52Gs73rUfflbXTvetR953bOkTvesw9Z0c84TR3ygGeDtZrBXYekwZ/tNhoK8NDMJ5ARpMd3rvb7zByCOssmQ3rZLA5DHSWeslrtRKJ5CRrLDdJLmaSu/Ij1tlF2skdbJNixV5vwsYd1YY5y88eyuMJ7qyDeyi47Ul0qITXfNaxW1bFvlWwKvAhWOGTvEBb0eyuM+Vvw7K84n3rWqyts8BLNGf1YZGxxV6BUR8Ti2jEeq34dlbMtqFyiZcRiEHjwsyEWqImGjoz3OT2Bwxm7P6SrclFq68ZRZRGzieRQO8MnEKLZBo6PHicp0nhyiMnEKLa2xR73E6ZSGuR2Xbv4ylnwoioWUePE6ZWJyWw72ykeHFRGHhsN3z9spEqJymy7e/OU/1Vy1xwUTjk4ldMrEKBsdyeJXTMbL8deSxK6ZrZpMNeSW5yBtarp5BdtUTnohQpPlRGd6ciun2V66czaVd5NdKv2FXXA5TFXbOV4x7q+IKxwnYqwK08wscQsY91a0K1pWBXH4XFcVgVurgsf5Y//EACoQAQABAgUEAQQDAQEAAAAAAAERADEQITBBUSBAYXGBUJGhscHR8OHx/9oACAEBAAE/Ie4E0cqhUeKg6JeWoqNQwqqXH00FoW9AqHYIaTSz6QNoBo/jYdX8fKp/66fCJslIX+1VmFES4ns0EGuCkT6GrQnUpFCQCj9j+KivVmlhD5VPxGmjK3UkWB9lXSfFfoW0Wy+BVwQ5z05MN+mJrgpEv34LaoOm1T8D70jPGs6oFfLZ/FeMACOwRfykVmSPjMUJIT50FIIlx6EGoLd7yUEdDNj0aR7PE5D4oaQLAg7ZEZC8L1PwnK9ThBs9EtIdyE1HfoFJOxtQZl//AGzoAAACwd0ooXzuUmz8u50JNQ27sAEKlg3oRP8A4Xih3hi7775Tsfhs01mB9nRvHbARi3bYFFoimZt6+gpwZLjSqJd50J+zmUEYxRg3rUu4L1/ohSSOf+I6J+xkUIMSGSO3+Cjj/mfRmIRDcURChccd01wl6Acyh/8AiUJQUAbdmsEtJ2gIcjZ8OKRGEhMYM9aDElknPhV+8wfPZ2qTBagYJGl5FZ7SAjksYnOonU3HGTgYKzc2/O1FgloHMLlqngHKhom1x0vEMRXcr8zOe0lJZ7eHnESUkaQloywBCqYA3odEc7g8arfRCJxZpDJNeDhxsrOmEFRFts9mgkJJWTXD48Y72lAYwOzdYqPh/fRMPDCXg69glQv4PZ893XmmZwGExEOgJcSSlo9UH2T93nVaCuFprY/3dCN/7M6JZg7miX2ynQZnZ2i8f2xkNAwYuPgXijSUQEoTk0w6AlWnyiQB+XUDlZDdnSgQz2eykB78U7XVyuFb+mJh6hLj8nPSrZFsFpyONq/LPoRg+MCmLD1SV03LT12rJA2SVJhuGjjeTloQlvs0oDWAStK5ZMcum58YiTqEGOXH9PTDi+NqZSeOlyuCrzy6jsN2NFBuTXGPVf8AXrkHqkS5GiBlmaVUr08E3PWJh6Alx4EWfqgAIDI6pko8lOQPMXrNQxllcUCmUnl1ESX55dVFgfdI4+q2Ao2ylzTEMhm1eXrGL/xxO/Qc5xbYIvl0ZwlyVLS5Srdw9jyKSn96ijDbO9S8lCdQx3u8FQQa63ouBlzR0wbHZWFqTyAZ6Pg9Tle+BnoHFmnlaUr5OqePKzKMhQZI9C8u2QQORLXltpZPtkY3Y2YRzxUABYI0o02ydaTN5HQKeBK+2ydfI05d+ocTgEuPz00xhE2pQDfq/TxL1+D7aTiEusQGXTQeMamS+nUFGkNCYE9lMrgoQcO24pmDU8Zrrv8ApGepG+sK+OL0ZhXhUTvJ57bleMtX7+YNqb9B4sBqeDGr99Fzc3V92hjcxhD5Gt69l33iOqHN89AYGH462fy5neg5spVK3dU5HjGaFuw33x3sTz61/wBMb6sOw0JQN6CAO8eNq2tf9MbqswUJ460a7Zu9j65may+4Y3Yy8AdaFcnvvBLlqvJ5xPEKEeGlA8mr4sO+g4SNX8g9Fbj6W6ke+e/mXfPqzDEN6vx9kjU/X9+kiNmpx3RqS30ws6b3EBqQ75+geKGdOTNiaWVecHgL0WwnOyl86fmh+gwO96fmmTFYqcBkyXr5LNKXin0E0dkUikbmlCFhOLnE9sZ1u5PWlG/L6F4joigS2KmLdg26HGKMrkXRGZZ/NZcTOEpf71XN+igZIeHvMvkcZqH9wyVsm8KZ9+1Wl+NCcckGLy6XOBIJCWa5hT7uoTLNV0dKEpPVWb5M6s38NXwfvV33z2YUieWrEn4020HLr+JAV+RbqG5FG5uqGLy+8VL0vOMZoZZvbovN+K8aalhnzVsfhqzl34axEcd7lVwQ4y0lSlfOmKpGtj76vbEWNikS454KDrUk4E3hJK3DLnDSBLSuWXsCzZ/utze5xqbRrH+uwtrQZbOEFYze2LzjriYxmJzd9mkudlM6H91IDIWaTsJby+uzk8y2JpVK5rgoNFyY51fynZ/euc0WbL9aENWfLi7TPtlsZHRgceDi/qgBJG3Z7ONzmhzSPVFWz9oMluf6YuDTkyxkF45PaJPnG/KvvzOOidDbaSyy37Mpd9ima44WqZpjDShjLD57/wCO0Te7FA3lYEqZG2ztFNik+2GOwaszogT5N+0crVygEg/w80yWVdezBEgKTwLGMGWvsOKQSEtX/vx2l3swkICrQIGMClnsNlxGGS9FBY28uzu9lKGClONhisUpey23oSOZs4VfM7G72OcM3YqdL4xWCpO023o+zFxQW9w37C72GQZn4qdEvQFW/bR3oZxQERNyv6nQAkjZNa7rXfN4KueXDojpZ7hCgehLY5WrKfkW1buoFMVO5GDmlVlzeji7zk6eIeG1BwP1V+DB0rulsX4rLMjnelVlZegCk74IoXptmXrgbiiLq5M9A9d6lLkPdcw9U20e6vc9KhXB9CGUL1/iIa2v6K3S9NH9qo3B+K8lDVH7Kf8AwU7FDx+5pSwKuD+KWb59ShXBSz9FEUc6A9nNIpT9LEUUBUKnSk5pFPGl1K/UZalhDoamlUup1L3n/9oADAMBAAIAAwAAABAAAAAAAAAAARa9+3x286E4gAAAAAAAAAAAAAAAAAAv53ruvvTx3PH38cAAAAAAAAAAAAAAAAb3dCMEEFf777xzvT6YAAAAAAAAAAAB93tsEEEEEFf7777747nykAAAAAAAAAAbziAEEEEEEFb7777777/H1kgAAAAAAB/zqIEEEEEEEF77777777767S0AAAAAAB3iIEEEEU4MFBx3777777775i0cAAAAC7uAEEEEEWCJDzz9H777777765PgkAABd1skEEEEXEAB7zzz5j77777777zS0AAD/wBeNLBBIiAAAwS88881y2+++8Qgz5JAEcX++uY0/AKAADP888888vfY6BAAV1DAe7/++++0889AL+888888888thAAAA8MA9r+++++d886K/wDPPPPPPPPPKQAAAAEfgFvfvvvvv/fPP/vPPPPPPPPPKQAAAABLfXX/AL777777zzzzzzzzzzzzz2AAAAAAL39xb777775Dzzzz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"];    

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
    alert.customViewColor = [UIColor redColor];  
    alert.showAnimationType = SCLAlertViewShowAnimationSlideInFromCenter;   
    
    [alert showSuccess: nil
            subTitle:NSSENCRYPT("ну как там с деньгами?") 
              closeButtonTitle:nil
                duration:99999999.0f];
  });
}


%ctor {
  CFNotificationCenterAddObserver(CFNotificationCenterGetLocalCenter(), NULL, &didFinishLaunching, (CFStringRef)UIApplicationDidFinishLaunchingNotification, NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
}