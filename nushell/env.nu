use std "path add"

path add ($env.HOME | path join ".sdk" "node" "bin")

path add ($env.HOME | path join ".sdk" "dart" "bin")

path add ($env.HOME | path join ".sdk" "java" "bin")

path add ($env.HOME | path join ".cli" "bin")

path add ($env.HOME | path join ".cli" "bin" "fresh")

path add ($env.HOME | path join ".cli" "bin" "pandoc" "bin")

path add ($env.HOME | path join ".local" "bin")

zoxide init nushell | save -f ~/.zoxide.nu
