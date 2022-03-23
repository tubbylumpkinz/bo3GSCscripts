

// FILE MERGE: [ main.gsc ]


#include scripts\shared\persistence_shared;
#include scripts\shared\scoreevents_shared;
#include scripts\codescripts\struct;
#include scripts\shared\callbacks_shared;
#include scripts\shared\clientfield_shared;
#include scripts\shared\math_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\shared\hud_util_shared;
#include scripts\shared\hud_message_shared;
#include scripts\shared\hud_shared;
#include scripts\shared\array_shared;
#include scripts\shared\rank_shared;
#include scripts\shared\flag_shared;
#include scripts\shared\ai_shared;
#include scripts\shared\exploder_shared;
#include scripts\shared\flagsys_shared;
#include scripts\shared\gameobjects_shared;
#include scripts\shared\load_shared;
#include scripts\shared\lui_shared;
#include scripts\shared\sound_shared;
#include scripts\shared\spawner_shared;
#include scripts\shared\laststand_shared;
#include scripts\shared\music_shared;
#include scripts\shared\player_shared;
#include scripts\shared\trigger_shared;
#include scripts\shared\scoreevents_shared;
#include scripts\shared\table_shared;
#include scripts\shared\challenges_shared;
#include scripts\shared\weapons_shared;
#include scripts\shared\weapons\_weapons;
#include scripts\shared\visionset_mgr_shared;

#include scripts\cp\gametypes\_globallogic;
#include scripts\cp\gametypes\_globallogic_actor;
#include scripts\cp\gametypes\_globallogic_player;
#include scripts\cp\gametypes\_globallogic_vehicle;
#include scripts\cp\gametypes\_hostmigration;
#include scripts\cp\_achievements;
#include scripts\cp\gametypes\_save;
#include scripts\cp\_laststand;
#include scripts\cp\_challenges;
#include scripts\cp\_collectibles;
#include scripts\cp\_decorations;
#include scripts\cp\_skipto;
#include scripts\cp\_util;
#include scripts\cp\_accolades;

#namespace infinityloader;

autoexec __init__sytem__()
{
    system::register("infinityloader", ::__init__, undefined, undefined);
}

autoexec repair()
{
    callback::on_connect(::FixBrokenStats);
}

__init__()
{
    callback::on_start_gametype(::init);
    callback::on_connect(::onPlayerConnect);
    callback::on_spawned(::onPlayerSpawned);
}

init()
{
    level.player_out_of_playable_area_monitor = undefined;
    
   
        level.callbackPlayerDamage = ::DamageOverride;
        level.callbackPlayerKilled = ::PlayerKilledOverride;
        level._Weapons  = EnumerateWeapons("weapon");
        level._Maps     = ["cp_mi_eth_prologue", "cp_mi_zurich_newworld", "cp_mi_sing_blackstation", "cp_mi_sing_biodomes", "cp_mi_sing_sgen", "cp_mi_sing_vengeance", "cp_mi_cairo_ramses", "cp_mi_cairo_infection", "cp_mi_cairo_aquifer", "cp_mi_cairo_lotus", "cp_mi_zurich_coalescence"];
        level._MapNames = ["Black Ops", "New World", "In Darkness", "Provocation", "Hypocanter", "Vengeance", "Rise & Fall", "Demon Within", "Sand Castle", "Lotus Towers", "Life"];


    
    level.strings          = [];
    level.status           = ["Unverified", "Verified", "VIP", "Admin", "Co-Host", "Host"];
    level._Achievements    = ["CP_COMPLETE_PROLOGUE", "CP_COMPLETE_NEWWORLD", "CP_COMPLETE_BLACKSTATION", "CP_COMPLETE_BIODOMES", "CP_COMPLETE_SGEN", "CP_COMPLETE_VENGEANCE", "CP_COMPLETE_RAMSES", "CP_COMPLETE_INFECTION", "CP_COMPLETE_AQUIFER", "CP_COMPLETE_LOTUS", "CP_HARD_COMPLETE", "CP_REALISTIC_COMPLETE","CP_CAMPAIGN_COMPLETE", "CP_FIREFLIES_KILL", "CP_UNSTOPPABLE_KILL", "CP_FLYING_WASP_KILL", "CP_TIMED_KILL", "CP_ALL_COLLECTIBLES", "CP_DIFFERENT_GUN_KILL", "CP_ALL_DECORATIONS", "CP_ALL_WEAPON_CAMOS", "CP_CONTROL_QUAD", "CP_MISSION_COLLECTIBLES",  "CP_DISTANCE_KILL", "CP_OBSTRUCTED_KILL", "CP_MELEE_COMBO_KILL", "CP_COMPLETE_WALL_RUN", "CP_TRAINING_GOLD", "CP_COMBAT_ROBOT_KILL", "CP_KILL_WASPS", "CP_CYBERCORE_UPGRADE", "CP_ALL_WEAPON_ATTACHMENTS", "CP_TIMED_STUNNED_KILL", "CP_UNLOCK_DOA", "ZM_COMPLETE_RITUALS", "ZM_SPOT_SHADOWMAN", "ZM_GOBBLE_GUM", "ZM_STORE_KILL", "ZM_ROCKET_SHIELD_KILL", "ZM_CIVIL_PROTECTOR", "ZM_WINE_GRENADE_KILL", "ZM_MARGWA_KILL", "ZM_PARASITE_KILL", "MP_REACH_SERGEANT", "MP_REACH_ARENA", "MP_SPECIALIST_MEDALS", "MP_MULTI_KILL_MEDALS", "ZM_CASTLE_EE", "ZM_CASTLE_ALL_BOWS", "ZM_CASTLE_MINIGUN_MURDER", "ZM_CASTLE_UPGRADED_BOW", "ZM_CASTLE_MECH_TRAPPER", "ZM_CASTLE_SPIKE_REVIVE", "ZM_CASTLE_WALL_RUNNER", "ZM_CASTLE_ELECTROCUTIONER", "ZM_CASTLE_WUNDER_TOURIST", "ZM_CASTLE_WUNDER_SNIPER", "ZM_ISLAND_COMPLETE_EE", "ZM_ISLAND_DRINK_WINE", "ZM_ISLAND_CLONE_REVIVE", "ZM_ISLAND_OBTAIN_SKULL", "ZM_ISLAND_WONDER_KILL", "ZM_ISLAND_STAY_UNDERWATER", "ZM_ISLAND_THRASHER_RESCUE", "ZM_ISLAND_ELECTRIC_SHIELD", "ZM_ISLAND_DESTROY_WEBS", "ZM_ISLAND_EAT_FRUIT", "ZM_STALINGRAD_NIKOLAI", "ZM_STALINGRAD_WIELD_DRAGON", "ZM_STALINGRAD_TWENTY_ROUNDS", "ZM_STALINGRAD_RIDE_DRAGON", "ZM_STALINGRAD_LOCKDOWN", "ZM_STALINGRAD_SOLO_TRIALS", "ZM_STALINGRAD_BEAM_KILL", "ZM_STALINGRAD_STRIKE_DRAGON", "ZM_STALINGRAD_FAFNIR_KILL", "ZM_STALINGRAD_AIR_ZOMBIES", "ZM_GENESIS_EE", "ZM_GENESIS_SUPER_EE", "ZM_GENESIS_PACKECTOMY", "ZM_GENESIS_KEEPER_ASSIST", "ZM_GENESIS_DEATH_RAY", "ZM_GENESIS_GRAND_TOUR", "ZM_GENESIS_WARDROBE_CHANGE", "ZM_GENESIS_WONDERFUL", "ZM_GENESIS_CONTROLLED_CHAOS", "DLC2_ZOMBIE_ALL_TRAPS", "DLC2_ZOM_LUNARLANDERS", "DLC2_ZOM_FIREMONKEY", "DLC4_ZOM_TEMPLE_SIDEQUEST", "DLC4_ZOM_SMALL_CONSOLATION", "DLC5_ZOM_CRYOGENIC_PARTY", "DLC5_ZOM_GROUND_CONTROL", "ZM_DLC4_TOMB_SIDEQUEST", "ZM_DLC4_OVERACHIEVER", "ZM_PROTOTYPE_I_SAID_WERE_CLOSED", "ZM_ASYLUM_ACTED_ALONE", "ZM_THEATER_IVE_SEEN_SOME_THINGS"];
    level.WeaponCategories = ["Assault Rifles", "Submachine Guns", "Shotguns", "Light Machine Guns", "Sniper Rifles", "Launcher", "Pistols", "Specials"];
    level.saveGravity      = GetDvarInt("bg_gravity");
    
    level thread KillTriggers();
    level thread CacheCamos();
    level thread CacheWeapons();
    level thread onPlayerConnect();
}

GetKillStreakNames(killstreaks)
{
    if(level.killstreaks[killstreaks].menuName == "killstreak_helicopter_player_gunner")
        String = "Mothership";
    else if(level.killstreaks[killstreaks].menuName == "killstreak_uav")
        String = "UAV";
    else if(level.killstreaks[killstreaks].menuName == "killstreak_counteruav")
        String = "Counter-UAV";
    else
        String = MakeLocalizedString(level.killstreaks[killstreaks].menuName);
    
    return String;
}

onPlayerConnect()
{
    if(bool(level.AntiJoin))
        Kick(self GetEntityNumber());
        
    if(self isHost())
        self thread initializeSetup(5, self);
        
}

onPlayerSpawned()
{
    if(!isDefined(self.access) && !isDefined(self.ShownNoAccess))
    {
        self.ShownNoAccess = true;
        iPrintLn("I Am " + self.name + " And My Access Level Is: ^1Unverified");
    }
        
    self SetBlur(0, .01);
}

MenuAccessSpawn()
{
    self endon("disconnect");
    
    if(self IsHost())
    {
        self waittill("spawned_player");
        self FreezeControls(false);
    }
    
    self IPrintLn("Elite Mossy Remake Menu Ready. Press ^2Aim & Knife ^7To Open");
    self IPrintLn("Access Level: ^2" + level.status[self.access] + ". ^7Created By ^2ItsFebiven. ^7Base By ^2Extinct");
}

DamageOverride(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, weapon, vPoint, vDir, sHitLoc, vDamageOrigin, psOffsetTime, boneIndex, vSurfaceNormal)
{
    if(bool(self.godmode) || bool(self.noclipExt) || IsDefined(self.CamRunning) || bool(self.SpecGod))
        return;
        
    if(bool(self.DemiGodmode))
    {
        self FakeDamageFrom(vDir);
        return;
    }
    
    if((isDefined(self.PHDPerk) && self.PHDPerk) && (sMeansOfDeath == "MOD_SUICIDE" || sMeansOfDeath == "MOD_PROJECTILE" || sMeansOfDeath == "MOD_PROJECTILE_SPLASH" || sMeansOfDeath == "MOD_GRENADE" || sMeansOfDeath == "MOD_GRENADE_SPLASH" || sMeansOfDeath == "MOD_EXPLOSIVE"))
        return 0;
        
    self [[globallogic_player::Callback_PlayerDamage]](eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, weapon, vPoint, vDir, sHitLoc, vDamageOrigin, psOffsetTime, boneIndex, vSurfaceNormal);
}

PlayerKilledOverride(eInflictor, attacker, iDamage, sMeansOfDeath, weapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration, enteredResurrect)
{
    if(bool(self.godmode) || bool(self.noclipExt) || IsDefined(self.CamRunning) || bool(self.SpecGod))
        return;
    
    self [[globallogic_player::Callback_PlayerKilled]](eInflictor, attacker, iDamage, sMeansOfDeath, weapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration, enteredResurrect);
}





CacheWeapons()
{
    level.Weapons = [];
    weapNames = [];
    weapon_types = array("assault", "smg", "cqb", "lmg", "sniper", "launcher", "pistol", "special");

    foreach(weapon in level._Weapons)
        weapNames[weapNames.size] = weapon.name;

    for(i=0;i<weapon_types.size;i++)
    {
        level.Weapons[i] = [];
        for(e=1;e<100;e++)
        {
            weapon_categ = tableLookup("gamedata/stats/cp/cp_statstable.csv", 0, e, 2);
            weapon_name  = TableLookupIString("gamedata/stats/cp/cp_statstable.csv", 0, e, 3);
            weapon_id    = tableLookup("gamedata/stats/cp/cp_statstable.csv", 0, e, 4);
            if(weapon_categ == "weapon_" + weapon_types[i])
            {
                if(IsInArray(weapNames, weapon_id))
                {
                    weapon = spawnStruct();
                    weapon.name = weapon_name;
                    weapon.id = weapon_id;
                    level.Weapons[i][level.Weapons[i].size] = weapon;
                }
            }
        }
    }

    foreach(weapon in level._Weapons)
    {
        if(!weapons::is_primary_weapon(weapon) || !weapons::is_side_arm(weapon))
            continue;
            
        isInArray = false;
        for(e=0;e<level.Weapons.size;e++)
        {
            for(i=0;i<level.Weapons[e].size;i++)
            {
                if(isDefined(level.Weapons[e][i]) && level.Weapons[e][i].id == weapon.name)
                {
                    isInArray = true;
                    break;
                }
            }
        } 
        if(!isInArray && weapon.displayname != "")
        {
            weapons      = spawnStruct();
            weapons.name = MakeLocalizedString(weapon.displayname);
            weapons.id   = weapon.name;
            level.Weapons[7][level.Weapons[7].size] = weapons;
        }
    }
    
    extras      = ["defaultweapon"];
    extrasNames = ["Default Weapon"];
    foreach(index, extra in extras)
    {
        weapons = spawnStruct();
        weapons.name = extrasNames[index];
        weapons.id = extra;
        level.Weapons[7][level.Weapons[7].size] = weapons;
    }
}
CacheCamos()
{
    level._Camos = [];
    for(e=0;e<290;e++)
    {
        row = TableLookupRow("gamedata/weapons/common/weaponoptions.csv", e);
        
        if(!isdefined(row) || !isdefined(row.size) || row.size < 3)
            continue;
            
        if(row[1] != "camo")
            continue;
            
        level._Camos[level._Camos.size] = constructString(replaceChar(row[2], "_", " "));
    }
}

