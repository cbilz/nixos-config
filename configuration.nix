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
  nixpkgs.config.allowUnfreePredicate = unfree.predicate;

  imports = [
    ./hardware-configuration.nix
    <home-manager/nixos>
  ];

  users = {
    mutableUsers = false;
    users.ck = {
      isNormalUser = true;
      extraGroups = [
        "lp"
        "networkmanager"
        "scanner"
        "wheel"
      ];
      hashedPassword = secrets.hashedUserPassword;
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
    users.ck = import ./home-manager;
  };

  console.keyMap = "de-latin1";
  time.timeZone = "Europe/Berlin";

  networking = {
    hostName = "shinujin";
    # TODO: Configure NetworkManager profiles using networkmanager.ensureProfiles.profiles
    networkmanager.enable = true;
  };

  hardware = {
    bluetooth.enable = true;
    sane = {
      enable = true;
      extraBackends = [ pkgs.utsushi ];
    };
  };

  fileSystems = {
    "/".options = [ "compress=zstd" ];
    "/mnt/aliisa" = {
      device = "/dev/mapper/aliisa";
      options = [ "noauto,compress=zstd" ];
    };
    "/mnt/meri" = {
      device = "/dev/mapper/meri";
      options = [ "noauto,compress=zstd" ];
    };
    "/mnt/toffle" = {
      device = "/dev/mapper/toffle";
      options = [ "noauto,compress=zstd" ];
    };
  };

  # We need to override the value in `hardware-configuration.nix`, see
  # https://github.com/NixOS/nixpkgs/issues/86353
  swapDevices = lib.mkForce [
    {
      device = "/dev/disk/by-partuuid/ea87f3d7-293c-0649-87c7-be56e8660364";
      randomEncryption.enable = true;
    }
  ];

  environment = {
    systemPackages = with pkgs; [
      # TODO: Provide nvd only for nix-scripts
      nvd
    ];
    gnome.excludePackages = with pkgs; [
      baobab
      epiphany
      file-roller
      geary
      gnome-calculator
      gnome-calendar
      gnome-console
      gnome-contacts
      gnome-maps
      gnome-system-monitor
      gnome-text-editor
      gnome-tour
      loupe
      seahorse
      totem
    ];
    etc.crypttab = {
      text = ''
        aliisa  UUID=94f9337b-605d-475e-bb5a-e78b2175c292	/root/keyfiles/aliisa.key   noauto,x-systemd.device-timeout=1ms
        meri	UUID=2aaa4cf8-2653-4465-8f60-a6098cfb0b5e	/root/keyfiles/meri.key     noauto,x-systemd.device-timeout=1ms
        krtek	UUID=c1e24267-ec57-4a53-89d1-07aac089a693	/root/keyfiles/krtek.key    noauto,x-systemd.device-timeout=1ms
        toffle	UUID=b9f839a3-63bb-4fda-b4fe-057b24f3f8a4	/root/keyfiles/toffle.key   noauto,x-systemd.device-timeout=1ms
      '';
    };
  };

  services = {
    btrbk.instances.snapshot = {
      onCalendar = "*:0/15";
      settings = {
        timestamp_format = "long-iso";
        snapshot_preserve_min = "7d";
        subvolume = "/home/ck";
        snapshot_dir = "/home/btrbk_snapshots";
      };
    };
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
    udev.packages = [ pkgs.utsushi ];
    xserver = {
      enable = true;
      desktopManager.gnome.enable = true;
      displayManager.gdm.enable = true;
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
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [
          "DejaVu Serif"
          "Noto Serif CJK SC"
          "Noto Serif CJK TC"
          "Noto Serif CJK HK"
          "Noto Serif CJK JP"
          "Noto Serif CJK KR"
          "Noto Serif"
        ];
        sansSerif = [
          "DejaVu Sans"
          "Noto Sans CJK SC"
          "Noto Sans CJK TC"
          "Noto Sans CJK HK"
          "Noto Sans CJK JP"
          "Noto Sans CJK KR"
          "Noto Sans"
        ];
        monospace = [
          "DejaVu Sans Mono"
          "Noto Sans Mono CJK SC"
          "Noto Sans Mono CJK TC"
          "Noto Sans Mono CJK HK"
          "Noto Sans Mono CJK JP"
          "Noto Sans Mono CJK KR"
          "Noto Sans Mono"
        ];
        emoji = [
          "Noto Color Emoji"
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
      dates = [ "Sun, 16:00" ];
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
    blacklistedKernelModules = [
      # Disabled due to kworker CPU hogging. Possibly faulty driver or hardware.
      "rtsx_pci_sdmmc"
    ];
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        configurationLimit = 20;
      };
    };
    tmp = {
      useTmpfs = true;
      tmpfsSize = "150%";
    };
  };

  systemd = {
    # TODO: Why do we have this?
    packages = [ pkgs.systemd ];

    services.umount-external = {
      script = ''
        systemctl stop systemd-cryptsetup@aliisa systemd-cryptsetup@meri systemd-cryptsetup@toffle
      '';
      serviceConfig = {
        Type = "oneshot";
      };
    };

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
    stateVersion = "23.05"; # DON'T CHANGE! Read the documentation.
  };
}
