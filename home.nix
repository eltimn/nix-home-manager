# https://nix-community.github.io/home-manager/options.xhtml
# https://github.com/Yumasi/nixos-home/tree/main
# https://github.com/chrisportela/dotfiles
# https://www.chrisportela.com/posts/home-manager-flake/
{ config, pkgs, username, ... }: {
  home = {
    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    username = "${username}";
    homeDirectory = "/home/${username}";

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "23.11";

    # Packages that should be installed to the user profile.
    packages = with pkgs; [
      # ack-grep
      # dnsutils
      enpass
      ffmpeg
      git
      gnome.gnome-tweaks
      htop
      # libnss3-tools
      libnotify
      neovim
      # net-tools
      nixfmt
      notify-osd
      parcellite
      sshfs
      # trash-cli
      xclip
      yubikey-manager
    ];

    # List of extra paths to include in the user profile.
    sessionPath = [ "$HOME/.pulumi/bin" ];

    # List of environment variables.
    sessionVariables = {
      EDITOR = "/usr/bin/code --new-window --wait";
      # JAVA_HOME = "/usr/lib/jvm/java-17-openjdk-amd64";
    };

    # List of files to be symlinked into the user home directory.
    file.".config/Code/User/settings.json".source =
      ./files/.config/Code/User/settings.json;
    file.".config/git/config".source = ./files/.config/git/config;
    file.".config/terminator/config".source = ./files/.config/terminator/config;
    file.".oh-my-zsh-custom".source = ./files/.oh-my-zsh-custom;
    file."bin".source = ./files/bin;
    file.".ackrc".source = ./files/.ackrc;
    file.".ansible.cfg".source = ./files/.ansible.cfg;
    file.".gitignore".source = ./files/.gitignore;
    file.".mongoshrc.js".source = ./files/.mongoshrc.js;
    file.".abcde.conf".source = ./files/.abcde.conf;
  };

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    # direnv
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    # fzf
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    # tmux
    tmux = {
      enable = true;
      shell = "${pkgs.zsh}/bin/zsh";
      shortcut = "a";
      terminal = "screen-256color";
      plugins = with pkgs; [ tmuxPlugins.sensible tmuxPlugins.cpu ];
      tmuxinator.enable = true;
    };

    # zoxide
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    # zsh
    zsh = {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      syntaxHighlighting.enable = true;

      oh-my-zsh = {
        enable = true;
        theme = "philips"; # https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
        custom = "$HOME/.oh-my-zsh-custom";
        plugins = [ "copyfile" "copypath" "colorize" ];
      };
    };
  };

  # services = {
  #   gpg-agent = {
  #     enable = true;
  #     defaultCacheTtl = 1800;
  #     enableSshSupport = true;
  #   };
  # };
}