replaceChar(string, substring, replace)
{
    final = "";
    for(e=0;e<string.size;e++)
    {
        if(string[e] == substring)
            final += replace;
        else 
            final += string[e];
    }
    return final;
}

constructString(string)
{
    final = "";
    for(e=0;e<string.size;e++)
    {
        if(e == 0)
            final += toUpper(string[e]);
        else if(string[e-1] == " ")
            final += toUpper(string[e]);
        else 
            final += string[e];
    }
    return final;
}

// FILE MERGE: [ menuUtils.gsc ]
menuMonitor()
{
    self endon("disconnected");
    self endon("end_menu");
    while( true )
    {
        if(!self.menu["isLocked"])
        {
            if(!bool(self.menu["isOpen"]))
            {
                if( self meleeButtonPressed() && self adsButtonPressed() )
                {
                    self menuOpen();
                    wait .2;
                }               
            }
            else 
            {
                if( self attackButtonPressed() || self adsButtonPressed() )
                {
                    self.menu[ self getCurrentMenu() + "_cursor" ] += self attackButtonPressed();
                    self.menu[ self getCurrentMenu() + "_cursor" ] -= self adsButtonPressed();
                    self scrollingSystem();
                    
                    wait .15;
                }
                
                else if( (self ActionSlotThreeButtonPressed() || self ActionSlotFourButtonPressed()) && ( !IsSubStr(self getCurrentMenu(), "client_") || !self isInMain() ) )
                {
                    self.menu[ "submenu_cursor" ] += self ActionSlotThreeButtonPressed();
                    self.menu[ "submenu_cursor" ] -= self ActionSlotFourButtonPressed();
                    
                    if(self getSubmenuCurs() > getSubmenus().size-1)
                        self setSubmenuCurs( 0 );
                        
                    if(self getSubmenuCurs() < 0)
                        self setSubmenuCurs( getSubmenus().size-1 );
                        
                     self thread newMenu( self getSubmenus()[getSubmenuCurs()].p1 );
                    
                    wait .15;
                }
                
                else if( self useButtonPressed() )
                {
                    menu = self.eMenu[self getCursor()];
                    self thread doOption(menu.func, menu.p1, menu.p2, menu.p3, menu.p4, menu.p5);
                    wait .15;
                }
                
                else if( self meleeButtonPressed() )
                {
                    if( self isInMain() )
                        self menuClose();
                    else
                        self newMenu();
                        
                    wait .2;
                }
            }
        }
        wait .05;
    }
}

doOption(func, p1, p2, p3, p4, p5, p6)
{
    if(!isdefined(func))
        return;
    if(isdefined(p6))
        self thread [[func]](p1,p2,p3,p4,p5,p6);
    else if(isdefined(p5))
        self thread [[func]](p1,p2,p3,p4,p5);
    else if(isdefined(p4))
        self thread [[func]](p1,p2,p3,p4);
    else if(isdefined(p3))
        self thread [[func]](p1,p2,p3);
    else if(isdefined(p2))
        self thread [[func]](p1,p2);
    else if(isdefined(p1))
        self thread [[func]](p1);
    else
        self thread [[func]]();
}

menuOpen()
{
    self endon("MenuClosed");
    self.menu["isOpen"] = true;
    self SetBlur(13, .01);
    self menuOptions();
    self drawText(); 
    visionset_mgr::activate("visionset", "overdrive", self); 
    self newMenu(self getSubmenus()[getSubmenuCurs()].p1);
    self updateScrollbar();
}

menuClose()
{
    self SetBlur(0, .01);
    self destroyAll(self.menu["OPT"]);
    visionset_mgr::deactivate("visionset", "overdrive", self);
    self notify("MenuClosed");
    self.menu["isOpen"] = false;
}

drawText()
{
    self endon("MenuClosed");
    if(!isDefined(self.menu["OPT"]))
        self.menu["OPT"] = [];
        
    self.menu["OPT"]["BG"] = self createRectangle("CENTER", "CENTER", 0, 0, 1000, 1000, (0, 0, 0), "white", 0, .6);
        
    for(e=0;e<3;e++)
    {
        fontscale = 1.7;
        if(e == 1)
            fontscale = 1.9;
        
        self.menu["OPT"]["TITLE" + e] = self createText("default", fontscale, "CENTER", "CENTER", -140 + (e * 140), -205, 3, 0, "", (1, 1, 1));//185    
        self.menu["OPT"]["TITLE" + e] thread hudFade(1, .2);
    }
    self refreshTitle();

    for(e=0;e<15;e++)
    {
        self.menu["OPT"][e] = self createText("default", 1.5, "CENTER", "TOP", 0, 60 + (e * 18), 3, 0, "", (1, 1, 1));
        self.menu["OPT"][e] thread hudFade(1, .2);
    }
    self setMenuText();
}

getSubmenus()
{
    self endon("MenuClosed");
    
    if(IsDefined( self.submenus ))
        return self.submenus;
        
    self.submenus = [];
    for(e=0;e<self.eMenu.size;e++)
    {
        if(isDefined(self.eMenu[e].func) && self.eMenu[e].func == ::newMenu)
            self.submenus[self.submenus.size] = self.eMenu[e];
    }
        
    return self.submenus;
}

getSubmenuCurs()
{ 
    return self.menu[ "submenu_cursor" ];
}

setSubmenuCurs( val )
{ 
    self.menu[ "submenu_cursor" ] = val;
}

refreshTitle()
{
    self endon("MenuClosed");
    if(IsSubStr(self getCurrentMenu(), "client_") || !self isInMain())
    {
        for(e=0;e<3;e++)
        {
            if(e == 1)
            {
                self.menu["OPT"]["TITLE" + e ] setText(self.MenuTitle);
                self.menu["OPT"]["TITLE" + e ].color = (getSubmenusColourAccess(self.currentMenuColour)[0], getSubmenusColourAccess(self.currentMenuColour)[1], getSubmenusColourAccess(self.currentMenuColour)[2]);
            }
            else
            {
                self.menu["OPT"]["TITLE" + e ] setText( "" );
                self.menu["OPT"]["TITLE" + e ].color = (1, 1, 1);
            }
        }
    }
    else
    {
    
        for(e=0;e<3;e++)
        {
            self.menu["OPT"]["TITLE" + e ] setText(self getSubmenus()[revalueTitles(getSubmenuCurs() + (e - 1), getSubmenus())].opt);
            if(e == 1)
            {
                self.menu["OPT"]["TITLE" + e ].color = (getSubmenusColourAccess(self.currentMenuColour)[0], getSubmenusColourAccess(self.currentMenuColour)[1], getSubmenusColourAccess(self.currentMenuColour)[2]);
            }
            else
                self.menu["OPT"]["TITLE" + e ].color = (1, 1, 1);
        }
            
    }
}
    
isInMain()
{
    self endon("MenuClosed");
    for(e=0;e<getSubmenus().size;e++)
        if( getSubmenus()[e].p1 == getCurrentMenu() )
            return true;
            
    return false;
}
 
revalueTitles(value, array)
{
    if(value < 0) return value + array.size;
    if(value >= array.size) return value - array.size;
    return value;
}

scrollingSystem()
{
    if(self getCursor() >= self.eMenu.size || self getCursor() < 0 || self getCursor() == 13)
    {
        if(self getCursor() <= 0)
            self.menu[ self getCurrentMenu() + "_cursor" ] = self.eMenu.size -1;
        else if(self getCursor() >= self.eMenu.size)
            self.menu[ self getCurrentMenu() + "_cursor" ] = 0;
        self setMenuText();
        self updateScrollbar();
    }
    if(self getCursor() >= 14)
        self setMenuText();
    else 
        self updateScrollbar();
}

updateScrollbar()
{
    self endon("MenuClosed");
    curs = self getCursor();
    if(curs >= 14)
        curs = 13;
        
    self notify("stop_text_effects");
    wait .05;  
    self.menu["OPT"][curs] thread flashElemMonitor( self );  
    self.menu["OPT"][curs] thread flashElem( 1, .5, .13, self );   
}

setMenuText()
{
    self endon("MenuClosed");
    ary = 0;
    if(self getCursor() >= 14)
        ary = self getCursor() - 13;
        
    for(e=0;e<20;e++)
    {
        if(isDefined(self.eMenu[ e ].opt))
            self.menu["OPT"][ e ] setText( self.eMenu[ ary + e ].opt );
        else     
            self.menu["OPT"][ e ] setText( "" );
    }
}
        
flashElem( alpha1, alpha2, time, player )
{
    player endon("MenuClosed");
    player endon("stop_text_effects");
    self.fontScale = 1.9;
    for(;;)
    {
        r          = randomint(255); g = randomint(255); b = randomint(255);
        self.color = ( (r / 255), (g / 255), (b / 255) );
        self fadeOverTime(.2);
        wait .2;
    }
}

flashElemMonitor( player )
{
    player endon("MenuClosed");
    player waittill("stop_text_effects");  
    self.color     = (1, 1, 1);
    self.fontScale = 1.5;
}

// FILE MERGE: [ structure.gsc ]
initializeSetup( access, player, allaccess )
{
    if(isDefined(player.access) && access == player.access && !player isHost())
        return self iprintln("^1Error ^7" + player.name + " is already this access level.");
    if(isDefined(player.access) && player.access == 5 )
        return self iprintln("^1Error ^7You can not edit players with access level Host.");
    if(isDefined(player.access) && player == self)
        return self iprintln("^1Error ^7You can not edit you're own access level.");
            
    player notify("end_menu");
    player.access = access;
    
    if( player isMenuOpen() )
        player menuClose();

    player.menu = [];
    player.previousMenu = [];
    player.menu["isOpen"] = false;
    player.menu["isLocked"] = false;

    if( !isDefined(player.menu["current"]) )
         player.menu["current"] = "main";
         
    if(player != self && !IsDefined(allaccess))
        self IPrintLn(player.name + " Access Set " + level.Status[player.access]);
        
    player menuOptions();
    player thread MenuAccessSpawn();
    player thread menuMonitor();
}

AllPlayersAccess(access)
{
    if(level.players.size <= 1)
        return IPrintLn("^1Error: ^7No Players Found");
    
    self IPrintLn("All Players Access Set " + level.Status[access]);
    foreach(player in level.players)
    {
        if(player isHost() || player == self)
            continue;
            
        self thread initializeSetup(access, player, true);
        wait .1;
    }
}

newMenu( menu )
{
    if(!isDefined( menu ))
    {
        menu = self.previousMenu[ self.previousMenu.size -1 ];
        self.previousMenu[ self.previousMenu.size -1 ] = undefined;
    }
    else 
        self.previousMenu[ self.previousMenu.size ] = self getCurrentMenu();
        
    self setCurrentMenu( menu );
    self menuOptions();
    self setMenuText();
    self refreshTitle();
    self updateScrollbar();
}

addMenu( menu, title, access )
{
    self.storeMenu = menu;
    if(self getCurrentMenu() != menu)
        return;
        
    self.currentMenuColour = access;
    self.MenuTitle         = title;
    self.eMenu             = [];
    if(!isDefined(self.menu[ menu + "_cursor"]))
        self.menu[ menu + "_cursor"] = 0;
    if(!IsDefined(self.menu[ "submenu_cursor" ]))   
        self.menu[ "submenu_cursor" ] = 0;
}

addOpt( opt, func, p1, p2, p3, p4, p5 )
{
    if(self.storeMenu != self getCurrentMenu())
        return;
        
    option      = spawnStruct();
    option.opt  = opt;
    option.func = func;
    option.p1   = p1;
    option.p2   = p2;
    option.p3   = p3;
    option.p4   = p4;
    option.p5   = p5;
    self.eMenu[self.eMenu.size] = option;
}

addOptDesc( opt, title, shader, desc, func, p1, p2, p3, p4, p5 )
{
    if(self.storeMenu != self getCurrentMenu())
        return;
        
    option        = spawnStruct();
    option.opt    = opt;
    option.title  = title;
    option.shader = shader;
    option.desc   = desc;
    
    option.func   = func;
    option.p1     = p1;
    option.p2     = p2;
    option.p3     = p3;
    option.p4     = p4;
    option.p5     = p5;
    self.eMenu[self.eMenu.size] = option;
}

setCurrentMenu( menu )
{
    self.menu["current"] = menu;
}

getCurrentMenu()
{
    return self.menu["current"];
}

