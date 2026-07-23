if [ "x$OH_MY_ZSH_HG" = "x" ]; then
    OH_MY_ZSH_HG="hg"
fi

function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

function hg_prompt_info {
    $OH_MY_ZSH_HG prompt --angle-brackets "\
< on %{$fg[magenta]%}<branch>%{$reset_color%}>\
< at %{$fg[yellow]%}<tags|%{$reset_color%}, %{$fg[yellow]%}>%{$reset_color%}>\
%{$fg[green]%}<status|modified|unknown><update>%{$reset_color%}<
patches: <patches|join( → )|pre_applied(%{$fg[yellow]%})|post_applied(%{$reset_color%})|pre_unapplied(%{$fg_bold[black]%})|post_unapplied(%{$reset_color%})>>" 2>/dev/null
}

function box_name {
    [ -f ~/.box-name ] && cat ~/.box-name || hostname -s
}

function prompt_char {
    git branch >/dev/null 2>/dev/null && echo '±' && return
    hg root >/dev/null 2>/dev/null && echo '☿' && return
}

PROMPT='%{$fg[magenta]%}%n%{$reset_color%} at %{$fg[yellow]%}$(box_name)%{$reset_color%} in %{$fg_bold[green]%}${PWD/#$HOME/~}%{$reset_color%}$(git_prompt_info)
$(virtualenv_info)%(?,,%{${fg_bold[white]}%}[%?]%{$reset_color%} )$ '

ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""

#local return_status="%{$fg[red]%}%(?..✘)%{$reset_color%}"
#RPROMPT='${return_status}%{$reset_color%}'

function settitle() {
    # based on: https://raw.github.com/mflint/screen-preexec/master/screen-preexec.sh

    # commandstring starts as the whole string, but we
    # chop it up...
    commandstring=$1;

    # start by stripping all the switches which start with
    # a hyphen
    commandstring=`echo $commandstring | sed -e 's/\( -[^ ]*\)//g'`;

    # find the first word in the commandstring, which is the
    # command being executed
    command=`echo $commandstring | cut -d ' ' -f1`;

    # strip any other unwanted stuff from the start of the command.
    # These generally modify the behaviour or environment of another
    # command
    removedcommand="no";
    until [[ $removedcommand = "" ]]; do
        removedcommand="";
        case "$command" in
            watch|nice|nohup|time|trickle)
                removedcommand="yes";
                commandstring=`echo $commandstring | cut -d ' ' -f2- 2>/dev/null`;
                command=`echo $commandstring | cut -d ' ' -f1 2>/dev/null`;
            ;;
        esac
    done

    # remove multiple spaces
    command=`echo $command | sed -e 's/[ ]\+/ /g'`

    # now check for a set of predefined long-running
    # commands which operate on a file. Instead of showing
    # the command name, we'll show the filename surrounded
    # by braces.

    # I'd rather see
    #   "{file 1}" "{file 2}" "{file 3}"
    # than
    #   "vi" "vi" "vi"
    case "$command" in
        vi|vim|vimdiff|view|less|more|tail|head|man|zsh|ssh)
            # remove the command name (vi, less, etc) from the string. This
            # should just leave any filenames, plus pipes and redirects. We append
            # " " to the commandstring to make sure that there's at least one
            # field delimiter, othewise "cut" won't chop off the command
            filepathsandpipes=`echo $commandstring " " | cut -d ' ' -f2-`;

            # now remove any pipes or redirects
            filepaths=`echo $filepathsandpipes | sed -e 's/[|>].*//g'` ;

            # remove multiple spaces
            filepaths=`echo $filepaths | sed -e 's/[ ]\+/ /g'`

            # how many filepaths?
            filenamecount=`echo $filepaths | awk '{ print NF }'`;
            if [[ $filenamecount -eq 0 ]]; then
                # no filenames - just show the command
                result=$command;
            elif [[ $filenamecount -eq 1 ]]; then
                # one filename - show it
                filename=`basename $filepaths`;
                result=$filename;
            else
                # more than one filename
                basenames=""

                for filepath in $filepaths
                do
                    basename=`basename $filepath`
                    basenames="$basenames $basename"
                done

                # remove multiple spaces
                basenames=`echo $basenames | sed -e 's/[ ]\+/ /g'`

                result="$command $basenames";
            fi
            ;;
        *)
            # just show the basename of the command
            [[ $removedcommand = "no" ]] && command=`basename $command`;
            result=$command;
            ;;
    esac

    title $result
}

#add-zsh-hook preexec settitle
preexec_functions+=(settitle)

eval `dircolors ~/.dircolors.ansi-dark`
