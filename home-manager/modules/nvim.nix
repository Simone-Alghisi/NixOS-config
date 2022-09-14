{ config, pkgs, ...}:

{
  programs.neovim = {
    enable = true;
    viAlias = true;

    # extra config for vim.init (new vim.rc)
    extraConfig = ''
      source ${config.home.homeDirectory}/.config/nvim/general/settings.vim
      source ${config.home.homeDirectory}/.config/nvim/general/terminal.vim
      source ${config.home.homeDirectory}/.config/nvim/plug-config/nerdtree.vim
      source ${config.home.homeDirectory}/.config/nvim/plug-config/coc.vim
      source ${config.home.homeDirectory}/.config/nvim/plug-config/airline.vim
      source ${config.home.homeDirectory}/.config/nvim/keys/mappings.vim
      source ${config.home.homeDirectory}/.config/nvim/themes/theme.vim
      source ${config.home.homeDirectory}/.config/nvim/keys/which-key.vim
      source ${config.home.homeDirectory}/.config/nvim/keys/nerdcommenter.vim
      source ${config.home.homeDirectory}/.config/nvim/keys/fugitive.vim
    '';

    plugins = with pkgs.vimPlugins; [
      fzf-vim
      gruvbox
      nerdcommenter
      nerdtree
      undotree
      vim-airline
      vim-airline-themes
      vim-which-key
      # Better syntax-highlighting for filetypes in vim
      vim-polyglot
      # Git integration
      vim-fugitive
      # Auto-close braces and scopes
      auto-pairs
      # Stable version of coc
      coc-nvim
      # Python
      coc-pyright
      # C and C++ syntax highlight
      vim-lsp-cxx-highlight
      # Markdown
      vim-markdown-toc
    ];

    coc.enable = true;
  };

  home.file.".config/nvim" = {
      source = ../dotfiles/nvim;
      recursive = true;
  };

}