getCursor()
{
    return self.menu[ self getCurrentMenu() + "_cursor" ];
}

isMenuOpen()
{
    if( !isDefined(self.menu["isOpen"]) || !self.menu["isOpen"] )
        return false;
        
    return true;
}

// FILE MERGE: [ utilities.gsc ]
createText(font, fontScale, align, relative, x, y, sort, alpha, text, color, isLevel)
{
    if(isDefined(isLevel))
        textElem = level hud::createServerFontString(font, fontScale);
    else 
        textElem = self hud::createFontString(font, fontScale);

    textElem hud::setPoint(align, relative, x, y);
    textElem.hideWhenInMenu = true;
    textElem.archived = false;

    textElem.sort           = sort;
    textElem.alpha          = alpha;
    textElem.color = color;

    textElem SetText(text);
    return textElem;
}

createRectangle(align, relative, x, y, width, height, color, shader, sort, alpha, server)
{
    if(isDefined(server))
        boxElem = newHudElem();
    else
        boxElem = newClientHudElem(self);

    boxElem.elemType = "icon";
    boxElem.color = color;
    if(!level.splitScreen)
    {
        boxElem.x = -2;
        boxElem.y = -2;
    }
    boxElem.hideWhenInMenu = true;
    boxElem.archived = false;
    
    boxElem.width          = width;
    boxElem.height         = height;
    boxElem.align          = align;
    boxElem.relative       = relative;
    boxElem.xOffset        = 0;
    boxElem.yOffset        = 0;
    boxElem.children       = [];
    boxElem.sort           = sort;
    boxElem.alpha          = alpha;
    boxElem.shader         = shader;

    boxElem hud::setParent(level.uiParent);
    boxElem setShader(shader, width, height);
    boxElem.hidden = false;
    boxElem hud::setPoint(align, relative, x, y);
    return boxElem;
}

isInArray( array, text )
{
    for(e=0;e<array.size;e++)
        if( array[e] == text )
            return true;
    return false;        
}

getName()
{
    name = self.name;
    if(name[0] != "[")
        return name;
    for(a = name.size - 1; a >= 0; a--)
        if(name[a] == "]")
            break;
    return(getSubStr(name, a + 1));
}

destroyAll(array)
{
    if(!isDefined(array))
        return;
    keys = getArrayKeys(array);
    for(a=0;a<keys.size;a++)
    if(isDefined(array[keys[a]][0]))
        for(e=0;e<array[keys[a]].size;e++)
            array[keys[a]][e] destroy();
    else
        array[keys[a]] destroy();
}
    
bool(variable)
{
    return isdefined(variable) && int(variable);
}

toUpper( string )
{
    if( !isDefined( string ) || string.size <= 0 )
        return "";
    alphabet = strTok("A;B;C;D;E;F;G;H;I;J;K;L;M;N;O;P;Q;R;S;T;U;V;W;X;Y;Z;0;1;2;3;4;5;6;7;8;9; ;-;_", ";");
    final    = "";
    for(e=0;e<string.size;e++)
        for(a=0;a<alphabet.size;a++)
            if(IsSubStr(toLower(string[e]), toLower(alphabet[a])))         
                final += alphabet[a];
    return final;            
}

hudFade(alpha, time)
{
    self endon("StopFade");
    self fadeOverTime(time);
    self.alpha = alpha;
    wait time;
}

hudMoveX(x, time)
{
    self moveOverTime(time);
    self.x = x;
    wait time;
}

hudMoveY(y, time)
{
    self moveOverTime(time);
    self.y = y;
    wait time;
}

hasMenu()
{
    if( IsDefined( self.access ) && self.access != "None" )
        return true;
    return false;    
}

getSubmenusColourAccess(access)
{
    switch(access)
    {
        case 2:
            colour = (1, 1, 0);
            break;
            
        case 3:
            colour = (1, 0, 1);
            break;
            
        case 4:
            colour = (0, 1, 1);
            break;
            
        default:
            colour = (1, 1, 1);
            break;
    }
        
    return colour;
}

// FILE MERGE: [ custom_structure.gsc ]
menuOptions()
{
    self addMenu("main", "Main Menu");
    self addOpt("Account", ::newMenu, "Account");
    self addOpt("Verified", ::newMenu, "Verified");
    self addOpt("Statistics", ::newMenu, "Statistics");
    self addOpt("Fun Menu", ::newMenu, "Fun Menu");
    
    if(self.access >= 2)
    {
        self addOpt("Teleportation", ::newMenu, "Teleportation");
        self addOpt("Weapons", ::newMenu, "Weapons");
        self addOpt("Camo Menu", ::newMenu, "Camo Menu");
    }
        
    if(self.access >= 3)
    {
        self addOpt("Aiming", ::newMenu, "Aiming");
        self addOpt("Bot Menu", ::newMenu, "Bot Menu");
    }
    
    if(self.access >= 4)
    {
        self addOpt("Player Menu", ::newMenu, "clients");
        self addOpt("All Players", ::newMenu, "All Players");
        self addOpt("Server Setting", ::newMenu, "Server Setting");
    }

    self addMenu("Account", "Account");
    self addOpt("Max Rank & Prestige", ::MaxRank, self);
    self addOpt("Complete All Maps", ::UnlockMaps, self);
    self addOpt("All Challenges", ::grab_stats_from_table, self);
    self addOpt("10x Unlock Tokens", ::UnlockTokensCP, self);
    self addOpt("All Weapon Unlocks", ::MaxWeaponRanks, self);
    self addOpt("All Collectibles", ::FindAllCollectible, self);
    self addOpt("All Decorations", ::GetAllCPDecorations, self);
    self addOpt("Legit Stats", ::CustomStats, self);
    self addOpt("Unlock All Achievements", ::UnlockAchievements, self);
    self addOpt("Modded ClanTag", ::EditClanTag);
    
    self addMenu("Prestige", "Prestige");
    for(e=1;e<=11;e++)
        self addOpt("Prestige " + e, ::SetPrestige, e);

    self addMenu("Verified", "Verified");
    self addOpt("Suicide", ::KYS, self);
    self addOpt("Invulnerability", ::Godmode, self);
    self addOpt("Demi-Godmode", ::DemiGodmode);
    self addOpt("Bind Noclip", ::NoClip);
    self addOpt("Reduced Spread", ::NoWeaponSpread);
    self addOpt("Unlimited Sprint", ::SetPerkCheck, "specialty_unlimitedsprint");
    self addOpt("Movement Speed x2", ::PSpeed);
    self addOpt("Unlimited Equipment", ::UnlmEquipment);
    self addOpt("Unlimited Ammo", ::UnlmAmmo);
    self addOpt("Unlimited Ammo Stock", ::UnlmAmmoReload);
    
    self addMenu("Statistics", "Statistics");
    self addOpt("+50,000 Kills", ::SetCustomStats, "kills", 50000);
    self addOpt("+20,000 Deaths", ::SetCustomStats, "deaths", 20000);
    self addOpt("+2,000 Wins", ::SetCustomStats, "wins", 2000);
    self addOpt("+1,000 Losses", ::SetCustomStats, "losses", 1000);
    self addOpt("+15,000 Hits", ::SetCustomStats, "hits", 15000);
    self addOpt("+10,000 Misses", ::SetCustomStats, "misses", 10000);
    self addOpt("+10,000 Total Shots", ::SetCustomStats, "total_shots", 10000);
    self addOpt("+1,000,000 Score", ::SetCustomStats, "score", 1000000);
    self addOpt("+50,000 Headshots", ::SetCustomStats, "headshots", 50000);
    self addOpt("+5 Days", ::SetCustomStats, "time_played_total", 432000);
    self addOpt("+10 Winstreak", ::SetCustomStats, "kills", 50000);
    self addOpt("Reset Stats", ::resetStats);
        
    self addMenu("Fun Menu", "Fun Menu", 1);
    self addOpt("No Explosive Damage", ::CustPHDPerk);
    self addOpt("Invisibility", ::Invisible, self);
    self addOpt("Third Person", ::ThirdPerson, self);
    self addOpt("Multi Jump", ::Multijump);
    self addOpt("Spectate Nade", ::specNade);
    self addOpt("Cluster Grenades", ::ClusterGrenades);
    self addOpt("Clone Me", ::CloneMe, 0);
    self addOpt("Dead Clone", ::CloneMe, 1);
    self addOpt("Infinite Specialist", ::InfiniteHeroPower);
    self addOpt("Auto Dropshot", ::AutoDropShot);
    
    
    self addMenu("Weapons", "Weapons", 2);
    for(e=0;e<level.WeaponCategories.size;e++)
        self addOpt(level.WeaponCategories[e], ::newMenu, level.WeaponCategories[e]);
    self addOpt("Refill Current Ammo", ::WepOpt, 3);
    self addOpt("Drop Current Weapon", ::WepOpt, 2);
    self addOpt("Take Current Weapon", ::WepOpt, 0);
    self addOpt("Take All Weapons", ::WepOpt, 1);
       
    for(e=0;e<level.WeaponCategories.size;e++)
    {
        self addMenu(level.WeaponCategories[e], level.WeaponCategories[e], 2);
        foreach(Weapon in level.Weapons[e])
        {
            if(Weapon.name == "Beast Weapon" && level.script != "zm_zod" || Weapon.name == "The Undead-Zapper" && level.script == "zm_factory" || Weapon.name == "H.I.V.E.")
                continue;
                        
            self addOpt(Weapon.name, ::give_Weapon, getWeapon(Weapon.id));
        }
    }
        
    self addMenu("Camo Menu", "Camo Menu", 2);
    for(e=0;e<level._Camos.size;e++)
        self addOpt(level._Camos[e], ::GiveCamo, (e + 1));
    
        
    self addMenu("Teleportation", "Teleportation", 2);
    self addOpt("Cinematic Animation", ::CinematicTele);
    self addOpt("Random Spawn Point", ::RandomSpawnPoints);
    self addOpt("Teleport To Crosshair", ::TeleTpCros);
    self addOpt("Send To Space", ::TeleTSpace, self);
    self addOpt("Save Current Position", ::SaveLocation, 0);
    self addOpt("Load Saved Position", ::SaveLocation, 1);
    self addOpt("Save Spawn Location", ::SaveSpawn, 0);
    self addOpt("Load Saved Spawn Location", ::SaveSpawn, 1);
    self addOpt("Save & Load Binds", ::SaveLoadBind);
    
            
        
    self addMenu("Aiming", "Aiming", 3);
    self addOpt("Enable Aimbot", ::Aimbot);
    self addOpt("Auto-Shoot", ::AutoShoot);
    self addOpt("Snap Aimbot Type", ::AimbotAngles, 0);
    self addOpt("Silent Aimbot Type", ::AimbotAngles, 1);
    self addOpt("Tracking Aimbot Type", ::AimbotAngles, 2);
    self addOpt("Visible Check", ::VisibilityCheck);
    self addOpt("ADS Check", ::AdsCheck);
    self addOpt("Menu Open Check", ::AimbotMenuOpen);
        
    self addMenu("Bot Menu", "Bot Menu", 3);
    self addOpt("Spawn x1 Bots", ::TestClients, 1);
    self addOpt("Spawn x3 Bots", ::TestClients, 3);
    self addOpt("Spawn x5 Bots", ::TestClients, 5);
    self addOpt("Teleport Bots To Crosshair", ::BotHandler, 3);
    self addOpt("Teleport Bots To Me", ::BotHandler, 1);
    self addOpt("Kill Bots", ::BotHandler, 2);
    self addOpt("Kick All Bots", ::BotHandler, 4);
    self addOpt("Freeze All Bots", ::BotHandler, 6);
    
        
    self addMenu("Server Setting", "Server Setting", 4);
    self addOpt("Super Jump", ::SuperJump);
    self addOpt("Super Speed", ::SuperSpeed);
    self addOpt("Anti-Quit", ::AntiQuit);
    self addOpt("Anti-Join", ::AntiJoin);
    self addOpt("No Fall Damage", ::NoFallDam);
    self addOpt("Low Gravity", ::Gravity);
    self addOpt("Normal Timescale", ::Timescale, 1, 0);
    self addOpt("Fast Timescale", ::Timescale, 4, 1);
    self addOpt("Slow Timescale", ::Timescale, .5, 2);
    self addOpt("Physics Gravity", ::PhysicsGravity);
    self addOpt("Fast Restart", ::RestartMap);
    self addOpt("End Game", ::EndGame);
   
    self addMenu("All Players", "All Players", 4);
    self addOpt("Kick All Players", ::KickAllPlayers);
    for(e=0;e<level.Status.size-1;e++)
        self addOpt("Give All " + level.status[e] + " Access", ::AllPlayersAccess, e);
    self addOpt("All Players Unlimited Ammo & Equipment", ::SustainAmmo);
    self addOpt("All Players Unlimited Sprint", ::PlayersUnlimitedSprint);
    self addOpt("All Players Invulnerable", ::AllInvulnerability);
    self addOpt("All Players Invisible", ::AllInvisible);
    self addOpt("All Players Third Person", ::AllThirdPerson);
    self addOpt("All Max Rank & Prestige", ::AllMaxRank);
    self addOpt("All Challenges", ::AllPlayerChallenges);
    self addOpt("Unlock All Achievements", ::AllPlayerAchievements);
     
    self clientOptions();
}

