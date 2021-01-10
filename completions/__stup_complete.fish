set -l times week month year previous-week previous-month previous-year
set -l commands show add edit copy log search add-category list-category set-category order-category rename-category usage version
set -l paged_commands log usage
set -l note_commands add
set -l dated_commands show add  edit
set -l ranged_commands copy log search
set -l name_cat_commands add-category rename-category
set -l desc_cat_commands add-category set-category
set -l cat_commands show add edit copy log search set-category rename-category

# disable file completions
complete -c stup -f

# subcommands listed in $commands
complete -c stup -n "not __fish_seen_subcommand_from $commands" -x -a "$commands"

# version and help
complete -c stup -s v -l version -d "Print current version"
complete -c stup -s h -l help

# @/at options
complete -c stup -n "__fish_seen_subcommand_from $dated_commands"  -s "@" -l at -d "Note timestamp"

# from/to options
complete -c stup -n "__fish_seen_subcommand_from $ranged_commands" -s f -l from
complete -c stup -n "__fish_seen_subcommand_from $ranged_commands" -s t -l to

complete -c stup -n "__fish_contains_opt -s @ at ; and __fish_seen_subcommand_from $dated_commands" -x -a "$times" 
complete -c stup -n "__fish_contains_opt -s f from ; or __fish_contains_opt -s t to ; and __fish_seen_subcommand_from $ranged_commands" -x -a "$times" 

# note options
complete -c stup -n "__fish_seen_subcommand_from $note_commands" -s n -l note

# add (no-)pager option for paged commands
complete -c stup -n "__fish_seen_subcommand_from $paged_commands" -l no-pager -d "Disable pager"
complete -c stup -n "__fish_seen_subcommand_from $paged_commands" -l pager -d "Use pager"

# store category directory and complete from the contained category file
cat "$HOME/.config/stup.conf" | read -d = -l _ category_dir
complete -c stup -n "__fish_seen_subcommand_from $cat_commands" -s c -l category -a "(cat $category_dir/categories.conf)"

complete -c stup -n "__fish_seen_subcommand_from $name_cat_commands" -l category-name
complete -c stup -n "__fish_seen_subcommand_from $desc_cat_commands" -l category-description
