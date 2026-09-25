{ ... }:
{
  flake.homeModules.nvfModule =
    {
      inputs,
      pkgs,
      lib,
      ...
    }:
    {
      imports = [
        inputs.nvf.homeManagerModules.default
      ];

      programs.nvf = {
        enable = true;
        settings.vim = {
          startPlugins = with pkgs; [
            vimPlugins.minuet-ai-nvim
          ];

          clipboard = {
            enable = true;
            registers = "unnamedplus";
            providers.wl-copy.enable = true;
          };

          theme = {
            enable = true;
            name = "catppuccin";
            style = "mocha";
            transparent = true;
            extraConfig = ''
              -- Standard keywords
              vim.api.nvim_set_hl(0, "Keyword", { italic = true })
              vim.api.nvim_set_hl(0, "Conditional", { italic = true })
              vim.api.nvim_set_hl(0, "Repeat", { italic = true })

              -- Treesitter specific (covers Rust, C++, etc.)
              vim.api.nvim_set_hl(0, "@keyword", { italic = true })
              vim.api.nvim_set_hl(0, "@keyword.function", { italic = true })
              vim.api.nvim_set_hl(0, "@keyword.return", { italic = true })
            '';
          };

          lineNumberMode = "relNumber";

          viAlias = true;
          vimAlias = true;

          options.autoindent = true;
          options.expandtab = true;
          options.smartindent = false;
          options.shiftwidth = 4;
          options.tabstop = 4;
          options.signcolumn = "yes";

          globals.mapleader = " ";
          globals.maplocalleader = " ";

          treesitter = {
            enable = true;
            fold = false;
            indent.enable = false;
          };

          assistant = {
            codecompanion-nvim = {
              enable = true;
              setupOpts = {
                interactions = {
                  chat = {
                    adapter = "ollama";
                    model = "qwen2.5-coder:1.5b";
                  };
                };
              };
            };
          };

          lsp = {
            enable = true;
            inlayHints.enable = true;
            mappings = {
              renameSymbol = "<F2>";
              codeAction = "<C-.>";
              goToDefinition = "<leader>gd";
              goToDeclaration = "<leader>gD";
              toggleFormatOnSave = "<leader>ltf";
            };
          };
          autocomplete.blink-cmp = {
            enable = true;
            friendly-snippets.enable = true;
            mappings = {
              close = "<Esc>";
              complete = "<C-Space>";
              confirm = "<C-n>";

              scrollDocsDown = "<C-t>";
              scrollDocsUp = "<C-p>";
            };
            setupOpts = {
              keymap = {
                preset = "default";

                "<CR>" = [
                  "accept"
                  "fallback"
                ];

                "<Tab>" = [
                  "select_next"
                  "snippet_forward"
                  "fallback"
                ];
                "<S-Tab>" = [
                  "select_prev"
                  "snippet_backward"
                  "fallback"
                ];
              };

              completion.documentation.auto_show = true;
              completion.documentation.auto_show_delay_ms = 200;

              completion.menu.auto_show = true;
            };
          };
          snippets.luasnip = {
            enable = true;
          };

          debugger = {
            nvim-dap = {
              enable = true;
              ui.enable = true;
              ui.autoStart = true;

              mappings = {
                continue = "<F5>";
                terminate = "<F17>";
                restart = "<F6>";

                toggleBreakpoint = "<F9>";
                stepOver = "<F10>";
                stepInto = "<F11>";
                stepOut = "<S-F11>";
              };
            };
          };

          languages = {
            rust = {
              enable = true;
              lsp.enable = false;
              # dap.enable = true;
              # dap.debugger = [ "codelldb" ];

              format.enable = true;
              format.type = [ "rustfmt" ];
              treesitter.enable = true;

              extensions = {
                crates-nvim.enable = true;
                ferris-nvim = {
                  enable = true;
                  setupOpts = {
                    create_commands = true;
                  };
                };
                rustaceanvim.enable = true;
              };
            };

            odin = {
              enable = true;
              lsp.enable = true;
              dap.enable = true;
            };

            clang = {
              enable = true;
              format.enable = true;
              dap.enable = true;
              extraDiagnostics.enable = true;
            };

            python.enable = true;
            nix.enable = true;
          };

          formatter.conform-nvim = {
            enable = true;
          };

          telescope = {
            enable = true;
            extensions = [
              {
                name = "fzf";
                packages = [ pkgs.vimPlugins.telescope-fzf-native-nvim ];
                setup = {
                  fzf = {
                    fuzzy = true;
                  };
                };
              }
            ];
            mappings = {
              buffers = "<leader>fb";
              diagnostics = "<leader>fd";
              findFiles = "<leader>ff";

              gitBranches = "<leader>fvb";
              gitBufferCommits = "<leader>fvcb";
              gitCommits = "<leader>fvcm";

              liveGrep = "<leader>fs";
              lspDefinitions = "<leader>fD";
              lspDocumentSymbols = "<leader>fds";
              lspImplementations = "<leader>fI";
            };
          };

          autopairs.nvim-autopairs.enable = true;
          utility = {
            sleuth.enable = true;
            direnv.enable = true;

            oil-nvim.enable = true;
            oil-nvim.gitStatus.enable = true;
          };

          statusline.lualine.enable = true;
          tabline.nvimBufferline = {
            enable = true;
            mappings = {
              closeCurrent = "<leader>bq";
              sortByDirectory = "<leader>bs";
            };
          };
          filetree.neo-tree = {
            enable = true;
            setupOpts = {
              enable_cursor_hijack = true;
            };
          };

          projects.project-nvim.enable = true;
          ui = {
            noice.enable = true;
            borders.enable = true;
            borders.globalStyle = "rounded";
          };

          visuals = {
            nvim-web-devicons.enable = true;
            blink-indent.enable = true;
            fidget-nvim.enable = true;
          };

          keymaps = [
            {
              key = "<Esc>";
              mode = [ "n" ];
              action = "<cmd>noh<CR><Esc>";
              silent = true;
              desc = "Clear search highlights";
            }
            {
              key = "<leader>tt";
              mode = [ "n" ];
              action = "<cmd>Neotree toggle<CR>";
              silent = true;
              desc = "Neotree: Toggle";
            }
            {
              key = "<leader>fp";
              mode = [ "n" ];
              action = "<cmd>Telescope projects<CR>";
              silent = true;
              desc = "Telescope: projects";
            }
            {
              key = "<C-s>";
              mode = [ "n" ];
              action = "<cmd>w<CR>";
              silent = true;
              desc = "Save by Ctrl+s";
            }

            {
              key = "<C-1>";
              mode = [ "n" ];
              action = "<cmd>BufferLineCycleNext<CR>";
              silent = true;
              desc = "Buffer: CycleNext";
            }
            {
              key = "<C-2>";
              mode = [ "n" ];
              action = "<cmd>BufferLineCyclePrev<CR>";
              silent = true;
              desc = "Buffer: CyclePrev";
            }

            {
              key = "<leader>f";
              mode = [ "n" ];
              action = "<cmd>lua require('conform').format()<CR>";
              silent = true;
              desc = "Format File";
            }

            {
              key = "<C-w>,";
              mode = [ "n" ];
              action = "<cmd>vertical resize -5<CR>";
              silent = true;
              desc = "Resize vertical split -5";
            }
            {
              key = "<C-w>.";
              mode = [ "n" ];
              action = "<cmd>vertical resize +5<CR>";
              silent = true;
              desc = "Resize vertical split +5";
            }
            {
              key = "<C-w>+";
              mode = [ "n" ];
              action = "<cmd>resize +5<CR>";
              silent = true;
              desc = "Resize split +5";
            }
            {
              key = "<C-w>-";
              mode = [ "n" ];
              action = "<cmd>resize -5<CR>";
              silent = true;
              desc = "Resize split -5";
            }
          ];
        };
      };
    };
}