clientOptions()
{
    self addMenu("clients", "Player Menu", 3);
    foreach( player in level.players )
        self addOpt(player.name, ::newmenu, "client_" + player GetEntityNumber());
            
    foreach(player in level.players)
    {
        self addMenu("client_" + player GetEntityNumber(), "^6Do what to ^7" + player.name + " ^6?");
        self addOpt("Suicide Player", ::KYS, player);
        self addOpt("Kick Player", ::ClientOpts, player, 0);
        for(e=0;e<level.status.size-1;e++)
            self addOpt("Give " + level.status[e] + " ^7Access", ::initializeSetup, e, player);
        self addOpt("Give Invulnerability", ::Godmode, player);
        self addOpt("Freeze Player", ::ClientOpts, player, 1);
        self addOpt("Teleport Me to Player", ::ClientOpts, player, 4);
        self addOpt("Teleport Player to Me", ::ClientOpts, player, 2);
        self addOpt("Send Player To Space", ::TeleTSpace, player);
        self addOpt("Max Rank & Prestige", ::MaxRank, player);
        self addOpt("All Challenges", ::grab_stats_from_table, player);
        self addOpt("Complete All Maps", ::UnlockMaps, player);
         self addOpt("10x Unlock Tokens", ::UnlockTokensCP, player);
        self addOpt("All Weapon Unlocks", ::MaxWeaponRanks, player);
        self addOpt("All Collectibles", ::FindAllCollectible, player);
        self addOpt("All Decorations", ::GetAllCPDecorations, player);
        self addOpt("Legit Stats", ::CustomStats, player);
        self addOpt("Unlock All Achievements", ::UnlockAchievements, player);
        
    }
}

// FILE MERGE: [ functions.gsc ]


MaxRank(player)
{ 
    player endon("disconnect");
    


   
        player SetDStat( "playerstatslist", "rankxp", "statValue", 581651 );
        player SetDStat( "playerstatslist", "rank", "statValue", 19 );

    
    self iPrintLn("Max Rank & Prestige ^2Set");
}



getIndexFromName( string, array )
{
    foreach(index, name in array)
    {
        if( name == string )
            return index;
    }
    return undefined;
}

isWeapon_category( weapon )
{
    return isSubStr( weapon, "weapon_" ) ? weapon : "  ";
}

UnlockAchievements(player)
{
    if(isDefined(player.AllAchievements))
        return;

    player endon("disconnect");
    player.AllAchievements = true;
    self iPrintLn("Unlocking All Achievements");
    foreach(Achivement in level._Achievements)
    {
        wait .1;
    }
    self iPrintLn("All Achievements: ^2Unlocked");
}


CustomStats(player)
{
        
    player endon("disconnect");
    player SetDStat("PlayerStatsList", "time_played_total", "StatValue", randomIntRange(172800, 691200));
    player SetDStat("PlayerStatsList", "headshots", "StatValue", 56245);
    player SetDStat("PlayerStatsList", "melee_kills", "StatValue", randomIntRange(2000, 5000));
    player SetDStat("PlayerStatsList", "grenade_kills", "StatValue", randomIntRange(2000, 5000));
    wait .5;
    player SetDStat("PlayerStatsList", "total_shots", "StatValue", randomIntRange(7000, 9000));
    player SetDStat("PlayerStatsList", "hits", "StatValue", randomIntRange(2000, 5000));
    player SetDStat("PlayerStatsList", "misses", "StatValue", randomIntRange(2000, 5000));
    player SetDStat("PlayerStatsList", "deaths", "StatValue", randomIntRange(10000, 14000));
    wait .5;
    player SetDStat("PlayerStatsList", "kills", "StatValue", randomIntRange(13000, 17000));
    player SetDStat("playerstatslist", "losses", "statValue", randomIntRange(400, 670));
    player SetDStat("PlayerStatsList", "score", "StatValue", randomIntRange(7000000, 15000000));
    player SetDStat("PlayerStatsList", "wins", "StatValue", randomIntRange(500, 1200));
    
    self iPrintLn("Legit Stats ^2Done");
    uploadStats(player);
}


KypricLoop(Val, player)
{

    player endon("disconnect");
    if(!isDefined(player.KypricNum))
        player.KypricNum = 0;
    player.LoopCrypto = !bool(self.LoopCrypto);
    player iPrintLn("Currency Loop " + (!player.LoopCrypto ? "^1OFF" : "^2ON") );
    while(player.LoopCrypto)
    {
        player GiveLoot(player, Val, 35);
        player.KypricNum += 35;
        wait 1;
    }
}

GiveLoot(player, IsVials = false, amount)
{
    player endon("disconnect");
    
    IsVials = int(IsVials);
    IsVials = isDefined(IsVials) && IsVials;
    
    amount = int(amount);
    if(!isdefined(amount)) amount = 1;
    if(!isVials) amount *= 100;

    player ReportLootReward((isVials * 2) + 1, amount);
    uploadstats(player);
    wait .1;
}


RestartMap()
{
    map_restart(0);
}

EndGame()
{
    KillServer();
}

SuperJump()
{
    level.SuperJump = !bool(level.SuperJump);
    self iPrintLn("Super Jump " + (level.SuperJump ? "^2ON" : "^1OFF") );

    if(level.SuperJump)
        foreach(player in level.players)
            player thread AllSuperJump();
}

NoFallDam()
{
    self iPrintLn("No Fall Damage " + (GetDvarInt("bg_fallDamageMinHeight") == 9999 ? "^1OFF" : "^2ON") );
    SetDvar("bg_fallDamageMinHeight", (GetDvarInt("bg_fallDamageMinHeight") != 9999 ? 9999 : 256));
    SetDvar("bg_fallDamageMaxHeight", (GetDvarInt("bg_fallDamageMaxHeight") != 9999 ? 9999 : 512));
}

AllSuperJump()
{
    self endon("disconnect");
    while(level.SuperJump)
    {
        if(self JumpButtonPressed())
        {
            for(i=0;i<5;i++)
                self SetVelocity(self GetVelocity() + (0, 0, 140));

            while(!self IsOnGround())
                wait .05;
        }
        wait .05; 
    }
}

SuperSpeed()
{
    if(!isDefined(level.SaveGSpeed))
        level.SaveGSpeed =  GetDvarString("g_speed");

    self iPrintLn("Super Speed " + (GetDvarString("g_speed") == "500" ? "^1OFF" : "^2ON") );
    SetDvar("g_speed", (GetDvarString("g_speed") != "500" ? "500" : level.SaveGSpeed));
}

Godmode(player)
{
    if(bool(player.DemiGodmode))
        player DemiGodmode();

    player.godmode = !bool(player.godmode);
    self iPrintLn("Invulnerability " + (!player.godmode ? "^1OFF" : "^2ON") );
    player endon("disconnect");
    level endon("game_ended");
    while(player.godmode)
    {
        player EnableInvulnerability();
        wait 1;
    }

    player DisableInvulnerability();
}

DemiGodmode()
{
    if(bool(self.godmode))
        self Godmode(self);

    self.DemiGodmode = !bool(self.DemiGodmode);
    self iPrintLn("Demi-Godmode " + (!self.DemiGodmode ? "^1OFF" : "^2ON") );
}

NoClip()
{
    self endon("disconnect");
    level endon("game_ended");
    self.noclipBind = !bool(self.noclipBind);
    if(self.noclipBind)
    {
        self iPrintLn("NoClip Bind To ^2[{+frag}]");
        while(self.noclipBind)
        {
            if(bool(self.menu["isOpen"]) && self fragButtonPressed())
            {
                self iPrintLn("^1Error ^7Close The Menu To Use NoClip");
                while(self fragButtonPressed())
                    wait .05;
            }
            
            if(self fragButtonPressed() && IsAlive(self) && !bool(self.menu["isOpen"]))
            {
                self.noclipExt = true;
                self disableWeapons();
                self disableOffHandWeapons();
                clip = spawnSM(self.origin);
                self playerLinkTo(clip);
                self Hide();
                while(self.noclipBind)
                {
                    vec = anglesToForward(self getPlayerAngles());
                    end = (vec[0] * 60, vec[1] * 60, vec[2] * 60);
                    if(self attackButtonPressed())
                        clip.origin = clip.origin + end;
                    if(self adsButtonPressed())
                        clip.origin = clip.origin - end;
                    if(!IsAlive(self) || !self.noclipBind || self MeleeButtonPressed())
                        break;
                        
                    wait .05;
                }
                clip delete();
                self enableWeapons();
                self enableOffHandWeapons();
                self.noclipExt = undefined;
            }
            wait .05;
        }
    }
    else
        self iPrintLn("NoClip ^1OFF");
}

spawnSM(origin, model, angles, time)
{
    if(IsDefined(time))
        wait time;
    ent = spawn("script_model", origin);
    if(IsDefined(model))
        ent setModel(model);
    if(IsDefined(angles))
        ent.angles = angles;

    return ent;
}

getCursorPos(Dist = 99999)
{
    return bulletTrace(self getEye(), self getEye() + vectorScale(anglesToforward(self getPlayerAngles()), Dist), false, self)["position"];
}

NoWeaponSpread()
{
    self.NoWeaponSpread = !bool(self.NoWeaponSpread);
    self iPrintLn("Reduced Spread " + (!self.NoWeaponSpread ? "^1OFF" : "^2ON") );
    if(self.NoWeaponSpread)
        self SetSpreadOverride(1);
    else
        self ResetSpreadOverride();
}
    
PSpeed()
{
    self endon("disconnect");
    level endon("game_ended");
    self notify("StopPSpeed");
    
    self.PSpeed = !bool(self.PSpeed);
    self iPrintLn("Movement Speed x2 " + (!self.PSpeed ? "^1OFF" : "^2ON") );
    self SetMoveSpeedScale(self.PSpeed ? 2.5 : 1);
    
    self endon("StopPSpeed");
    while(self.PSpeed)
    {
        if(IsAlive(self))
            self SetMoveSpeedScale(2);

        wait .3;
    }
}

give_Weapon(weapon)
{
   
    self TakeWeapon(self GetCurrentWeapon());
    self GiveWeapon(weapon);
    self SwitchToWeaponImmediate(weapon);
    self GiveMaxAmmo(weapon);
    

}


KYS(player)
{
    if(bool(player.godmode))
        self Godmode(self);
    
    if(player hasMenu() && bool(self.menu["isOpen"]))
        player menuClose();
        
    player DoDamage(player.health + 1, player.origin);
}

SetCustomStats(stat, value)
{
    self AddDStat("PlayerStatsList", stat, "StatValue", value);
    wait .2;
    self iPrintLn("Added " + value + " To ^2" + stat);
    uploadStats(self);
}

resetStats()
{
    self SetDStat("PlayerStatsList", "time_played_total", "StatValue", 0);
    self SetDStat("PlayerStatsList", "headshots", "StatValue", 0);
    self SetDStat("PlayerStatsList", "melee_kills", "StatValue", 0);
    self SetDStat("PlayerStatsList", "grenade_kills", "StatValue", 0);
    wait .2;
    uploadStats(self);
    self SetDStat("PlayerStatsList", "total_shots", "StatValue", 0);
    self SetDStat("PlayerStatsList", "hits", "StatValue", 0);
    self SetDStat("PlayerStatsList", "misses", "StatValue", 0);
    self SetDStat("PlayerStatsList", "deaths", "StatValue", 0);
    wait .2;
    uploadStats(self);
    self SetDStat("PlayerStatsList", "kills", "StatValue", 0);
    self SetDStat("playerstatslist", "losses", "statValue", 0);
    self SetDStat("PlayerStatsList", "wins", "StatValue", 0);
    self SetDStat("PlayerStatsList", "score", "StatValue", 0);
    self iPrintLn("Legit Stats ^2Done");
    uploadStats(self);
}

EditClanTag()
{
    self SetDStat("clanTagStats", "clanName", "^B^");
    self iPrintLn("Clan Tag ^2Set");
}

Multijump(currentNum = 0)
{
    self endon("disconnect");
    level endon("game_ended");
    self notify("SMulti");
    self.Multijump = !bool(self.Multijump);
    self iPrintLn("Multi Jump " + (!self.Multijump ? "^1OFF" : "^2ON") );
    self endon("SMulti");
    
    if(isDefined(self.Multijump))
        self setPerk("specialty_fallheight");
    else
        self unSetPerk("specialty_fallheight");
        
    while(IsDefined(self.Multijump))
    {
        if(self JumpButtonPressed() && currentNum < 15)
        {
            self setVelocity(self getVelocity() + (0, 0, 250));
            currentNum++;
        }
        if(currentNum == 15 && self isOnGround())
            currentNum = 0;

        wait .1;
    }
}

Invisible(player)
{
    player endon("disconnect");
    level endon("game_ended");
    player.CantSeeMe = !bool(player.CantSeeMe);
    player iPrintLn("Invisible " + (!player.CantSeeMe ? "^1OFF" : "^2ON") );
    if(player.CantSeeMe)
    {
        player endon("stopInvs");
        while(player.CantSeeMe)
        {
            player Hide();
            player waittill("spawned_player");
        }
    }
    else
    {
        player notify("stopInvs");
        player Show();
    }
}

