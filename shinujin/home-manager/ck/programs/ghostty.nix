{
  enable = true;
  enableBashIntegration = true;
  settings = {
    theme = "dark:\"catppuccin-mocha\",light:\"catppuccin-latte\"";

    font-family = "DejaVu Mono";
    font-size = 12;

    cursor-style-blink = false;

    # Mitigate viewing angle issues
    window-padding-x = 3;

    # Disable bar cursor at the prompt
    shell-integration-features = "no-cursor";
  };
  themes = {
    # MIT License, Copyright (c) 2021 Catppuccin
    # See https://github.com/catppuccin/ghostty

    "catppuccin-latte" = {
      palette = [
        "0=#5c5f77"
        "1=#d20f39"
        "2=#40a02b"
        "3=#df8e1d"
        "4=#1e66f5"
        "5=#ea76cb"
        "6=#179299"
        "7=#acb0be"
        "8=#6c6f85"
        "9=#d20f39"
        "10=#40a02b"
        "11=#df8e1d"
        "12=#1e66f5"
        "13=#ea76cb"
        "14=#179299"
        "15=#bcc0cc"
      ];
      background = "#eff1f5";
      foreground = "#4c4f69";
      cursor-color = "#dc8a78";
      cursor-text = "#eff1f5";
      selection-background = "#d8dae1";
      selection-foreground = "#4c4f69";
    };
    "catppuccin-frappe" = {
      palette = [
        "0=#51576d"
        "1=#e78284"
        "2=#a6d189"
        "3=#e5c890"
        "4=#8caaee"
        "5=#f4b8e4"
        "6=#81c8be"
        "7=#b5bfe2"
        "8=#626880"
        "9=#e78284"
        "10=#a6d189"
        "11=#e5c890"
        "12=#8caaee"
        "13=#f4b8e4"
        "14=#81c8be"
        "15=#a5adce"
      ];
      background = "#303446";
      foreground = "#c6d0f5";
      cursor-color = "#f2d5cf";
      cursor-text = "#303446";
      selection-background = "#44495d";
      selection-foreground = "#c6d0f5";
    };
    "catppuccin-macchiato" = {
      palette = [
        "0=#494d64"
        "1=#ed8796"
        "2=#a6da95"
        "3=#eed49f"
        "4=#8aadf4"
        "5=#f5bde6"
        "6=#8bd5ca"
        "7=#b8c0e0"
        "8=#5b6078"
        "9=#ed8796"
        "10=#a6da95"
        "11=#eed49f"
        "12=#8aadf4"
        "13=#f5bde6"
        "14=#8bd5ca"
        "15=#a5adcb"
      ];
      background = "#24273a";
      foreground = "#cad3f5";
      cursor-color = "#f4dbd6";
      cursor-text = "#24273a";
      selection-background = "#3a3e53";
      selection-foreground = "#cad3f5";
    };
    "catppuccin-mocha" = {
      palette = [
        "0=#45475a"
        "1=#f38ba8"
        "2=#a6e3a1"
        "3=#f9e2af"
        "4=#89b4fa"
        "5=#f5c2e7"
        "6=#94e2d5"
        "7=#bac2de"
        "8=#585b70"
        "9=#f38ba8"
        "10=#a6e3a1"
        "11=#f9e2af"
        "12=#89b4fa"
        "13=#f5c2e7"
        "14=#94e2d5"
        "15=#a6adc8"
      ];
      background = "#1e1e2e";
      foreground = "#cdd6f4";
      cursor-color = "#f5e0dc";
      cursor-text = "#1e1e2e";
      selection-background = "#353749";
      selection-foreground = "#cdd6f4";
    };
  };
}
