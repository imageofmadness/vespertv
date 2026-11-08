VESPERTV SMART EDITION 0.2

FILES
- index.html: smart TV dashboard
- VesperTV.lsl: owner-only in-world menu and media controls

QUICK START
1. Host index.html on a public HTTPS static website, such as GitHub Pages.
2. Edit VesperTV.lsl: replace DASHBOARD_URL with your hosted index.html URL.
3. In Second Life, put the script into the TV's screen prim.
4. Determine the correct screen face number and set SCREEN_FACE accordingly.
5. Reset the script. Enable media in your viewer and click the screen to interact.
6. Owner touching the TV opens a source menu: Home, YouTube, Twitch, Archive, Off, On.

NOTES
- If touching the screen opens the LSL dialog instead of interacting with media, use the viewer's media controls or put the LSL touch script in a separate frame/button prim.
- The HTML interface is client-side; its favorite URL is session-only and not shared between avatars.
- Websites may block iframe embedding, login, DRM, or autoplay. The LSL source menu navigates the media face directly, but playback is still subject to viewer and site restrictions.
- Off clears media and darkens the screen; On returns to the dashboard.
- No synchronized multi-avatar playback is implemented.
- Test on a copy before distributing. Script and interface have not been tested inworld.
