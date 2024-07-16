![Presents](https://github.com/user-attachments/assets/9a85abf8-a343-43e4-bafe-cb295bc34e8f)
# edenlinux
Source Code for Eden Linux - NixOS Stylish Release

[Coming Soon with NixCon 2024 Berlin!](https://nixos.org/blog/announcements/2024/nixcon-2024/)

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
    jetbrains.writerside
    jetbrains.webstorm
    jetbrains.ruby-mine
    jetbrains.rust-rovers
    jetbrains.rider
    jetbrains.phpstorm
    jetbrains.mps
    jetbrains.clion
    jetbrains.goland
    jetbrains.idea-ultimate
    jetbrains.gateway
    jetbrains.dataspell
    jetbrains.pycharm-comminity
    vscode
    android-studio
    GitLab
    github-desktop
  ];
  ```
- home.nix, now just enable **Hyprland** now. It'll be added some Hyprland configurations.
- flake.nix, enable Plymouth (PS. Doesn't work now.)

This release will provide a `.ovf` virtual machine in _8GB+64GB_. We are trying our best to develop it. The account infomation below:
```
hostname: New_Eridu
Username: Belle
Passwd: nixos
```
# Installation
1. Install by NixOS
  - If you already had an NixOS host and installed a **command runner** called `just`. Then run 
  ```shell
  sudo git clone https://github.com/arkimium/edenlinux.git
  just deploy
  ```
  Uh if no `just` then run `nixos-rebuild switch`.
  
  ~~Hey don't GitHub release their GitHub CLI `gh`? You can use it!~~ Well if you have `gh`. It'll be easily execute.
  ```shell
  sudo gh repo clone arkimium/edenlinux
  cd edenlinux
  just deploy && reboot   # or nixos-rebuild switch
  ```
# Support Desktop Environments
- KDE 5/6
- GNOME
- XFCE
- MATE
- HikariWM (in [Darcs.hub](https://hub.darcs.net/raichoo/hikari-website))
- Hyprland
- Emacs EXWM (Emacs-like X Compositor built on Emacs)
- ...

# Issue
- `flake.nix` doesn't work. I'll renew it on Saturday. 
- I wanna **enable Plymouth**. Plymouth was installed but I can't execute `plymouth-set-default-theme`. However the binary executable file was in Plymouth's file folder. Weird! Why I can't execute this command? Finding help in **NixOS Discourse**.