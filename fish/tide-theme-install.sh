#!/bin/sh
# Tide prompt theme installer
#
# Snapshot of the tide configuration on this machine, captured 2026-09-20.
# Tide stores its settings as fish universal variables, so this script hands
# the whole set to fish in one go rather than setting anything itself.
#
# Usage:  sh tide-theme-install.sh
#
# Requires: fish, and tide already installed (fisher install IlanCosman/tide@v6).
# Overwrites any existing tide_* universal variables.

set -e

if ! command -v fish >/dev/null 2>&1; then
	echo "tide-theme-install: fish is not installed or not on PATH" >&2
	exit 1
fi

fish <<'FISH_EOF'
if not functions -q tide
    echo "tide-theme-install: tide is not installed" >&2
    echo "  install it with: fisher install IlanCosman/tide@v6" >&2
    exit 1
end

    set -U tide_aws_bg_color '#c1a476'
    set -U tide_aws_color '#191918'
    set -U tide_aws_icon 
    set -U tide_bun_bg_color '#f1eee7'
    set -U tide_bun_color '#191918'
    set -U tide_bun_icon 󰳓
    set -U tide_character_color '#9ed37f'
    set -U tide_character_color_failure '#f0846c'
    set -U tide_character_icon ❯
    set -U tide_character_vi_icon_default ❮
    set -U tide_character_vi_icon_replace ▶
    set -U tide_character_vi_icon_visual V
    set -U tide_cmd_duration_bg_color '#f5b96f'
    set -U tide_cmd_duration_color '#191918'
    set -U tide_cmd_duration_decimals 0
    set -U tide_cmd_duration_icon 
    set -U tide_cmd_duration_threshold 3000
    set -U tide_context_always_display false
    set -U tide_context_bg_color '#191918'
    set -U tide_context_color_default '#c1a476'
    set -U tide_context_color_root '#f0846c'
    set -U tide_context_color_ssh '#f5dfa8'
    set -U tide_context_hostname_parts 1
    set -U tide_crystal_bg_color '#f1eee7'
    set -U tide_crystal_color '#191918'
    set -U tide_crystal_icon 
    set -U tide_direnv_bg_color '#f5dfa8'
    set -U tide_direnv_bg_color_denied '#f0846c'
    set -U tide_direnv_color '#191918'
    set -U tide_direnv_color_denied '#191918'
    set -U tide_direnv_icon ▼
    set -U tide_distrobox_bg_color '#f4aebc'
    set -U tide_distrobox_color '#191918'
    set -U tide_distrobox_icon 󰆧
    set -U tide_docker_bg_color '#8fbdf0'
    set -U tide_docker_color '#191918'
    set -U tide_docker_default_contexts default colima
    set -U tide_docker_icon 
    set -U tide_elixir_bg_color '#6b9150'
    set -U tide_elixir_color '#191918'
    set -U tide_elixir_icon 
    set -U tide_gcloud_bg_color '#8fbdf0'
    set -U tide_gcloud_color '#191918'
    set -U tide_gcloud_icon 󰊭
    set -U tide_git_bg_color '#3f5b33'
    set -U tide_git_bg_color_unstable '#7d4a14'
    set -U tide_git_bg_color_urgent '#7a2018'
    set -U tide_git_color_branch '#f5dfa8'
    set -U tide_git_color_conflicted '#f5dfa8'
    set -U tide_git_color_dirty '#f5dfa8'
    set -U tide_git_color_operation '#f5dfa8'
    set -U tide_git_color_staged '#f5dfa8'
    set -U tide_git_color_stash '#f5dfa8'
    set -U tide_git_color_untracked '#f5dfa8'
    set -U tide_git_color_upstream '#f5dfa8'
    set -U tide_git_icon 
    set -U tide_git_truncation_length 24
    set -U tide_git_truncation_strategy
    set -U tide_go_bg_color '#8fbdf0'
    set -U tide_go_color '#191918'
    set -U tide_go_icon 
    set -U tide_java_bg_color '#e09a52'
    set -U tide_java_color '#191918'
    set -U tide_java_icon 
    set -U tide_jobs_bg_color '#191918'
    set -U tide_jobs_color '#9ed37f'
    set -U tide_jobs_icon 
    set -U tide_jobs_number_threshold 1000
    set -U tide_kubectl_bg_color '#8fbdf0'
    set -U tide_kubectl_color '#191918'
    set -U tide_kubectl_icon 󱃾
    set -U tide_left_prompt_frame_enabled true
    set -U tide_left_prompt_items os pwd git newline character
    set -U tide_left_prompt_prefix 
    set -U tide_left_prompt_separator_diff_color 
    set -U tide_left_prompt_separator_same_color 
    set -U tide_left_prompt_suffix 
    set -U tide_nix_shell_bg_color '#8fbdf0'
    set -U tide_nix_shell_color '#191918'
    set -U tide_nix_shell_icon 
    set -U tide_node_bg_color '#9ed37f'
    set -U tide_node_color '#191918'
    set -U tide_node_icon 
    set -U tide_os_bg_color '#191918'
    set -U tide_os_color '#f5dfa8'
    set -U tide_os_icon 
    set -U tide_php_bg_color '#f4aebc'
    set -U tide_php_color '#191918'
    set -U tide_php_icon 
    set -U tide_private_mode_bg_color '#f1eee7'
    set -U tide_private_mode_color '#191918'
    set -U tide_private_mode_icon 󰗹
    set -U tide_prompt_add_newline_before true
    set -U tide_prompt_color_frame_and_connection '#5a5754'
    set -U tide_prompt_color_separator_same_color '#5a5754'
    set -U tide_prompt_icon_connection ' '
    set -U tide_prompt_min_cols 34
    set -U tide_prompt_pad_items true
    set -U tide_prompt_transient_enabled true
    set -U tide_pulumi_bg_color '#f5dfa8'
    set -U tide_pulumi_color '#191918'
    set -U tide_pulumi_icon 
    set -U tide_pwd_bg_color '#f5b96f'
    set -U tide_pwd_color_anchors '#2a1b06'
    set -U tide_pwd_color_dirs '#191918'
    set -U tide_pwd_color_truncated_dirs '#6b4e1c'
    set -U tide_pwd_icon 
    set -U tide_pwd_icon_home 
    set -U tide_pwd_icon_unwritable 
    set -U tide_pwd_markers .bzr .citc .git .hg .node-version .python-version .ruby-version .shorten_folder_marker .svn .terraform bun.lockb Cargo.toml composer.json CVS go.mod package.json build.zig
    set -U tide_python_bg_color '#191918'
    set -U tide_python_color '#8fbdf0'
    set -U tide_python_icon 󰌠
    set -U tide_right_prompt_frame_enabled false
    set -U tide_right_prompt_items status cmd_duration context jobs direnv bun node python rustc java php pulumi ruby go gcloud kubectl distrobox toolbox terraform aws nix_shell crystal elixir zig time
    set -U tide_right_prompt_prefix 
    set -U tide_right_prompt_separator_diff_color 
    set -U tide_right_prompt_separator_same_color 
    set -U tide_right_prompt_suffix 
    set -U tide_ruby_bg_color '#f0846c'
    set -U tide_ruby_color '#191918'
    set -U tide_ruby_icon 
    set -U tide_rustc_bg_color '#f0846c'
    set -U tide_rustc_color '#191918'
    set -U tide_rustc_icon 
    set -U tide_shlvl_bg_color '#f5b96f'
    set -U tide_shlvl_color '#191918'
    set -U tide_shlvl_icon 
    set -U tide_shlvl_threshold 1
    set -U tide_status_bg_color '#191918'
    set -U tide_status_bg_color_failure '#f0846c'
    set -U tide_status_color '#9ed37f'
    set -U tide_status_color_failure '#191918'
    set -U tide_status_icon ✔
    set -U tide_status_icon_failure ✘
    set -U tide_terraform_bg_color '#b06b78'
    set -U tide_terraform_color '#f1eee7'
    set -U tide_terraform_icon 󱁢
    set -U tide_time_bg_color '#c1a476'
    set -U tide_time_color '#191918'
    set -U tide_time_format '%r'
    set -U tide_toolbox_bg_color '#f4aebc'
    set -U tide_toolbox_color '#191918'
    set -U tide_toolbox_icon 
    set -U tide_vi_mode_bg_color_default '#f1eee7'
    set -U tide_vi_mode_bg_color_insert '#8fbdf0'
    set -U tide_vi_mode_bg_color_replace '#9ed37f'
    set -U tide_vi_mode_bg_color_visual '#f5b96f'
    set -U tide_vi_mode_color_default '#191918'
    set -U tide_vi_mode_color_insert '#191918'
    set -U tide_vi_mode_color_replace '#191918'
    set -U tide_vi_mode_color_visual '#191918'
    set -U tide_vi_mode_icon_default D
    set -U tide_vi_mode_icon_insert I
    set -U tide_vi_mode_icon_replace R
    set -U tide_vi_mode_icon_visual V
    set -U tide_zig_bg_color '#f5b96f'
    set -U tide_zig_color '#191918'
    set -U tide_zig_icon 

tide reload
echo "tide-theme-install: theme applied ("(set -nU | string match 'tide_*' | count)" variables)"
FISH_EOF
