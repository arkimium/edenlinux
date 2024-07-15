![Presents](https://github.com/user-attachments/assets/9a85abf8-a343-43e4-bafe-cb295bc34e8f)
# edenlinux
Source Code for Eden Linux - NixOS Stylish Release

[![NixOS build Version](https://img.shields.io/badge/NixOS%20Build-24.05-blue)](https://nixos.org/blog/announcements/2024/nixos-2405/)
[![Hyprland Supported](https://img.shields.io/badge/Hyprland-blue?&style=for-the-badge&logo=hyprland&logoColor=white)](https://wiki.hyprland.org/Nix/Hyprland-on-NixOS/)

# Introduction
The Repository now release **yarnOS** Configuration. Included
- **configuration.nix**: Configurations, include nixpkgs below
  ```nix
    # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.belle = {
    isNormalUser = true;
    description = "Belle";
    # passwd = "nixos";  # I found that user.user.username.passwd is undefined. So I give it up.
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      chromium
      oxygen
      konsole
      fastfetch
      zsh
    ];
  };

  
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    neovide
    vimPlugins.lazy-nvim
    wget
    curl
    git
    jetbrains.pycharm-community
  ];
  ```
