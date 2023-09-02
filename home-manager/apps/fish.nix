{ config, lib, pkgs, ... }:

{
  programs.fish = {
    enable = true;
    shellAliases = {
      cat = "bat";
      diff = "diffr";
      glow = "glow --pager";
      ip = "ip --color --brief";
      ls = "exa --group-directories-first --icons";
      ll = "exa --long --git --group-directories-first --icons";
      la = "exa --all --long --git --group-directories-first --icons";
      lt = "exa --tree --group-directories-first --icons";
      less = "bat --paging=always";
      more = "bat --paging=always";
      tree = "exa --tree --group-directories-first";
      wget = "wget2";
    };
    shellAbbrs = {
      ga = "git add";
      gc = "git commit -m ";
      gp = "git push";
      nr = "nix run nixpkgs#home-manager -- switch --flake .";
    };
    interactiveShellInit = lib.strings.concatStrings (lib.strings.intersperse "\n" ([
      (builtins.readFile ./config.fish)
      "set -g SHELL ${pkgs.fish}/bin/fish"
    ]));
    plugins = with pkgs.fishPlugins; [
      { name = "grc"; src = pkgs.fishPlugins.grc.src; }
      { name = "pure"; src = pkgs.fishPlugins.pure.src; }
      { name = "colored-man-pages"; src = pkgs.fishPlugins.colored-man-pages.src; }
      { name = "sponge"; src = pkgs.fishPlugins.sponge.src; }
      { name = "bass"; src = pkgs.fishPlugins.bass.src; }
      { name = "pisces"; src = pkgs.fishPlugins.pisces.src; }
      # {
      #   name = "fish-autovenv";
      #   src = pkgs.fetchFromGitHub {
      #     owner = "mmartinortiz";
      #     repo = "fish-autovenv";
      #     rev = "1.0.0";
      #     sha256 = "f6ib/XcgnKGYbhfZca0PMScbHgZP2nMqF5hEbyG0Afo=";
      #   };
      # }
    ];
    functions =
      {
        __fish_command_not_found_handler = {
          body = "__fish_default_command_not_found_handler $argv[1]";
          onEvent = "fish_command_not_found";
        };

        gitignore = "curl -sL https://www.gitignore.io/api/$argv";
      };
  };
}
