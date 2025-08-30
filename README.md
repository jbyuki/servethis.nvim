# servethis.nvim

Use Neovim as an HTTP server.

## Install

Install using your prefered method.

<details>
  <summary>Using <a href="https://github.com/junegunn/vim-plug">vim-plug</a></summary>

  ```vim
  Plug 'jbyuki/servethis.nvim'
  ```
</details>

<details>
  <summary>Using <a href="https://github.com/folke/lazy.nvim">lazy.nvim</a></summary>

  ```lua
  {
    "jbyuki/servethis.nvim",
  }
  ```
</details>


## Quickstart

Open an .html page and execute

  ```
  :ServeThis
  ```

The page is now served on `http://localhost:8093`.
