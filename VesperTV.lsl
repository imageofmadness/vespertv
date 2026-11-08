// VesperTV Smart 0.2 - place this script in the TV screen prim.
// Replace DASHBOARD_URL with the public HTTPS URL of index.html.
integer SCREEN_FACE = 0;
string DASHBOARD_URL = "https://example.com/vespertv/index.html";
integer MENU_CHANNEL;
integer MENU_LISTEN;
key MENU_USER;
integer POWERED = TRUE;
list BUTTONS = ["Home", "YouTube", "Twitch", "Archive", "Off", "On"];
string urlFor(string button)
{
    if (button == "YouTube") return "https://www.youtube.com/";
    if (button == "Twitch") return "https://www.twitch.tv/";
    if (button == "Archive") return "https://archive.org/details/movies";
    return DASHBOARD_URL;
}
showURL(string url)
{
    llSetPrimMediaParams(SCREEN_FACE, [
        PRIM_MEDIA_CURRENT_URL, url,
        PRIM_MEDIA_HOME_URL, DASHBOARD_URL,
        PRIM_MEDIA_AUTO_PLAY, TRUE,
        PRIM_MEDIA_AUTO_SCALE, TRUE,
        PRIM_MEDIA_WIDTH_PIXELS, 1024,
        PRIM_MEDIA_HEIGHT_PIXELS, 576,
        PRIM_MEDIA_PERMS_INTERACT, PRIM_MEDIA_PERM_ANYONE,
        PRIM_MEDIA_PERMS_CONTROL, PRIM_MEDIA_PERM_OWNER
    ]);
}
closeMenu()
{
    if (MENU_LISTEN) llListenRemove(MENU_LISTEN);
    MENU_LISTEN = 0;
    llSetTimerEvent(0.0);
}
default
{
    state_entry()
    {
        MENU_CHANNEL = -100000 - (integer)llFrand(1000000.0);
        POWERED = TRUE;
        showURL(DASHBOARD_URL);
    }
    touch_start(integer count)
    {
        key avatar = llDetectedKey(0);
        if (avatar != llGetOwner())
        {
            llRegionSayTo(avatar, 0, "Only the owner can change TV settings. Click the media face to browse if enabled.");
            return;
        }
        closeMenu();
        MENU_USER = avatar;
        MENU_LISTEN = llListen(MENU_CHANNEL, "", avatar, "");
        llDialog(avatar, "VesperTV Smart | Choose a source", BUTTONS, MENU_CHANNEL);
        llSetTimerEvent(30.0);
    }
    listen(integer channel, string name, key id, string message)
    {
        if (id != MENU_USER) return;
        if (llListFindList(BUTTONS, [message]) == -1) return;
        if (message == "Off")
        {
            POWERED = FALSE;
            llClearPrimMedia(SCREEN_FACE);
            llSetLinkColor(LINK_THIS, <0.02,0.03,0.05>, SCREEN_FACE);
        }
        else
        {
            POWERED = TRUE;
            llSetLinkColor(LINK_THIS, <1.0,1.0,1.0>, SCREEN_FACE);
            showURL(urlFor(message));
        }
        closeMenu();
    }
    timer() { closeMenu(); }
    changed(integer change)
    {
        if (change & CHANGED_OWNER) llResetScript();
    }
}
