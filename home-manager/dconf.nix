{ lib }:
let
  wallpaper = "file:///home/ck/Pictures/wallpaper.jpg";
in
with lib.hm.gvariant;
{
  # Useful commands for discovering and converting dconf settings:
  # - `dconf dump / | dconf2nix > dconf.nix`
  # - `dconf watch /`
  # - `dconf-editor`
  # I was unable to convert world clock settings.
  settings = {
    "org/gnome/desktop/background" = {
      picture-options = "zoom";
      picture-uri = wallpaper;
      picture-uri-dark = wallpaper;
    };

    "org/gnome/desktop/interface" = {
      clock-show-seconds = true;
      clock-show-weekday = true;
      enable-hot-corners = false;
      font-name = "DejaVu Sans 10";
      toolbar-style = "text";
    };

    "org/gnome/desktop/notifications" = {
      show-in-lock-screen = false;
    };

    "org/gnome/desktop/screensaver" = {
      lock-delay = mkUint32 30;
      picture-options = "zoom";
      picture-uri = wallpaper;
    };

    "org/gnome/desktop/wm/keybindings" = {
      close = [ "<Super>q" ];
      minimize = [ ];
      toggle-fullscreen = [ "<Super>f" ];
      unmaximize = [ ];
    };

    "org/gnome/mutter" = {
      dynamic-workspaces = true;
      edge-tiling = false;
      workspaces-only-on-primary = false;
    };

    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = true;
      night-light-schedule-automatic = false;
      night-light-temperature = mkUint32 2700;
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      screensaver = [ "<Super>Escape" ];
    };

    "org/gnome/settings-daemon/plugins/power" = {
      idle-dim = false;
      power-button-action = "interactive";
      sleep-inactive-ac-type = "nothing";
    };

    "org/gnome/shell" = {
      favorite-apps = [
        "com.mitchellh.ghostty.desktop"
        "org.qutebrowser.qutebrowser.desktop"
        "thunderbird.desktop"
      ];
    };

    "org/gnome/system/location" = {
      enabled = false;
    };
  };
}
