{ config, pkgs, ...}:

{
  programs.neovim = {
    enable = true;
    viAlias = true;

    # extra config for vim.init (new vim.rc)
    extraConfig = ''
      set clipboard=unnamedplus
      set background=dark
      colorscheme gruvbox
      let g:airline_powerline_fonts = 1
      set number
      set relativenumber
    '';

    # python3 packages and config
    withPython3 = true;
    extraPython3Packages = (ps: with ps; [
      flake8
      pylint
      black
      jedi
    ]);

    plugins = with pkgs.vimPlugins; [
      gruvbox
      nerdtree
      fzf-vim
      vim-airline
      vim-airline-themes
      # Better syntax-highlighting for filetypes in vim
      vim-polyglot
      # Git integration
      vim-fugitive
      # Auto-close braces and scopes
      auto-pairs
      # Stable version of coc
      coc-nvim
      coc-pyright
      # C and C++ syntax highlight
      vim-lsp-cxx-highlight
      # Which key
      vim-which-key
      # Nerd commenter
      nerdcommenter
    ];

    coc = {
      enable = true;
      settings = {
        "coc.preferences.formatOnSaveFiletypes" = [
          "css"
          "markdown"
          "javascript"
          "graphql"
          "html"
          "yaml"
          "json"
          "python"
          "c"
          "cpp"
          "h"
        ];
        # python config
        "pyright.enable" = true;
        "python.linting.pylintEnabled" = true;
        "python.linting.enabled" = true;
        "python.jediEnabled" = true;
        "python.linting.flake8Enabled" = true;
        "python.formatting.provider" = "black";
      };
    };
  };
}
