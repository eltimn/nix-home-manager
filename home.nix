{ config, pkgs, ... }:

{
  home = {
    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    username = "nelly";
    homeDirectory = "/home/nelly";

    # Packages that should be installed to the user profile.
    packages = with pkgs; [
      htop
      neovim
      git
    ];

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "23.11";

    sessionPath = [
      "$HOME/.config/zsh/scripts"
      "$HOME/.pulumi/bin"
    ];

    sessionVariables = {
      EDITOR = "/usr/bin/code --new-window --wait";
    };

    file.".config/Code/User/settings.json".source = ./files/Code/User/settings.json;
    file.".config/git/config".source = ./files/git/config;
  };

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    # zsh
    zsh = {
      enable = true;
      # enableCompletion = true;
      # enableAutosuggestions = true;
      # syntaxHighlighting.enable = true;

      oh-my-zsh = {
        enable = true;
        # enableUnstable = true;
        # theme = "powerlevel10k/powerlevel10k";
        theme = "robbyrussell";
        custom = "$HOME/.oh-my-zsh-custom";
        plugins = [
          "copyfile"
          "copypath"
          "colorize"
        ];
      };
    };

    # direnv
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  };

  services = {
    gpg-agent = {
      enable = true;
      defaultCacheTtl = 1800;
      enableSshSupport = true;
    };
  };
}