ThirdPerson(player)
{
    player endon("disconnect");
    player.ThirdPerson = !bool(player.ThirdPerson);
    player iPrintLn("Third Person " + (!player.ThirdPerson ? "^1OFF" : "^2ON") );
    if(player.ThirdPerson)
    {
        player endon("StopThPerson");
        while(player.ThirdPerson)
        {
            player SetClientThirdPerson(1);
            player waittill("spawned_player");
        }
    }
    else
    {
        player SetClientThirdPerson(0);
        player notify("StopThPerson");
    }
}

CustPHDPerk()
{
    self.PHDPerk = !bool(self.PHDPerk);
    self iPrintLn("No Explosive Damage " + (!self.PHDPerk ? "^1OFF" : "^2ON") );
}

specNade()
{
    self endon("disconnect");
    level endon("game_ended");
    self endon("StopspecNade");
    self.specNade = !bool(self.specNade);
    self iPrintLn("Spectate Nade " + (!self.specNade ? "^1OFF" : "^2ON") );
    if(self.specNade)
    {
        while(self.specNade)
        {
            self waittill("grenade_fire", grenade, weapname);
            self.SpecGod = true;
            SavedAngles    = self.angles;
            self disableWeapons();
            self disableOffHandWeapons();
            self Hide();
            self playerLinkTo(grenade);
            self setPlayerAngles(VectorToAngles(grenade.origin - self.origin));
            self thread NadeAngles(grenade);
            self waittill("explode");
            self unlink();
            if(!bool(self.CantSeeMe))
                self Show();
            self setPlayerAngles(SavedAngles);
            self enableWeapons();
            self enableOffHandWeapons();
            self.SpecGod = undefined;
        }
    }
    else
        self notify("StopspecNade");
}

NadeAngles(grenade)
{
    self endon("disconnect");
    level endon("game_ended");
    self endon("StopspecNade");
    while(self.specNade)
    { 
        self setPlayerAngles(VectorToAngles(grenade.origin - self.origin));
        wait .05;
    }
}

CloneMe(Val)
{
    self iPrintLn("Clone ^2Spawned");
    clone = self ClonePlayer(Val ? 1 : 99999, self getCurrentWeapon(), self);
    
    if(Val)
        clone startRagDoll(1);
        
    clone thread DeleteAfter30();
}

DeleteAfter30()
{
    self endon("death");
    self endon("deleted");
    wait 30;
    self delete();
}

ClusterGrenades()
{
    self endon("disconnect");
    level endon("game_ended");
    self notify("Stop_ClusterGrenades");
    self.ClusterGrenades = !bool(self.ClusterGrenades);
    self iPrintLn("Cluster Grenades " + (!self.ClusterGrenades ? "^1OFF" : "^2ON") );
    self endon("Stop_ClusterGrenades");
    while(self.ClusterGrenades)
    {
        self waittill("grenade_fire", grenade, weapon);
        
        if(bool(self.ClusterGrenadesActive))
            continue;
            
        self thread GrenadeSplit(grenade, weapon);
    }
}

grenadesplit(grenade, weapon)
{
    self endon("disconnect");
    level endon("game_ended");
    lastspot = (0,0,0);
    while(isdefined(grenade))
    {
        lastspot = (grenade GetOrigin());
        wait .025;
    }
    
    self.ClusterGrenadesActive = true;
    
    Array = [(250,0,250), (250,250,250), (250,-250,250), (-250,0,250), (-250,250,250), (-250,-250,250), (0,0,250), (0,250,250), (0,-250,250)];
    for(i=0;i<Array.size;i++)
        self MagicGrenadeType(weapon, lastspot, Array[i], 2);
        
    wait .025;
    self.ClusterGrenadesActive = undefined;
}

UnlmEquipment()
{
    self endon("disconnect");
    level endon("game_ended");
    self.UnlmEquipment = !bool(self.UnlmEquipment);
    self iPrintLn("Unlimited Equipment " + (!self.UnlmEquipment ? "^1OFF" : "^2ON") );
    if(self.UnlmEquipment)
    {
        self endon("StopUlimEq");
        while(IsDefined(self.UnlmEquipment))
        {
            self giveMaxAmmo(self getCurrentOffHand());
            wait .05;
        }
    }
    else
        self notify("StopUlimEq");
}
    
UnlmAmmo()
{
    self endon("disconnect");
    level endon("game_ended");
    self notify("stopUnlmAmmo");
    self.UnlmAmmo = !bool(self.UnlmAmmo);
    if(bool(self.UnlmAmmoReload))
    {   
        self.UnlmAmmoReload = undefined;
        self notify("stopUnlmAmmoReload");
    }
    self endon("stopUnlmAmmo");
    self iPrintLn("Unlimited Ammo " + (!self.UnlmAmmo ? "^1OFF" : "^2ON") );
    while(IsDefined(self.UnlmAmmo))
    {
        Weapon = self getCurrentWeapon();
        self setWeaponAmmoClip(Weapon, Weapon.clipsize);
        self giveMaxAmmo(Weapon);
        self util::waittill_any("weapon_fired", "weapon_change");
    }
}

UnlmAmmoReload()
{
    self endon("disconnect");
    level endon("game_ended");
    self notify("stopUnlmAmmoReload");
    self.UnlmAmmoReload = !bool(self.UnlmAmmoReload);
    if(bool(self.UnlmAmmo))
    {
        self.UnlmAmmo = undefined;
        self notify("stopUnlmAmmo");
    }
    self endon("stopUnlmAmmoReload");
    self iPrintLn("Unlimited Ammo - No Reload " + (!self.UnlmAmmoReload ? "^1OFF" : "^2ON") );
    while(IsDefined(self.UnlmAmmo))
    {
        self endon("stopUnlmAmmo");
        while(IsDefined(self.UnlmAmmo))
        {
            self giveMaxAmmo(self getCurrentWeapon());
            self util::waittill_any("reload", "weapon_change");
        }
    }
}

WepOpt(i)
{
    Weap = self GetCurrentWeapon();
    switch(i)
    {
        case 0:
            self iPrintLn("Taken ^1Weapon");
            self TakeWeapon(Weap);
            break;

        case 1:
            self iPrintLn("All Weapons ^1Taken");
            self TakeAllWeapons();
            break;

        case 2:
            self iPrintLn("Dropped ^2Weapon");
            self DropItem(Weap);
            break;

        case 3:
            self giveMaxAmmo(Weap);
            self giveMaxAmmo(self getCurrentOffHand());
            self iPrintLn("Max Ammo ^2Given");
            break;
    }
}

CustomCinematic(End, bool, angle)
{
    self endon("disconnect");
    level endon("game_ended");
    player = self;
    player DisableWeapons();
    player.CamRunning = true;
    if(!bool(player.CantSeeMe))
        player Hide();
    Cam = spawnSM(player.origin, "tag_origin", player.angles);
    player PlayerLinkToAbsolute(Cam);
    Cam moveto(player.origin + vectorScale(anglestoforward(player.angles + (0, -180, 0)), 4000) + (0, 0, 5000), 3, 1.5, 1.5);
    Cam rotateto(Cam.angles + (55, 0, 0), 3, 1.5, 1.5);
    wait 3;
    Cam moveto(End, 3, 1.5, 1.5);
    wait .5;
    if(IsDefined(bool))
        Cam rotateto(angle.angles, 2.5, 1.25, 1.25);
    else
        Cam rotateto((Cam.angles[0]-55, Cam.angles[1], 0), 3, 1.5, 1.5);
    wait 2.5;
    self unlink();
    Cam delete();
    if(!bool(player.CantSeeMe))
        player Show();
    player EnableWeapons();
    player.CamRunning = undefined;
}

RandomSpawnPoints()
{   
    RandSpawnP = level.SpawnPoints[RandomInt(level.SpawnPoints.size)];
    if(IsDefined(self.CinematicTele) && self.CinematicTele)
        self CustomCinematic(RandSpawnP.origin, 1, RandSpawnP);
    else
    {
        self SetOrigin(RandSpawnP.origin);
        self SetPlayerAngles(RandSpawnP.angles);
    }
}
    
SaveLocation(Val)
{
    if(Val == 0)
    {
        self.SaveLocation      = self.origin;
        self.SaveLocationAngle = self.angles;
        if(!IsDefined(self.SaveLocTog))
            self.SaveLocTog = true;
            
        self iPrintLn("Current Position: ^2Saved");
    }
    else if(Val == 1)
    {
        if(!IsDefined(self.SaveLocTog))
            return self iPrintLnBold("^1Error: ^7No Location Saved");
            
        self SetPlayerAngles(self.SaveLocationAngle);
        self SetOrigin(self.SaveLocation);
        self iPrintLn("Saved Position: ^2Loaded");
    }
    else
    {
        self.SaveLocTog        = undefined;
        self.SaveLocation      = undefined;
        self.SaveLocationAngle = undefined;
    }
}

SaveSpawn(Val)
{
    self endon("disconnect");
    level endon("game_ended");
    if(Val == 0)
    {
        self notify("StopSpawnSave");
        self.SaveSpawn      = self.origin;
        self.SaveSpawnAngle = self.angles;
        if(!IsDefined(self.SaveSpawnTog))
            self.SaveSpawnTog = true;
        self endon("StopSpawnSave");
        self iPrintLn("Spawn Position: ^2Saved");
        while(IsDefined(self.SaveSpawnTog))
        {
            self waittill("spawned_player");
            self SetPlayerAngles(self.SaveSpawnAngle);
            self SetOrigin(self.SaveSpawn);
        }
    }
    else if(Val == 1)
    {
        if(!IsDefined(self.SaveSpawnTog))
            return self iPrintLnBold("^1Error: ^7No Location Saved");
            
        self iPrintLn("Spawn Position: ^2Loaded");
        self SetPlayerAngles(self.SaveSpawnAngle);
        self SetOrigin(self.SaveSpawn);
    }
    else
    {
        self notify("StopSpawnSave");
        self.SaveSpawnTog   = undefined;
        self.SaveSpawn      = undefined;
        self.SaveSpawnAngle = undefined;
    }
}

TeleTpCros()
{
    self SetOrigin(self getCursorPos(1000));
}

TeleTSpace(player)
{
    x = randomIntRange(-75, 75);
    y = randomIntRange(-75, 75);
    z = 45;
    
    location = (0 + x, 0 + y, 500000 + z);
    player setOrigin(location);
    if(player != self)
        self IPrintLnBold(player.name + " Is Now In ^2Space");
    else
        player iPrintLn("You Are Now In ^2Space");
        
}

SaveLoadBind()
{
    self.SaveLoadBind = !bool(self.SaveLoadBind);
    if(self.SaveLoadBind)
    {
        self endon("disconnect");
        level endon("game_ended");
        self iPrintLn("Press [{+actionslot 3}] To ^2Save^7 - Press [{+actionslot 4}] To ^2Load");
        while(self.SaveLoadBind)
        {
            if(self ActionSlotThreeButtonPressed() || self ActionSlotFourButtonPressed())
            {
                if(!Bool(self.menu["isOpen"]))
                {
                    if(self ActionSlotThreeButtonPressed())
                    {
                        SaveLoadBindOrigin = self.origin;
                        SaveLoadBindAngle  = self.angles;
                        self iPrintLn("Current Location: ^2Saved");
                        wait .1;
                    }
                    if(self ActionSlotFourButtonPressed())
                    {
                        self SetOrigin(SaveLoadBindOrigin);
                        self SetPlayerAngles(SaveLoadBindAngle);
                        self iPrintLn("Saved Location: ^2Loaded");
                        wait .1;
                    }
                }
            }
            wait .05;
        }
    }
}

CinematicTele()
{
    self.CinematicTele = !bool(self.CinematicTele);
    self iPrintLn("Cinematic Animation " + (!self.CinematicTele ? "^1OFF" : "^2ON") );
}

KillTriggers(i = 0)
{
    hurtTriggers = GetEntArray("trigger_out_of_bounds", "classname");
    level.KillTriggers = !bool(level.KillTriggers);
    foreach(trigger in hurtTriggers)
    {
        if(level.KillTriggers)
        {
            level.SaveKillTriggersOrigin[i] = trigger.origin;
            trigger.origin = (0, 0, 99999);
        }
        else
            trigger.origin = level.SaveKillTriggersOrigin[i];
            
        i++;
    }
}

Aimbot() 
{
    self endon("disconnect");
    level endon("game_ended");
    level endon("game_ended");
    self.Aimbot = !bool(self.Aimbot);
    self iPrintLn("Aimbot " + (!self.Aimbot ? "^1OFF" : "^2ON") );
    if(!isDefined(self.CheckAimbot))
        self CheckAimbot();
        
   
    while(self.Aimbot)
    {
        wait .025;
        aimAt = undefined;
        foreach(Zombie in GetAIArray())
        {
            if(!isAlive(Zombie) || Zombie.team == self.team || (self.menu["isOpen"] && Bool(self.AimbotMenuOpen)))
                continue;

            if(bool(self.iVisible) && !bulletTracePassed(self getEye(), Zombie.origin, false, undefined) || bool(self.iAim) && !self PlayerAds())
                continue;

            if(isDefined(aimAt))
            {
                if(closer(self getEye(), Zombie getTagOrigin("j_mainroot"), aimAt getTagOrigin("j_mainroot")))
                    aimAt = Zombie;
            }
            else
                aimAt = Zombie;
        }

        if(self.iAngles == 2 )
            self setPlayerAngles(VectorToAngles(aimAt getTagOrigin(self.iAimFor) - self getTagOrigin("j_head")));

        if(bool(self.AutoShoot) || self AttackButtonPressed() && IsDefined(aimAt) && !self IsReloading() && !self IsMantling())
        {
            if(self.iAngles == 0)
                self setPlayerAngles(VectorToAngles(aimAt getTagOrigin(self.iAimFor) - self getTagOrigin("j_head")));

            if(bool(self.AutoShoot) || self.iAngles == 1 || !bool(self.iVisible))
                aimAt DoDamage(self.iDamagePlayer, self.origin, self, undefined, "none", self.Killfeed, 0, self getCurrentWeapon());
        }
    }
    
       
}

