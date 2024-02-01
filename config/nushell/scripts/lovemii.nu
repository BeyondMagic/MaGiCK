#!/usr/bin/env nu
#
# João Farias © BeyondMagic <beyondmagic@mail.ru> 2021-2024

use std log
use environment.nu

# Kill all processes of the user launching the process.
export def clear [] -> int {
	pkill -U (whoami)
}

# Execute the compositor.
export def --env main [] -> int {
	log debug "Hyprland is being started."
	Hyprland
}
