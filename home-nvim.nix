{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };

  xdg.configFile."nvim/init.lua".source = ./init.lua;

  home.packages = with pkgs; [
    # LSP servers (others already in home-cli.nix: nixd, typescript-language-server, intelephense)
    vscode-langservers-extracted # eslint, html, css, json
    elixir-ls
    lua-language-server

    # Treesitter parser compilation
    tree-sitter
  ];
}
