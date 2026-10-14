if status is-interactive
    set fish_greeting
    if type -q starship
        starship init fish | source
    end
    if test "$TERM" = "xterm-kitty"; and type -q fastfetch
        fastfetch
    end
end
