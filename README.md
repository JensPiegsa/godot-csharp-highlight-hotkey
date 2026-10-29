# Godot C# Highlight Hotkey

A small Godot 4 editor plugin that adds the shortcut **Ctrl+Alt+H** to the built-in script editor.

Godot often opens C# files as plain text, without syntax highlighting. Switching manually means going through
*Edit > Syntax Highlighter > Standard* for every file. This plugin does exactly that with one key press for the
current tab. Godot remembers the choice per file afterwards.

## How it works

The plugin does not create or replace a highlighter itself. It only triggers Godot's own menu entry
*Syntax Highlighter > Standard*. Since Godot fills that submenu lazily when it opens, the plugin asks it to fill
itself first.

## Installation

1. Copy the folder `addons/highlight_hotkey` into the `addons` folder of your Godot project.
2. Enable the plugin under *Project > Project Settings > Plugins*.

## Usage

Open a C# file in the built-in script editor, click into the text and press **Ctrl+Alt+H**.

## Limitations

- Tested with Godot 4.7.2 (.NET).
- The menu entries are recognized by their text. Currently supported: English and German editor language.
- The plugin relies on the internal menu structure of the script editor and may need an update after Godot releases.

## License

MIT, see [LICENSE](LICENSE).