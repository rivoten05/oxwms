def --env y [...args] {
	let tmp = (mktemp -t "yazi-cwd.XXXXXX")
	yazi ...$args --cwd-file $tmp
	let cwd = (open $tmp)
	if $cwd != "" and $cwd != $env.PWD {
		cd $cwd
	}
	rm -fp $tmp
}

# Navigation
alias e = exit
alias . = cd ..
alias .. = cd ../.. 
alias ... = cd ../../..
alias p = pwd

#Editor
alias v = nvim
alias vi = nvim

# Git (Enhanced)
alias gc = git commit -m
alias gp = git push
alias ga = git add .
alias gpl = git pull
alias gs = git status
alias gss = gss  # Use our custom git status
alias gcl = git clone
alias gr = git restore
alias gi = git init
alias gd = git diff 
alias gco = git checkout
alias gb = git branch
alias gl = git log --oneline --graph --all

# Misc Utilities
alias hist = history
alias cls = clear
alias c = clear
alias time = timeit 

# File Operations
alias l = lsd --color always --icon always
alias ll = lsd -l --color always --icon always
alias la = lsd -a --color always --icon always
alias lla = lsd -la --color always --icon always
alias lt = lsd --tree --color always --icon always
alias cat = bat
alias rm-safe = rm -I

# Network
alias ip = ip -c a  # Colorized output
alias ping = ping -c 5
alias wget = wget -c  # Continue interrupted downloads


# Environment variables
$env.EDITOR = "nvim"
$env.VISUAL = "nvim"
$env.BAT_THEME = "gruvbox-light"
$env.MANPAGER = "sh -c 'col -bx | bat -l man -p'"
$env.config.buffer_editor = "nvim"
$env.config.show_banner = false

$env.FZF_DEFAULT_OPTS = "--ansi --preview-window 'right:60%' --preview 'bat --color=always --style=header,grid --line-range :300 {}' --color=fg:#3c3836,bg:#fbf1c7,hl:#9d0006 --color=fg+:#3c3836,bg+:#ebdbb2,hl+:#9d0006 --color=info:#af3a03,prompt:#458588,pointer:#af3a03 --color=marker:#af3a03,spinner:#af3a03,header:#458588"

# Quick directory listing with icons (simplified)
def lsg [] {
    ls | each {|file|
        let extension = ($file.name | path parse | get extension)
        let icon = match $extension {
            "nu" => "🐚",
            "rs" => "🦀", 
            "py" => "🐍",
            "js" => "📜",
            "ts" => "📘",
            "md" => "📝",
            "txt" => "📄",
            "zip" => "📦",
            "pdf" => "📕",
            _ => { if $file.type == "dir" { "📁" } else { "📄" } }
        }
        $"($icon) ($file.name)"
    }
}

# Enhanced git status with formatting
def gss [] {
    git status -s | lines | each {|line|
        let parts = ($line | split row ' ')
        let status = $parts.0
        let file = $parts.1
        match $status {
            "M" => { $"[(ansi green)modified(ansi reset)] ($file)" }
            "A" => { $"[(ansi yellow)added(ansi reset)] ($file)" }
            "D" => { $"[(ansi red)deleted(ansi reset)] ($file)" }
            "??" => { $"[(ansi blue)untracked(ansi reset)] ($file)" }
            _ => $line
        }
    }
}


# Quick directory navigation
def q [dir: string] {
    let target = match $dir {
        "d" => "~/Downloads",
        "c" => "~/.config",
        "p" => "~/Projects",
        "doc" => "~/Documents",
        _ => $dir
    }
    cd $target
}
#-----------------------------------------*******nvim******------------------------
def nvims [...args] {
  let items = ["rio", "kickstart", "LazyVim", "NvChad", "AstroNvim"]
  let config = ($items | to text | fzf --prompt=" Neovim Config  " --height=50% --layout=reverse --border --exit-0)

  if ($config == null or $config == "") {
    print "Nothing selected"
    return
  }

  let appname = if $config == "rio" { "" } else { $config }

  with-env { NVIM_APPNAME: $appname } {
    nvim ...$args
  }
}

# Create vendor directory if it doesn't exist
mkdir ($nu.data-dir | path join "vendor/autoload")

starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

source ~/.zoxide.nu


source $"($nu.home-path)/.cargo/env.nu"
