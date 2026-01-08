
#!/bin/bash

# Rofi theme
rofi_theme="$HOME/.config/rofi/config.rasi" # Make sure this path is correct for your system
msg='** Neovim Keybinds ** nvim 🚀 Search or press Enter to copy'

# Check if rofi is already running
if pidof rofi > /dev/null; then
  pkill rofi
fi

# Format & show via rofi
# The sed command removes everything before the '# # NVIM_KEYBINDS # #' marker.
# It then pipes the hardcoded keybinds to rofi.
sed '1,/^# # NVIM_KEYBINDS # #$/d' "$0" | \
rofi -i -dmenu -mesg "$msg" -config "$rofi_theme" | \
awk '{print $1}' | \
xclip -selection clipboard

exit

# # NVIM_KEYBINDS # #
⌨️ General
Control+h/j/k/l             : Navigate windows (Normal Mode)
Control+b                   : Move to beginning of line (Insert Mode)
Control+e                   : Move to end of line (Insert Mode)
Control+h/j/k/l             : Move around (Insert Mode)
Space                       : Disable space (Normal Mode)
ALT+j/k                     : Move line up/down (Normal/Insert/Visual Mode)
jk                          : Exit Insert Mode (Insert Mode)
Control+s                   : Save File (Normal/Insert Mode)
Escape                      : Clear highlights (Normal Mode)
< />                       : Indent/Unindent Selection (Visual Mode)

💻 Window Management
Space+-                     : Split Window Below
Space+\                     : Split Window Right
Space+q                     : Close Window
Space++h/-h                 : Increase/Decrease Window Height
Space++w/-w                 : Increase/Decrease Window Width

📁 File & Buffer Management
Space+fn                    : New File
Space+qa                    : Quit All
Shift+h                     : Previous Buffer
Shift+l                     : Next Buffer
Space+bp                    : Toggle Pin Buffer
Space+bo                    : Close Non-Pinned Buffers
Space+bc                    : Close Buffers to the Right

🌳 Neo Tree
Space+e                     : Toggle File Explorer
Space+br                    : Buffer Explorer

🔎 Telescope
Space+ff                    : Find Files
Space+fg                    : Live Grep
Space+fb                    : Find Buffers
Space+fo                    : Find Old Files
Space+fz                    : Fuzzy Find in Current Buffer
Space+fh                    : Find Help Tags
Space+ft                    : Find string under cursor

🛠️ LSP
Space+ld                    : LSP Definition
Space+lr                    : LSP References
Space+la                    : LSP Code Action
Space+ln                    : LSP Rename
Space+ls                    : LSP Document Symbols
Space+lws                   : LSP Workspace Symbols
K                           : LSP Hover

✅ Todo
Space+I                     : Todo Telescope

💻 Terminal
Space+t                     : Toggle Terminal
Esc+Esc                     : Exit ToggleTerm (Terminal Mode)

🚀 Flutter Tools
Space+Ff                    : Flutter Run
Space+Fq                    : Flutter Quit
Space+Fr                    : Flutter Hot Reload
Space+FR                    : Flutter Hot Restart
Space+Fd                    : Flutter Devices

❓ WhichKey
Space+?                     : Buffer Local Keymaps
Space+wk                    : All Global Keymaps

