{ config, pkgs, ... }:

{
  home.packages = with pkgs;
    [
      # Add your user-level packages here
    ];

    #Fish
    programs.fish.enable = true;

    #Git
programs.git = {
    enable = true;
    userName  = "dragonalias";
    userEmail = "dragon1600@gmail.com";
  };    

  #Atuin
  programs.atuin =
  {
    enable = true;
    enableFishIntegration = true;
    
  };

  #Zoxide
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  #Helix
  programs.helix = {
    enable = true;
    settings = {
      theme = "bogster";
      editor = {
true-color = true;
bufferline = "always";
auto-pairs = false;
    line-number = "relative";

statusline = 
{
  mode.normal = "NORMAL";
mode.insert = "INSERT";
mode.select = "SELECT";

};
cursor-shape = {
        normal = "block";
        insert = "bar";
        select = "underline";
      };
  lsp = 
  {
    display-messages = true;
  };
};

keys =
{
  normal = {
    space.w = ":w";
    space.q = ":q";
    esc = [ "collapse_selection" "keep_primary_selection" ];

    "A-/" = "repeat_last_motion";
"C-tab" = "goto_previous_buffer";
"C-S-tab" = "goto_next_buffer";
"A-w" = ":buffer-close";
X = "extend_line_above";
ret = ["open_below" "normal_mode"]; # Maps the enter key to open_below then re-enter normal mode
y = [":clipboard-yank" "yank"];
"C-A-|"   = "shell_pipe";         	# Pipe each selection through shell command, replacing with output

  };

  select = 
  {
    y = [":clipboard-yank" "yank"];
  };
normal = {
          "*" = {
            b = ":run-shell-command cargo build";
            t = ":run-shell-command cargo test";
          };
        };
      };
      };
 languages = {
        rust = {
          auto-format = false;
        };
        nix = {
          auto-format = true;
          formatter.command = "${pkgs.nixfmt}/bin/nixfmt";
        };
      };
    };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
