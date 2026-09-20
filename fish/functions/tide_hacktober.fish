# Paint tide with ghostty's "Hacktober" palette.
#
# tide stores its colors as universal variables, so this only has to run once
# — the values persist in fish/fish_variables. It lives here as a function so
# the palette is reproducible: after a `tide configure` (which resets colors to
# a stock scheme) just run `tide_hacktober` again.
#
# Counterpart to nvim's lua/config/hacktober.lua, which maps the same palette
# onto the editor. ghostty's `theme = "Hacktober"` drives that one directly.
#
# Out of the box tide used ANSI names (yellow, brblack, ...), which follow
# whatever palette the terminal has. These hexes pin the prompt to Hacktober
# regardless of terminal theme — that's the trade-off for getting the palette's
# off-ANSI shades (rose, wheat, tan) that a 16-color name can't reach.

function tide_hacktober --description "Apply the Hacktober palette to the tide prompt"
    # ghostty's Hacktober palette, verbatim. Names are what the color reads
    # as, since the ANSI slot numbers say nothing about how it looks.
    set -l ink '#191918' # 0   near-black, segment backgrounds
    set -l brick '#b34538' # 1
    set -l moss '#587744' # 2
    set -l amber '#d08949' # 3
    set -l blue '#206ec5' # 4
    set -l plum '#864651' # 5
    set -l tan '#ac9166' # 6
    set -l cream '#f1eee7' # 7
    set -l ash '#464444' # 8   warm grey, frame + inactive
    set -l red '#b33323' # 9
    set -l green '#42824a' # 10
    set -l rust '#c75a22' # 11
    set -l sky '#5389c5' # 12
    set -l rose '#e795a5' # 13
    set -l wheat '#ebc587' # 14
    set -l fg '#c9c9c9' #     terminal foreground

    # Dark text on a light segment, light text on a dark one. Each pairing
    # below clears 4.5:1 so the prompt stays readable at small font sizes.

    # ---- left prompt: os  pwd  git  newline  character ----
    set -U tide_os_bg_color $ash
    set -U tide_os_color $wheat

    # The widest segment, so it gets the palette's tan: warm, but light
    # enough to carry near-black text.
    set -U tide_pwd_bg_color $tan
    set -U tide_pwd_color_dirs $ink
    set -U tide_pwd_color_anchors '#141414'
    # Dimmer than the full dirs above (4.2:1 against the tan, vs 6.8:1), but
    # still readable — #6b5a3e, the obvious pick, came out at 2.2:1.
    set -U tide_pwd_color_truncated_dirs '#3d3120'

    # The one segment that runs light-on-dark, because tide hardcodes
    # `set_color white` for the branch name in _tide_item_git.fish:64 — it
    # ignores tide_git_color_branch, which only reaches the icon. So the
    # background has to carry that white, and the palette's own moss/rust/red
    # are too light for it (rust leaves it at 3.7:1).
    #
    # These three are moss, rust and red with the hue and saturation kept and
    # only the value dropped, the same way lua/config/hacktober.lua derives
    # the greys a terminal palette doesn't carry. Branch name lands at
    # 7.3:1 / 7.5:1 / 8.9:1, and the state still reads as green/orange/red.
    set -U tide_git_bg_color '#3b5430' # clean            (moss  #587744)
    set -U tide_git_bg_color_unstable '#7d3614' # dirty or staged  (rust  #c75a22)
    set -U tide_git_bg_color_urgent '#7a2018' # conflict, rebase (red   #b33323)
    # Wheat for the icon and the ⇣⇡ * ~ + ! ? counters: 5.2:1 or better on all
    # three backgrounds, and distinct from the white of the branch name.
    for part in branch conflicted dirty operation staged stash untracked upstream
        set -U tide_git_color_$part $wheat
    end

    set -U tide_character_color $green
    set -U tide_character_color_failure $rust

    # ---- right prompt ----
    set -U tide_status_bg_color $ink
    set -U tide_status_color $green
    set -U tide_status_bg_color_failure $red
    set -U tide_status_color_failure $cream

    set -U tide_cmd_duration_bg_color $amber
    set -U tide_cmd_duration_color $ink

    set -U tide_context_bg_color $ink
    set -U tide_context_color_default $tan
    set -U tide_context_color_root $rust
    set -U tide_context_color_ssh $wheat

    set -U tide_jobs_bg_color $ink
    set -U tide_jobs_color $green

    set -U tide_direnv_bg_color $wheat
    set -U tide_direnv_color $ink
    set -U tide_direnv_bg_color_denied $red
    set -U tide_direnv_color_denied $cream

    set -U tide_time_bg_color $ash
    set -U tide_time_color $fg

    # ---- language / tool segments ----
    # Each is `item bg fg`, kept as one table so the whole set is visible at
    # a glance and stays balanced across the palette.
    for row in \
        "bun $cream $ink" \
        "node $green $ink" \
        "python $ink $wheat" \
        "rustc $rust $ink" \
        "java $brick $cream" \
        "php $plum $cream" \
        "pulumi $wheat $ink" \
        "ruby $red $cream" \
        "go $sky $ink" \
        "gcloud $blue $cream" \
        "kubectl $blue $cream" \
        "docker $sky $ink" \
        "distrobox $rose $ink" \
        "toolbox $plum $cream" \
        "terraform $plum $cream" \
        "aws $amber $ink" \
        "nix_shell $sky $ink" \
        "crystal $cream $ink" \
        "elixir $moss $cream" \
        "zig $amber $ink"

        set -l cells (string split ' ' $row)
        set -U tide_$cells[1]_bg_color $cells[2]
        set -U tide_$cells[1]_color $cells[3]
    end

    # ---- vi mode, shell level, private mode ----
    set -U tide_vi_mode_bg_color_default $cream
    set -U tide_vi_mode_bg_color_insert $sky
    set -U tide_vi_mode_bg_color_replace $green
    set -U tide_vi_mode_bg_color_visual $amber
    for mode in default insert replace visual
        set -U tide_vi_mode_color_$mode $ink
    end

    set -U tide_shlvl_bg_color $amber
    set -U tide_shlvl_color $ink
    set -U tide_private_mode_bg_color $cream
    set -U tide_private_mode_color $ink

    # ---- structure ----
    set -U tide_prompt_color_frame_and_connection $ash
    set -U tide_prompt_color_separator_same_color $ash
end