CheckAimbot()
{
    self.CheckAimbot   = true;
    self.iDamagePlayer = 200;
    self.iAimFor       = "j_head";
    self.Killfeed      = "MOD_HEAD_SHOT";
    self.iDist         = 10000;        
    self.iAngles       = 0;
    self.iVisible      = false;
}

AimbotMenuOpen()
{
    self.AimbotMenuOpen = !bool(self.AimbotMenuOpen);
    self iPrintLn("Menu Open Check " + (!self.AimbotMenuOpen ? "^1OFF" : "^2ON") );
}

AimbotAngles(Val)
{
    Opt = array("Snap", "Silent", "Tracking");
    self.iAngles = Val;
    self iPrintLn("Aimbot Type Set: ^2" + Opt[Val] );
}

AutoShoot()
{
    self.AutoShoot = !bool(self.AutoShoot);
    self iPrintLn("Auto Shoot " + (!self.AutoShoot ? "^1OFF" : "^2ON") );
} 

AimbotDamage(Val)
{
    self.iDamagePlayer = Val;
}

AimbotTarget(Val)
{
    self.Killfeed = (Val > 0 ? "MOD_RIFLE_BULLET" : "MOD_HEAD_SHOT");
    Tag             = strTok("j_head;j_mainroot;j_clavicle_ri;back_mid;j_hip_ri;j_knee_ri;j_knee_le",";");
    self.iAimFor  = Tag[Val];
}

AimbotDistance(Val)
{
    self.iDist = Val;
}

VisibilityCheck() 
{
    self.iVisible = !bool(self.iVisible);
    self iPrintLn("Visibility Check " + (!self.VisibilityCheck ? "^1OFF" : "^2ON") );
}

AdsCheck()
{
    self.iAim = !bool(self.iAim);
    self iPrintLn("Ads Check " + (!self.iAim ? "^1OFF" : "^2ON") );
}

TestClients(BotNum)
{
    for(i=0;i<BotNum;i++)
    {    
        bot = addtestclient();
        wait .1;
        bot.pers["isBot"] = 1;
        bot.equipment_enabled = 1;
    }
}

ForceBotSpawn()
{
    while(self.sessionstate != "spectator")
        wait .2;

    self [[level.spawnPlayer]]();
}

isBot()
{
    return (isDefined(self.pers["isBot"]) && self.pers["isBot"] ? true : false);
}

BotHandler(i)
{
    switch(i)
    {
        case 1:
            self IPrintLnBold("All Bots ^2Teleported");
            foreach(player in level.players)
                if(player isBot())
                    player SetOrigin(self.origin);
            break;

        case 2:
            self IPrintLnBold("All Bots ^1Killed");
            foreach(player in level.players)
                if(player isBot())
                    player Suicide();
            break;

        case 3:
            self IPrintLnBold("All Bots ^2Teleported");
            foreach(player in level.players)
                if(player isBot())
                    player SetOrigin(self getCursorPos());
            break;

        case 4:
            foreach(player in level.players)
                if(player isBot())
                    kick(player getEntityNumber());
            break;

        case 5:
            self IPrintLnBold("All Bots ^2Spawned");
            foreach(player in level.players)
                if(player isBot())
                    player [[level.spawnPlayer]]();
            break;
            
        case 6:
            level.BotsFrozen = !bool(level.BotsFrozen);
            foreach(player in level.players)
                if(player isBot())
                    player FreezeControls(level.BotsFrozen);
            break;
    }
}

ClientOpts(player, func)
{  
    player endon("disconnect");
    level endon("game_ended");
    switch(func)
    {
        case 0:
            if(player == self)
                return;
                
            Kick(player GetEntityNumber());
            break;
            
        case 1:
            player.IsFrozen = !bool(player.IsFrozen);
            if(player.IsFrozen)
            {
                self iPrintLn(player.name + " ^1Frozen");
                player endon("StopFrezee");
                while(player.IsFrozen)
                {
                    player Freezecontrols(true);
                    player waittill("spawned_player");
                }
            }
            else
            {
                self iPrintLn(player.name + " ^2UnFrozen");
                player Freezecontrols(false);
                player notify("StopFrezee");
            }
            break;
            
         case 2:
            player SetOrigin(self.origin + (-10, 0, 0));
            self iPrintLn(player.name + " Teleported To ^2Me");
            break;
            
        case 3:
            player SetRank(0, 0);
            self iPrintLn(player.name + " Has Been ^1Faked Deranked");
            break;

        case 4:
            self SetOrigin(player.origin + (-10, 0, 0));
            self iPrintLn("Teleported To ^2" + player.name);
            break;
    }
}
    
Timescale(Val, StringIndex)
{
    Speed = ["Normal", "Fast", "Slow"];
    setDvar("timescale", Val);
    iPrintLn("Time Scale Set: ^2" + Speed[StringIndex]);
}

PhysicsGravity()
{
    DvarName = ["phys_gravity_ragdoll", "phys_gravity"];
    for(e=0;e<2;e++)
        setDvar(DvarName[e], getDvarString("phys_gravity") != "-10" ? "-10" : "-800");
        
    self iPrintLn("Low Physics Gravity " + (getDvarString("phys_gravity") != "-10" ? "^1OFF" : "^2ON") );
}

SustainAmmo()
{
    SetDvar("player_sustainAmmo", !GetDvarInt("player_sustainAmmo"));
    self iPrintLn("Unlimited Ammo & Equipment " + (!GetDvarInt("player_sustainAmmo") ? "^1OFF" : "^2ON") );
}

PlayersUnlimitedSprint()
{
    level.PlayersUnlimitedSprint = !bool(level.PlayersUnlimitedSprint);
    SetDvar("player_sprintUnlimited", level.PlayersUnlimitedSprint);
    self iPrintLn("Unlimited Sprint " + (!level.PlayersUnlimitedSprint ? "^1OFF" : "^2ON") );
}

Gravity()
{
    SetDvar("bg_gravity", GetDvarInt("bg_gravity") == level.saveGravity ?  250 : level.saveGravity);
    self iPrintLn("Low Gravity " + (GetDvarInt("bg_gravity") == level.saveGravity ? "^1OFF" : "^2ON") );
}

AntiQuit()
{
    level.AntiQuit = !bool(level.AntiQuit);
    SetMatchFlag("disableIngameMenu", level.AntiQuit);
    self iPrintLn("AntiQuit " + (!level.AntiQuit ? "^1OFF" : "^2ON") );
}

AntiJoin()
{
    level.AntiJoin = !bool(level.AntiJoin);
    self iPrintLn("AntiJoin " + (!level.AntiJoin ? "^1OFF" : "^2ON") );
}


CompleteDailyChallanges()
{
    self endon("disconnect");
    self iPrintLn("Completing Current Daily Challanges");
    for(e=768;e<808;e++)
    {
        statname  = tableLookup("gamedata/stats/zm/statsmilestones4.csv", 0, e, 4);
        statvalue = tableLookup("gamedata/stats/zm/statsmilestones4.csv", 0, e, 2);
        self AddPlayerStat(toUpper(statname), int(statvalue));
        wait .1;
        UploadStats(self);
    }
    self iPrintLn("Current Daily Challanges: ^2Done");
}

noTarget()
{
    self.ignoreme = !bool(self.ignoreme);
    self.ignorme_count = self.ignoreMe * 999;
    self iPrintLn("No Target " + (!self.ignoreme ? "^1OFF" : "^2ON") );
}

SetPerkCheck(perk)
{
    if(self hasPerk(perk))
    {
        self unSetPerk(perk);
        self iPrintLn("Perk: " + perk + " ^1Taken");
    }
    else
    {
        self setPerk(perk);
        self iPrintLn("Perk: " + perk + " ^2Set");
    }
}

FixBrokenStats()
{
    if(self getdstat("playerstatslist", "plevel", "statvalue") < 0) self setDStat("playerstatslist", "plevel", "statvalue", 0);
    if(self getdstat("playerstatslist", "rankxp", "statvalue") < 0) self setDStat("playerstatslist", "rankxp", "statvalue", 0);
    if(self getdstat("playerstatslist", "rank", "statvalue") < 0) self setDStat("playerstatslist", "rank", "statvalue", 0);
    if(self getdstat("playerstatslist", "paragon_rank", "statvalue") < 0) self setDStat("playerstatslist", "paragon_rank", "statvalue", 0);
    if(self getdstat("playerstatslist", "paragon_rankxp", "statvalue") < 0) self setDStat("playerstatslist", "paragon_rankxp", "statvalue", 0);
    uploadStats(self);
    
}


GiveCamo(Camo)
{
    weapon = self GetCurrentWeapon();
    self TakeWeapon(weapon);
    self giveWeapon(weapon, self CalcWeaponOptions(camo, 0, 0));
    self SwitchToWeaponImmediate(weapon);
    iPrintLn("Custom Camo ^2Set");
}

InfiniteHeroPower()
{
    level endon("game_ended");
    level endon("game_end");
    self endon("disconnect");
    level endon("game_ended");

    self.InfiniteHeroPower = !bool(self.InfiniteHeroPower);
    self iPrintLn("Infinite Specialist " + (!self.InfiniteHeroPower ? "^1OFF" : "^2ON") );
    while(self.InfiniteHeroPower)
    {
        if(self GadgetIsActive(0))
            self GadgetPowerSet(0, 99);
        else if(self GadgetPowerGet(0) < 100)
            self GadgetPowerSet(0, 100);
        wait .025;
    }
}


SetPrestige(Prestige)
{
    self SetDStat("playerstatslist", "plevel", "StatValue", Prestige);
    if(self GetDStat("playerstatslist", "plevel", "statValue") < 10 && self GetDStat( "playerstatslist", "paragon_rank", "statValue" ) > 56)
    {
        self SetDStat( "playerstatslist", "paragon_rankxp", "statValue", 0 );
        self SetDStat( "playerstatslist", "paragon_rank", "statValue", 0 );
        self SetDStat( "playerstatslist", "rankxp", "statValue", 1375000 );
        self SetDStat( "playerstatslist", "rank", "statValue", 34 );
    }
    else if(self GetDStat("playerstatslist", "plevel", "statValue") > 10)
    {
        self SetDStat( "playerstatslist", "rankxp", "statValue", 1375000 );
        self SetDStat( "playerstatslist", "rank", "statValue", 34 );
        self SetDStat( "playerstatslist", "paragon_rankxp", "statValue", 52345460 );
        self SetDStat( "playerstatslist", "paragon_rank", "statValue", 964 );
    }
    self iPrintLn("Prestige Set: ^2" + Prestige);
}

ForceHost()
{
    if(getDvarString("party_connectTimeout") != "0")
    {
        self iPrintLn("Force Host ^2ON");
        SetDvar("lobbySearchListenCountries", "0,103,6,5,8,13,16,23,25,32,34,24,37,42,44,50,71,74,76,75,82,84,88,31,90,18,35");
        SetDvar("excellentPing", 3);
        SetDvar("goodPing", 4);
        SetDvar("terriblePing", 5);
        SetDvar("migration_forceHost", 1);
        SetDvar("migration_minclientcount", 12);
        SetDvar("party_connectToOthers", 0);
        SetDvar("party_dedicatedOnly", 0);
        SetDvar("party_dedicatedMergeMinPlayers", 12);
        SetDvar("party_forceMigrateAfterRound", 0);
        SetDvar("party_forceMigrateOnMatchStartRegression", 0);
        SetDvar("party_joinInProgressAllowed", 1);
        SetDvar("allowAllNAT", 1);
        SetDvar("party_keepPartyAliveWhileMatchmaking", 1);
        SetDvar("party_mergingEnabled", 0);
        SetDvar("party_neverJoinRecent", 1);
        SetDvar("party_readyPercentRequired", .25);
        SetDvar("partyMigrate_disabled", 1);
    }
    else
    {
        self iPrintLn("Force Host ^1OFF");
        SetDvar("lobbySearchListenCountries", "");
        SetDvar("excellentPing", 30);
        SetDvar("goodPing", 100);
        SetDvar("terriblePing", 500);
        SetDvar("migration_forceHost", 0);
        SetDvar("migration_minclientcount", 2);
        SetDvar("party_connectToOthers", 1);
        SetDvar("party_dedicatedOnly", 0);
        SetDvar("party_dedicatedMergeMinPlayers", 2);
        SetDvar("party_forceMigrateAfterRound", 0);
        SetDvar("party_forceMigrateOnMatchStartRegression", 0);
        SetDvar("party_joinInProgressAllowed", 1);
        SetDvar("allowAllNAT", 1);
        SetDvar("party_keepPartyAliveWhileMatchmaking", 1);
        SetDvar("party_mergingEnabled", 1);
        SetDvar("party_neverJoinRecent", 0);
        SetDvar("partyMigrate_disabled", 0);
    }
}

