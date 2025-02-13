{
  config,
  lib,
  pkgs,
  ...
}:

let
  secrets = import ./secrets.nix { inherit lib; };
  unfree = import ./unfree.nix { inherit lib; };
  unstable = unfree.importWithPredicate <nixos-unstable> { };
in
{
  nixpkgs = {
    config.allowUnfreePredicate = unfree.predicate;
  };

  imports = [
    ./hardware-configuration.nix
    <home-manager/nixos>
  ];

  environment.systemPackages = [ ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = false; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = false; # Open ports in the firewall for Source Dedicated Server
  };

  users = {
    mutableUsers = false;
    users = {
      boni = {
        isNormalUser = true;
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
        hashedPassword = secrets.hashedUserPassword;
        openssh.authorizedKeys.keys = [ secrets.sshPublicKeyShinujin ];
      };
      admin = {
        isNormalUser = true;
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
        hashedPassword = secrets.hashedAdminPassword;
        openssh.authorizedKeys.keys = [ secrets.sshPublicKeyShinujin ];
      };
    };
  };

  security = {
    doas = {
      enable = true;
      extraRules = [
        {
          groups = [ "wheel" ];
          keepEnv = true;
          persist = true;
        }
      ];
    };
    sudo.enable = false;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.user = import ./home-manager;
  };

  console.keyMap = "de-latin1";
  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "de_DE.UTF-8";

  networking.hostName = "lillamy";

  hardware.bluetooth.enable = true;

  services = {
    btrbk.instances.snapshot = {
      onCalendar = "*:0/15";
      settings = {
        timestamp_format = "long-iso";
        snapshot_preserve_min = "7d";
        subvolume = "/home";
        snapshot_dir = "/home/admin/snapshots";
      };
    };
    openssh = {
      enable = true;
      allowSFTP = false;
      extraConfig = ''
        PermitEmptyPasswords no
        ClientAliveInterval 60
        ClientAliveCountMax 3
      '';
      settings = {
        AllowUsers = [
          "boni"
          "admin"
        ];
        KbdInteractiveAuthentication = false;
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
    };
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
    xserver = {
      enable = true;
      desktopManager.plasma6.enable = true;
      displayManager = {
        autoLogin = {
          enable = true;
          user = "boni";
        };
        #defaultSession = "plasmawayland"; # Causes an annoying fcitx popup. Try again in a while.
        sddm = {
          enable = true;
          wayland.enable = true;
        };
      };
      xkb.layout = "de";
    };
  };

  fonts = {
    packages = with pkgs; [
      dejavu_fonts
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
      noto-fonts-monochrome-emoji
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [
          "DejaVu Serif"
          "Noto Serif"
          "Noto Serif CJK SC"
          "Noto Serif CJK TC"
          "Noto Serif CJK HK"
          "Noto Serif CJK JP"
          "Noto Serif CJK KR"
          "Noto Color Emoji"
          "Noto Emoji"
        ];
        sansSerif = [
          "DejaVu Sans"
          "Noto Sans"
          "Noto Sans CJK SC"
          "Noto Sans CJK TC"
          "Noto Sans CJK HK"
          "Noto Sans CJK JP"
          "Noto Sans CJK KR"
          "Noto Color Emoji"
          "Noto Emoji"
        ];
        monospace = [
          "DejaVu Sans Mono"
          "Noto Sans Mono"
          "Noto Sans Mono CJK SC"
          "Noto Sans Mono CJK TC"
          "Noto Sans Mono CJK HK"
          "Noto Sans Mono CJK JP"
          "Noto Sans Mono CJK KR"
          "Noto Color Emoji"
          "Noto Emoji"
        ];
        emoji = [
          "Noto Color Emoji"
          "Noto Emoji"
        ];
      };
    };
  };

  nix = {
    gc = {
      automatic = true;
      persistent = true;
      dates = "weekly";
      randomizedDelaySec = "10min";
      options = "--delete-older-than 30d";
    };
    optimise = {
      automatic = true;
      # This timer is persistent, although this is undocumented.
      dates = [ "Thursday" ];
    };
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      "zswap.enabled=1"
      "zswap.max_pool_percent=30"
    ];
    kernelModules = [
      "lz4"
      "z3fold"
    ];
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        configurationLimit = 20;
      };
      timeout = 1;
    };
    tmp = {
      useTmpfs = true;
      tmpfsSize = "150%";
    };
  };

  systemd = {
    packages = [ pkgs.systemd ]; # let systemd generate extra units
    # See:
    # https://github.com/NixOS/nixpkgs/issues/44901
    # https://github.com/kurnevsky/nixfiles/blob/master/modules/zswap.nix
    services.zswap-configure = {
      description = "Configure zswap";
      wantedBy = [ "multi-user.target" ];
      serviceConfig.Type = "oneshot";
      script = ''
        echo lz4 > /sys/module/zswap/parameters/compressor
        echo z3fold > /sys/module/zswap/parameters/zpool
      '';
    };
  };

  system = {
    copySystemConfiguration = true;
    stateVersion = "24.11"; # DON'T CHANGE! Read the documentation.
  };
}
