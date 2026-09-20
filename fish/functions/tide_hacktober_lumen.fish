# Paint tide with the "Hacktober Lumen" palette — a rainbow prompt.
#
# Companion to ~/.config/ghostty/themes/Hacktober Lumen, which is Hacktober
# with its bright row replaced by genuinely light accents. Those accents are
# the point here: a rainbow prompt wants segment backgrounds light enough to
# carry near-black text, and stock Hacktober has none (its lightest non-white
# is #ebc587, and everything else sits too dark to read against). So where
# tide_hacktober ran most segments dark-on-dark, this runs them dark-on-light
# and walks the spectrum across the prompt.
#
# tide stores colors as universal variables, so this only has to run once —
# the values persist in fish/fish_variables. It lives here as a function so
# the palette is reproducible: `tide configure` resets colors to a stock
# scheme, so run `tide_hacktober_lumen` again afterwards.
#
# Hexes rather than ANSI names (yellow, brblack, ...) because names follow
# whatever palette the terminal has; these pin the prompt to the theme even
# under a different one, and reach the off-ANSI shades a 16-color name can't.

function tide_hacktober_lumen --description "Apply the Hacktober Lumen palette to the tide prompt"
    # The theme file's sixteen colors, verbatim. Names are what the color
    # reads as — ANSI slot numbers say nothing about how it looks.
    set -l ink '#191918' # 0   near-black, dark segment backgrounds
    set -l brick '#cf5b48' # 1
    set -l moss '#6b9150' # 2
    set -l amber '#e09a52' # 3
    set -l blue '#3a83d8' # 4
    set -l plum '#b06b78' # 5
    set -l tan '#c1a476' # 6
    set -l cream '#f1eee7' # 7
    set -l ash '#5a5754' # 8   warm grey, frame + inactive
    set -l coral '#f0846c' # 9   ┐
    set -l lime '#9ed37f' # 10  │
    set -l apricot '#f5b96f' # 11  ├ the light accents: every one of these
    set -l sky '#8fbdf0' # 12  │ clears 6.9:1 under $ink text
    set -l rose '#f4aebc' # 13  │
    set -l wheat '#f5dfa8' # 14  ┘
    set -l fg '#d2cfc8' #     terminal foreground

    # ---- left prompt: os  pwd  git  newline  character ----
    # Opens dark so the light segments that follow read as the arc's start.
    set -U tide_os_bg_color $ink
    set -U tide_os_color $wheat

    # Widest segment, so it takes apricot — the light amber, and the warmest
    # accent wide enough to carry the whole path.
    set -U tide_pwd_bg_color $apricot
    set -U tide_pwd_color_dirs $ink # 10.1:1
    set -U tide_pwd_color_anchors '#2a1b06' # 9.6:1, a shade deeper than dirs
    # Deliberately dim (4.4:1) so truncated parents recede; still legible,
    # where anything lighter stops reading as truncated at all.
    set -U tide_pwd_color_truncated_dirs '#6b4e1c'

    # The one segment that has to stay dark-on-light's opposite: tide
    # hardcodes `set_color white` for the branch name in
    # _tide_item_git.fish:64, ignoring tide_git_color_branch (which only
    # reaches the icon). So the background must carry white, and no light
    # accent can. These are moss / amber / brick with hue and saturation kept
    # and the value dropped — branch name lands at 7.6:1, 7.3:1 and 10.3:1,
    # and the state still reads as green / orange / red.
    set -U tide_git_bg_color '#3f5b33' # clean            (moss   #6b9150)
    set -U tide_git_bg_color_unstable '#7d4a14' # dirty or staged  (amber  #e09a52)
    set -U tide_git_bg_color_urgent '#7a2018' # conflict, rebase (brick  #cf5b48)
    # Wheat for the icon and the ⇣⇡ * ~ + ! ? counters: 5.6:1 or better on
    # all three, and distinct from the white of the branch name.
    for part in branch conflicted dirty operation staged stash untracked upstream
        set -U tide_git_color_$part $wheat
    end

    set -U tide_character_color $lime
    set -U tide_character_color_failure $coral

    # ---- right prompt ----
    # The core segments walk the spectrum right to left, so a full prompt
    # reads coral → apricot → lime → wheat → rose out to the clock.
    set -U tide_status_bg_color $ink
    set -U tide_status_color $lime
    set -U tide_status_bg_color_failure $coral # loud, and legible unlike a dark red
    set -U tide_status_color_failure $ink

    set -U tide_cmd_duration_bg_color $apricot
    set -U tide_cmd_duration_color $ink

    set -U tide_context_bg_color $ink
    set -U tide_context_color_default $tan
    set -U tide_context_color_root $coral
    set -U tide_context_color_ssh $wheat

    set -U tide_jobs_bg_color $ink
    set -U tide_jobs_color $lime

    set -U tide_direnv_bg_color $wheat
    set -U tide_direnv_color $ink
    set -U tide_direnv_bg_color_denied $coral
    set -U tide_direnv_color_denied $ink

    set -U tide_time_bg_color $rose
    set -U tide_time_color $ink

    # ---- language / tool segments ----
    # Each row is `item bg fg`, kept as one table so the whole set is visible
    # at a glance and stays balanced across the accents. Every background
    # here is a light accent (or amber / tan / moss, the three base colors
    # that also clear 4.5:1 under ink), so the languages read as one family.
    for row in \
        "bun $cream $ink" \
        "node $lime $ink" \
        "python $ink $sky" \
        "rustc $coral $ink" \
        "java $amber $ink" \
        "php $rose $ink" \
        "pulumi $wheat $ink" \
        "ruby $coral $ink" \
        "go $sky $ink" \
        "gcloud $sky $ink" \
        "kubectl $sky $ink" \
        "docker $sky $ink" \
        "distrobox $rose $ink" \
        "toolbox $rose $ink" \
        "terraform $plum $cream" \
        "aws $tan $ink" \
        "nix_shell $sky $ink" \
        "crystal $cream $ink" \
        "elixir $moss $ink" \
        "zig $apricot $ink"

        set -l cells (string split ' ' $row)
        set -U tide_$cells[1]_bg_color $cells[2]
        set -U tide_$cells[1]_color $cells[3]
    end

    # ---- vi mode, shell level, private mode ----
    set -U tide_vi_mode_bg_color_default $cream
    set -U tide_vi_mode_bg_color_insert $sky
    set -U tide_vi_mode_bg_color_replace $lime
    set -U tide_vi_mode_bg_color_visual $apricot
    for mode in default insert replace visual
        set -U tide_vi_mode_color_$mode $ink
    end

    set -U tide_shlvl_bg_color $apricot
    set -U tide_shlvl_color $ink
    set -U tide_private_mode_bg_color $cream
    set -U tide_private_mode_color $ink

    # ---- structure ----
    set -U tide_prompt_color_frame_and_connection $ash
    set -U tide_prompt_color_separator_same_color $ash
end
