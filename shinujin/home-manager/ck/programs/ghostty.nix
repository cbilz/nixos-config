{
  enable = true;
  enableBashIntegration = true;
  settings = {
    theme = "dark:\"Melange Dark\",light:\"Melange Light\"";

    font-family = "DejaVu Mono";
    font-size = 12;

    cursor-style-blink = false;

    # Mitigate viewing angle issues
    window-padding-x = 3;

    # Disable bar cursor at the prompt
    shell-integration-features = "no-cursor";
  };
  themes = {
    # See https://github.com/savq/melange-nvim
    # Copyright (c) 2021 Sergio Alejandro Vargas
    "Melange Light" = {
      palette = [
        "0=#e9e1db"
        "1=#c77b8b"
        "2=#6e9b72"
        "3=#bc5c00"
        "4=#7892bd"
        "5=#be79bb"
        "6=#739797"
        "7=#7d6658"
        "8=#a98a78"
        "9=#bf0021"
        "10=#3a684a"
        "11=#a06d00"
        "12=#465aa4"
        "13=#904180"
        "14=#3d6568"
        "15=#54433a"
      ];
      background = "#f1f1f1";
      foreground = "#54433a";
      cursor-color = "#54433a";
      selection-background = "#d9d3ce";
      selection-foreground = "#54433a";
    };
    "Melange Dark" = {
      palette = [
        "0=#34302c"
        "1=#bd8183"
        "2=#78997a"
        "3=#e49b5d"
        "4=#7f91b2"
        "5=#b380b0"
        "6=#7b9695"
        "7=#c1a78e"
        "8=#867462"
        "9=#d47766"
        "10=#85b695"
        "11=#ebc06d"
        "12=#a3a9ce"
        "13=#cf9bc2"
        "14=#89b3b6"
        "15=#ece1d7"
      ];
      background = "#292522";
      foreground = "#ece1d7";
      cursor-color = "#ece1d7";
      selection-background = "#403a36";
      selection-foreground = "#ece1d7";
    };
  };
}