AutoDropShot()
{
    self.AutoDropShot = !bool(self.AutoDropShot);
    self iPrintLn("Auto Drop Shot " + (!self.AutoDropShot ? "^1OFF" : "^2ON") );
    if(self.AutoDropShot)
    {
        self endon("StopAutoDropShot");
        while(self.AutoDropShot)
        {
            self waittill("weapon_fired");
            self SetStance("prone");
        }
        
    }
    else
        self notify("StopAutoDropShot");
}

KickAllPlayers()
{
    foreach(player in level.players)
        if(!player IsHost())
            Kick(player GetEntityNumber());
}
        
AllInvulnerability()
{
    level.AllInvulnerability = !bool(level.AllInvulnerability);
    self iPrintLn("All Players Invulnerability " + (!level.AllInvulnerability ? "^1OFF" : "^2ON") );
    foreach(player in level.players)
    {
        if(player.godmode == level.AllInvulnerability || player IsHost())
            continue;
            
        player Godmode(player);
    }
}

AllInvisible()
{
    level.AllInvisible = !bool(level.AllInvisible);
    self iPrintLn("All Players Invisible " + (!level.AllInvisible ? "^1OFF" : "^2ON") );
    foreach(player in level.players)
    {
        if(player.CantSeeMe == level.AllInvisible || player IsHost())
            continue;
            
            player Invisible(player);
    }
}

AllThirdPerson()
{
    level.AllThirdPerson = !bool(level.AllThirdPerson);
    self iPrintLn("All Players Third Person " + (!level.AllThirdPerson ? "^1OFF" : "^2ON") );
    foreach(player in level.players)
    {
        if(player.ThirdPerson == level.AllThirdPerson || player IsHost())
            continue;
            
        player ThirdPerson(player);
    }
}

AllMaxRank()
{
    if(SessionModeIsMultiplayerGame())
        return self iPrintLn("^1Error ^7Account Stats Are Host ONLY!");
        
    self iPrintLn("All Players ^2Max Rank & Prestige");
    foreach(player in level.players)
        self MaxRank(player);
}
    
AllPlayerChallenges()
{
    if(SessionModeIsMultiplayerGame())
        return self iPrintLn("^1Error ^7Account Stats Are Host ONLY!");
        
    foreach(player in level.players)
        if(!player IsHost() || !bool(player.Isunlockingall))
            player grab_stats_from_table(player); 
}
        
AllPlayerAchievements()
{
    foreach(player in level.players)
        if(!player IsHost())
            player UnlockAchievements(player);
}
        
grab_stats_from_table(player)
{
    self iPrintLn("Unlocking All Challenges");
    for(e=512;e<589;e++)
    {
        Stat  = tableLookup("gamedata/stats/cp/statsmilestones3.csv", 0, e, 4);
        Value = tableLookup("gamedata/stats/cp/statsmilestones3.csv", 0, e, 6);
        
        player SetDStat("PlayerStatsList", Stat, "statValue", Value);
        player SetDStat("PlayerStatsList", Stat, "challengevalue", Value);
        wait .1;
    }
    
    UploadStats(player);
    self iPrintLn("Completed All Challenges ^2Done");
}

MaxWeaponRanks(player)
{
    self iPrintLn("Unlocking All Weapon Ranks");  
    for(e=1;e<36;e++)
    {
        weapon = tableLookup("gamedata/stats/cp/cp_statstable.csv", 0, e, 4);
        player addRankXp("kill", GetWeapon(weapon), undefined, undefined, 1, int(600));
        player addWeaponStat(GetWeapon(weapon), "kills", int(600) + randomIntRange(240, 928));
        player addweaponstat(GetWeapon(weapon), "headshots", int(600) + randomIntRange(240, 928));
        player addweaponstat(GetWeapon(weapon), "shots", int(600));
        player addweaponstat(GetWeapon(weapon), "hits", int(600));
        player addweaponstat(GetWeapon(weapon), "used", int(600) + randomIntRange(240, 928));
        player addweaponstat(GetWeapon(weapon), "misses", (int(600) * randomInt(5) / 2));


        player AddDStat("ItemStats", e, "stats", "kills", "statValue", int(600) + randomIntRange(240, 928));
        player AddDStat("ItemStats", e, "stats", "used", "statValue", int(600) + randomIntRange(240, 928));
        wait .05;
    }

    for(e=1;e<60;e++)
    {
        currentWeaponXP = player GetDStat("ItemStats", e, "xp");
        player SetDStat("ItemStats", e, "xp", 1000000 + currentWeaponXP);
        UploadStats(player);
    }
    
    player MaxWeaponRanksOptic();
    UploadStats(player);
    self iPrintLn("All Weapon Ranks ^2Done");
}

MaxWeaponRanksOptic()
{
    for(e=1;e<36;e++)
    {
        weapon     = tableLookup("gamedata/stats/cp/cp_statstable.csv", 0, e, 4);
        attachment = tableLookup("gamedata/stats/cp/cp_statstable.csv", 0, e, 8);
        
        foreach(attach in strTok(attachment, " "))
        {
            self SetDStat("attachments", attach, "stats", "kills", "statValue", 700);
            self SetDStat("attachments", attach, "stats", "kills", "challengeValue", 700);
            for(i = 1; i < 8; i++)
            {
                self SetDStat("attachments", attach, "stats", "challenge" + i, "statValue", 700);
                self SetDStat("attachments", attach, "stats", "challenge" + i, "challengeValue", 700);
            }
        }
    }
}

FindAllCollectible(player)
{
    player.FindAllCollectible = true;
    for(e=0;e<level._Maps.size;e++)
    {
        for(f=0;f<10;f++)
        {
            player SetDStat("PlayerStatsByMap", level._Maps[e], "collectibles", f, 1);
            player SetDStat("PlayerStatsByMap", level._Maps[e] + "_nightmares", "collectibles", f, 1);
            player AddRankXPValue("picked_up_collectible", 500);
        }

        player SetDStat("PlayerStatsByMap", level._Maps[e], "allCollectiblesCollected", 1);
        player notify("give_achievement", "CP_MISSION_COLLECTIBLES");
        wait .05;
    }
    player AddPlayerStat("career_collectibles", 54);
    player playlocalsound("uin_collectible_pickup");
    player SetDStat("PlayerStatsList", "ALL_COLLECTIBLES_COLLECTED", "statValue", 1);
    player GiveDecoration("cp_medal_all_collectibles");
    player notify("give_achievement", "CP_ALL_COLLECTIBLES");
    UploadStats(player);
    self iPrintLn("All Collectibles ^2Found");
}

GetAllCPDecorations(player)
{
    player.GetAllCPDecorations = true;
    a_decorations = player GetDecorations();
    for(i=0;i<a_decorations.size;i++)
        player GiveDecoration(a_decorations[i].name);

    UploadStats(player);
    self iPrintLn("All Decorations ^2Given");
}

UnlockMaps(player, map)
{
    player.score = randomIntRange(370000, 920000);
    player SetDStat("PlayerStatsList", "time_played_total", "StatValue", 2419200);
    player SetDStat("PlayerStatsList", "SCORE", "statValue", randomIntRange(370000, 920000));
    player SetDStat("PlayerStatsList", "headshots", "StatValue", 56245);
    player SetDStat("PlayerStatsList", "kills", "StatValue", 56245);
    player SetDStat("PlayerStatsList", "melee_kills", "StatValue", randomIntRange(2000, 5000));
    player SetDStat("PlayerStatsList", "grenade_kills", "StatValue", randomIntRange(2000, 5000));
    player SetDStat("PlayerStatsList", "total_shots", "StatValue", randomIntRange(7000, 9000));
    player SetDStat("PlayerStatsList", "hits", "StatValue", randomIntRange(2000, 5000));
    player SetDStat("PlayerStatsList", "misses", "StatValue", randomIntRange(2000, 5000));
    player SetDStat("PlayerStatsList", "deaths", "StatValue", randomIntRange(150000, 200000));
    
    if(!isDefined(map))
    {
        foreach(mapname in level._Maps)
        {
            player SetDStat("PlayerStatsByMap", mapname, "hasBeenCompleted", 1);
            
            player SetDStat("PlayerStatsByMap", mapname, "currentStats", "SCORE", randomIntRange(370000, 920000));
            player SetDStat("PlayerStatsByMap", mapname, "highestStats", "SCORE", randomIntRange(370000, 920000));
            for(i=0;i<100;i++)
            {
                player SetDStat("PlayerStatsByMap", mapname, "completedDifficulties", i, 1);
                player SetDStat("PlayerStatsByMap", mapname, "receivedXPForDifficulty", i, 1);
            }
        }
    }
    else
    {
        player SetDStat("PlayerStatsByMap", map, "hasBeenCompleted", 1);
        player SetDStat("PlayerStatsByMap", map, "currentStats", "SCORE", randomIntRange(370000, 920000));
        player SetDStat("PlayerStatsByMap", map, "highestStats", "SCORE", randomIntRange(370000, 920000));
        
        for(i=0;i<100;i++)
        {
            player SetDStat("PlayerStatsByMap", map, "completedDifficulties", i, 1);
            player SetDStat("PlayerStatsByMap", map, "receivedXPForDifficulty", i, 1);
        }
    }
    player AddRankXp("complete_mission_heroic");
    player UnlockNightmareMaps();
    self iPrintLn("Completed All Maps ^2Done");
}

UnlockNightmareMaps(player)
{
    foreach(mapname in level._Maps)
    {
        player SetDStat("PlayerStatsByMap", mapname + "_nightmares", "hasBeenCompleted", 1);
        player SetDStat("PlayerStatsByMap", mapname + "_nightmares", "currentStats", "SCORE", randomIntRange(370000, 920000));
        player SetDStat("PlayerStatsByMap", mapname + "_nightmares", "highestStats", "SCORE", randomIntRange(370000, 920000));
        for(i=0;i<100;i++)
        {
            player SetDStat("PlayerStatsByMap", mapname + "_nightmares", "completedDifficulties", i, 1);
            player SetDStat("PlayerStatsByMap", mapname + "_nightmares", "receivedXPForDifficulty", i, 1);
        }
    }
}

UnlockTokensCP(player)
{
    player GiveUnlockToken(10);
    UploadStats(player);
    self iPrintLn("10x Unlock Tokens ^2Given");
}

// FILE MERGE: [ menuUtils.gsc ]
menuMonitor()
{
    self endon("disconnected");
    self endon("end_menu");
    while( true )
    {
        if(!self.menu["isLocked"])
        {
            if(!bool(self.menu["isOpen"]))
            {
                if( self meleeButtonPressed() && self adsButtonPressed() )
                {
                    self menuOpen();
                    wait .2;
                }               
            }
            else 
            {
                if( self attackButtonPressed() || self adsButtonPressed() )
                {
                    self.menu[ self getCurrentMenu() + "_cursor" ] += self attackButtonPressed();
                    self.menu[ self getCurrentMenu() + "_cursor" ] -= self adsButtonPressed();
                    self scrollingSystem();
                    
                    wait .15;
                }
                
                else if( (self ActionSlotThreeButtonPressed() || self ActionSlotFourButtonPressed()) && ( !IsSubStr(self getCurrentMenu(), "client_") || !self isInMain() ) )
                {
                    self.menu[ "submenu_cursor" ] += self ActionSlotThreeButtonPressed();
                    self.menu[ "submenu_cursor" ] -= self ActionSlotFourButtonPressed();
                    
                    if(self getSubmenuCurs() > getSubmenus().size-1)
                        self setSubmenuCurs( 0 );
                        
                    if(self getSubmenuCurs() < 0)
                        self setSubmenuCurs( getSubmenus().size-1 );
                        
                     self thread newMenu( self getSubmenus()[getSubmenuCurs()].p1 );
                    
                    wait .15;
                }
                
                else if( self useButtonPressed() )
                {
                    menu = self.eMenu[self getCursor()];
                    self thread doOption(menu.func, menu.p1, menu.p2, menu.p3, menu.p4, menu.p5);
                    wait .15;
                }
                
                else if( self meleeButtonPressed() )
                {
                    if( self isInMain() )
                        self menuClose();
                    else
                        self newMenu();
                        
                    wait .2;
                }
            }
        }
        wait .05;
    }
}

doOption(func, p1, p2, p3, p4, p5, p6)
{
    if(!isdefined(func))
        return;
    if(isdefined(p6))
        self thread [[func]](p1,p2,p3,p4,p5,p6);
    else if(isdefined(p5))
        self thread [[func]](p1,p2,p3,p4,p5);
    else if(isdefined(p4))
        self thread [[func]](p1,p2,p3,p4);
    else if(isdefined(p3))
        self thread [[func]](p1,p2,p3);
    else if(isdefined(p2))
        self thread [[func]](p1,p2);
    else if(isdefined(p1))
        self thread [[func]](p1);
    else
        self thread [[func]]();
}

