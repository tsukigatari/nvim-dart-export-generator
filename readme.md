# Dart Export Generator

This is a Neovim plugin that automatically generates dart export files.

## Installation

[Lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{ "tsukigatari/nvim-dart-export-generator" }
```

## Usage

Generate a default export file (by default, it's index.dart).

```vim
lua require("dart_export_generator").setup()
```

Generate a custom export file (you specify the filename).

```vim
lua require("dart_export_generator").setup("custom")
```

## License

This project is licensed under the [MIT License](https://opensource.org/licenses/MIT).
