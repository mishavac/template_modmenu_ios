//
//
// Made By @GitDev
// 
// 

// source code skinchanger for standoff2
// with buttons and gloves hack 

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

// объясняю как работает, ты создал кнопку в коде выше с названием "Usp - Genesis" в setup ты должен прописать свичт с этим же названием иначе не будет работать 

// перейдём к хукам 
// примеры + офсеты на старую версию (обновил бы если бы был доступ к пк, а так все сами)

// HOOK(0x1c0b3b0, new_weap, old_weap); 
                                                           - выдача скинов 
// HOOK(0x1c125b4, new_weapupdate, old_weapupdate); 

// HOOK(0x18cc530, new_skin, old_skin); - скины

// HOOK(0x1ac3754, get_Gloves, old_get_Gloves); - перчатки 