menuOpen()
{
    self endon("MenuClosed");
    self.menu["isOpen"] = true;
    self SetBlur(13, .01);
    self menuOptions();
    self drawText(); 
    visionset_mgr::activate("visionset", "overdrive", self); 
    self newMenu(self getSubmenus()[getSubmenuCurs()].p1);
    self updateScrollbar();
}

menuClose()
{
    self SetBlur(0, .01);
    self destroyAll(self.menu["OPT"]);
    visionset_mgr::deactivate("visionset", "overdrive", self);
    self notify("MenuClosed");
    self.menu["isOpen"] = false;
}

drawText()
{
    self endon("MenuClosed");
    if(!isDefined(self.menu["OPT"]))
        self.menu["OPT"] = [];
        
    self.menu["OPT"]["BG"] = self createRectangle("CENTER", "CENTER", 0, 0, 1000, 1000, (0, 0, 0), "white", 0, .6);
        
    for(e=0;e<3;e++)
    {
        fontscale = 1.7;
        if(e == 1)
            fontscale = 1.9;
        
        self.menu["OPT"]["TITLE" + e] = self createText("default", fontscale, "CENTER", "CENTER", -140 + (e * 140), -205, 3, 0, "", (1, 1, 1));//185    
        self.menu["OPT"]["TITLE" + e] thread hudFade(1, .2);
    }
    self refreshTitle();

    for(e=0;e<15;e++)
    {
        self.menu["OPT"][e] = self createText("default", 1.5, "CENTER", "TOP", 0, 60 + (e * 18), 3, 0, "", (1, 1, 1));
        self.menu["OPT"][e] thread hudFade(1, .2);
    }
    self setMenuText();
}

getSubmenus()
{
    self endon("MenuClosed");
    
    if(IsDefined( self.submenus ))
        return self.submenus;
        
    self.submenus = [];
    for(e=0;e<self.eMenu.size;e++)
    {
        if(isDefined(self.eMenu[e].func) && self.eMenu[e].func == ::newMenu)
            self.submenus[self.submenus.size] = self.eMenu[e];
    }
        
    return self.submenus;
}

getSubmenuCurs()
{ 
    return self.menu[ "submenu_cursor" ];
}

setSubmenuCurs( val )
{ 
    self.menu[ "submenu_cursor" ] = val;
}

refreshTitle()
{
    self endon("MenuClosed");
    if(IsSubStr(self getCurrentMenu(), "client_") || !self isInMain())
    {
        for(e=0;e<3;e++)
        {
            if(e == 1)
            {
                self.menu["OPT"]["TITLE" + e ] setText(self.MenuTitle);
                self.menu["OPT"]["TITLE" + e ].color = (getSubmenusColourAccess(self.currentMenuColour)[0], getSubmenusColourAccess(self.currentMenuColour)[1], getSubmenusColourAccess(self.currentMenuColour)[2]);
            }
            else
            {
                self.menu["OPT"]["TITLE" + e ] setText( "" );
                self.menu["OPT"]["TITLE" + e ].color = (1, 1, 1);
            }
        }
    }
    else
    {
    
        for(e=0;e<3;e++)
        {
            self.menu["OPT"]["TITLE" + e ] setText(self getSubmenus()[revalueTitles(getSubmenuCurs() + (e - 1), getSubmenus())].opt);
            if(e == 1)
            {
                self.menu["OPT"]["TITLE" + e ].color = (getSubmenusColourAccess(self.currentMenuColour)[0], getSubmenusColourAccess(self.currentMenuColour)[1], getSubmenusColourAccess(self.currentMenuColour)[2]);
            }
            else
                self.menu["OPT"]["TITLE" + e ].color = (1, 1, 1);
        }
            
    }
}
    
isInMain()
{
    self endon("MenuClosed");
    for(e=0;e<getSubmenus().size;e++)
        if( getSubmenus()[e].p1 == getCurrentMenu() )
            return true;
            
    return false;
}
 
revalueTitles(value, array)
{
    if(value < 0) return value + array.size;
    if(value >= array.size) return value - array.size;
    return value;
}

scrollingSystem()
{
    if(self getCursor() >= self.eMenu.size || self getCursor() < 0 || self getCursor() == 13)
    {
        if(self getCursor() <= 0)
            self.menu[ self getCurrentMenu() + "_cursor" ] = self.eMenu.size -1;
        else if(self getCursor() >= self.eMenu.size)
            self.menu[ self getCurrentMenu() + "_cursor" ] = 0;
        self setMenuText();
        self updateScrollbar();
    }
    if(self getCursor() >= 14)
        self setMenuText();
    else 
        self updateScrollbar();
}

updateScrollbar()
{
    self endon("MenuClosed");
    curs = self getCursor();
    if(curs >= 14)
        curs = 13;
        
    self notify("stop_text_effects");
    wait .05;  
    self.menu["OPT"][curs] thread flashElemMonitor( self );  
    self.menu["OPT"][curs] thread flashElem( 1, .5, .13, self );   
}

setMenuText()
{
    self endon("MenuClosed");
    ary = 0;
    if(self getCursor() >= 14)
        ary = self getCursor() - 13;
        
    for(e=0;e<20;e++)
    {
        if(isDefined(self.eMenu[ e ].opt))
            self.menu["OPT"][ e ] setText( self.eMenu[ ary + e ].opt );
        else     
            self.menu["OPT"][ e ] setText( "" );
    }
}
        
flashElem( alpha1, alpha2, time, player )
{
    player endon("MenuClosed");
    player endon("stop_text_effects");
    self.fontScale = 1.9;
    for(;;)
    {
        r          = randomint(255); g = randomint(255); b = randomint(255);
        self.color = ( (r / 255), (g / 255), (b / 255) );
        self fadeOverTime(.2);
        wait .2;
    }
}

flashElemMonitor( player )
{
    player endon("MenuClosed");
    player waittill("stop_text_effects");  
    self.color     = (1, 1, 1);
    self.fontScale = 1.5;
}

// FILE MERGE: [ structure.gsc ]
initializeSetup( access, player, allaccess )
{
    if(isDefined(player.access) && access == player.access && !player isHost())
        return self iprintln("^1Error ^7" + player.name + " is already this access level.");
    if(isDefined(player.access) && player.access == 5 )
        return self iprintln("^1Error ^7You can not edit players with access level Host.");
    if(isDefined(player.access) && player == self)
        return self iprintln("^1Error ^7You can not edit you're own access level.");
            
    player notify("end_menu");
    player.access = access;
    
    if( player isMenuOpen() )
        player menuClose();

    player.menu = [];
    player.previousMenu = [];
    player.menu["isOpen"] = false;
    player.menu["isLocked"] = false;

    if( !isDefined(player.menu["current"]) )
         player.menu["current"] = "main";
         
    if(player != self && !IsDefined(allaccess))
        self IPrintLn(player.name + " Access Set " + level.Status[player.access]);
        
    player menuOptions();
    player thread MenuAccessSpawn();
    player thread menuMonitor();
}

AllPlayersAccess(access)
{
    if(level.players.size <= 1)
        return IPrintLn("^1Error: ^7No Players Found");
    
    self IPrintLn("All Players Access Set " + level.Status[access]);
    foreach(player in level.players)
    {
        if(player isHost() || player == self)
            continue;
            
        self thread initializeSetup(access, player, true);
        wait .1;
    }
}

newMenu( menu )
{
    if(!isDefined( menu ))
    {
        menu = self.previousMenu[ self.previousMenu.size -1 ];
        self.previousMenu[ self.previousMenu.size -1 ] = undefined;
    }
    else 
        self.previousMenu[ self.previousMenu.size ] = self getCurrentMenu();
        
    self setCurrentMenu( menu );
    self menuOptions();
    self setMenuText();
    self refreshTitle();
    self updateScrollbar();
}

addMenu( menu, title, access )
{
    self.storeMenu = menu;
    if(self getCurrentMenu() != menu)
        return;
        
    self.currentMenuColour = access;
    self.MenuTitle         = title;
    self.eMenu             = [];
    if(!isDefined(self.menu[ menu + "_cursor"]))
        self.menu[ menu + "_cursor"] = 0;
    if(!IsDefined(self.menu[ "submenu_cursor" ]))   
        self.menu[ "submenu_cursor" ] = 0;
}

addOpt( opt, func, p1, p2, p3, p4, p5 )
{
    if(self.storeMenu != self getCurrentMenu())
        return;
        
    option      = spawnStruct();
    option.opt  = opt;
    option.func = func;
    option.p1   = p1;
    option.p2   = p2;
    option.p3   = p3;
    option.p4   = p4;
    option.p5   = p5;
    self.eMenu[self.eMenu.size] = option;
}

addOptDesc( opt, title, shader, desc, func, p1, p2, p3, p4, p5 )
{
    if(self.storeMenu != self getCurrentMenu())
        return;
        
    option        = spawnStruct();
    option.opt    = opt;
    option.title  = title;
    option.shader = shader;
    option.desc   = desc;
    
    option.func   = func;
    option.p1     = p1;
    option.p2     = p2;
    option.p3     = p3;
    option.p4     = p4;
    option.p5     = p5;
    self.eMenu[self.eMenu.size] = option;
}

setCurrentMenu( menu )
{
    self.menu["current"] = menu;
}

getCurrentMenu()
{
    return self.menu["current"];
}

getCursor()
{
    return self.menu[ self getCurrentMenu() + "_cursor" ];
}

isMenuOpen()
{
    if( !isDefined(self.menu["isOpen"]) || !self.menu["isOpen"] )
        return false;
        
    return true;
}

// FILE MERGE: [ utilities.gsc ]
createText(font, fontScale, align, relative, x, y, sort, alpha, text, color, isLevel)
{
    if(isDefined(isLevel))
        textElem = level hud::createServerFontString(font, fontScale);
    else 
        textElem = self hud::createFontString(font, fontScale);

    textElem hud::setPoint(align, relative, x, y);
    textElem.hideWhenInMenu = true;
    textElem.archived = false;

    textElem.sort           = sort;
    textElem.alpha          = alpha;
    textElem.color = color;

    textElem SetText(text);
    return textElem;
}

createRectangle(align, relative, x, y, width, height, color, shader, sort, alpha, server)
{
    if(isDefined(server))
        boxElem = newHudElem();
    else
        boxElem = newClientHudElem(self);

    boxElem.elemType = "icon";
    boxElem.color = color;
    if(!level.splitScreen)
    {
        boxElem.x = -2;
        boxElem.y = -2;
    }
    boxElem.hideWhenInMenu = true;
    boxElem.archived = false;
    
    boxElem.width          = width;
    boxElem.height         = height;
    boxElem.align          = align;
    boxElem.relative       = relative;
    boxElem.xOffset        = 0;
    boxElem.yOffset        = 0;
    boxElem.children       = [];
    boxElem.sort           = sort;
    boxElem.alpha          = alpha;
    boxElem.shader         = shader;

    boxElem hud::setParent(level.uiParent);
    boxElem setShader(shader, width, height);
    boxElem.hidden = false;
    boxElem hud::setPoint(align, relative, x, y);
    return boxElem;
}

isInArray( array, text )
{
    for(e=0;e<array.size;e++)
        if( array[e] == text )
            return true;
    return false;        
}

getName()
{
    name = self.name;
    if(name[0] != "[")
        return name;
    for(a = name.size - 1; a >= 0; a--)
        if(name[a] == "]")
            break;
    return(getSubStr(name, a + 1));
}

destroyAll(array)
{
    if(!isDefined(array))
        return;
    keys = getArrayKeys(array);
    for(a=0;a<keys.size;a++)
    if(isDefined(array[keys[a]][0]))
        for(e=0;e<array[keys[a]].size;e++)
            array[keys[a]][e] destroy();
    else
        array[keys[a]] destroy();
}
    
bool(variable)
{
    return isdefined(variable) && int(variable);
}

toUpper( string )
{
    if( !isDefined( string ) || string.size <= 0 )
        return "";
    alphabet = strTok("A;B;C;D;E;F;G;H;I;J;K;L;M;N;O;P;Q;R;S;T;U;V;W;X;Y;Z;0;1;2;3;4;5;6;7;8;9; ;-;_", ";");
    final    = "";
    for(e=0;e<string.size;e++)
        for(a=0;a<alphabet.size;a++)
            if(IsSubStr(toLower(string[e]), toLower(alphabet[a])))         
                final += alphabet[a];
    return final;            
}

hudFade(alpha, time)
{
    self endon("StopFade");
    self fadeOverTime(time);
    self.alpha = alpha;
    wait time;
}

hudMoveX(x, time)
{
    self moveOverTime(time);
    self.x = x;
    wait time;
}

hudMoveY(y, time)
{
    self moveOverTime(time);
    self.y = y;
    wait time;
}

hasMenu()
{
    if( IsDefined( self.access ) && self.access != "None" )
        return true;
    return false;    
}

getSubmenusColourAccess(access)
{
    switch(access)
    {
        case 2:
            colour = (1, 1, 0);
            break;
            
        case 3:
            colour = (1, 0, 1);
            break;
            
        case 4:
            colour = (0, 1, 1);
            break;
            
        default:
            colour = (1, 1, 1);
            break;
    }
        
    return colour;
}