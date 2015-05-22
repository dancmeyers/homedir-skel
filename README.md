# homedir-skel
Basic configuration files for a skeleton home directory

## .bash_custom
Custom configuration for the bash prompt. Sets up the editor and a few aliases, but primarily builds the prompt, who's syntax is `<username>@<host> <working directory>[:<git prompt>]`, followed by a newline and either '$' for a normal user or '#' for UID 0.

The `<username>@<host>` section displays in green on a user's personal machine. On a shared machine (identified by the presence of a '.shared' file in the user's home directory), the prompt displays in cyan instead. If the current user is UID 0, the prompt *always* displays in red.

The `:<git prompt>` section only appears if you are currently in a git repository. By default, it displays the current branch name. If the current branch is master, it appears in bright yellow. Other branches appear in blue. If the branch is 'dirty', it *always* appears in red. Further to that, there are a number of flags and counters that can appear at the end of the prompt, separated by pipes ('|'):
* `↑<num>` - Local branch is ahead of origin by num commits (based on most recent fetch of origin)
* `↓<num>` - Local branch is behind origin by num commits (based on most recent fetch of origin)
* `↑<num1>↓<num2>` - Local branch has diverged from origin. num1 local commits and num2 commits on origin since last converged commit (based on the most recent fetch of origin. Nothing in here auto-fetches origin)
* `•<num>` - num files have been added (and staged), deleted or modified, but not committed yet, Basically, files that will be submitted on a 'commit -a'
* `+<num>` - num files have been added to the filesystem within the repository tree, but not staged for commit as of yet
* `⚑<num>` - There are num entries on the local git stash stack

Should never contain any passwords or similar. Put those in .bash_secret, which should never be added to this repository but will be sourced from .bash_custom.

## .gitignore
Ignores *all* home directory files by default. Any new files to be added to the skeleton repository must be added to here as a negation of the main match glob first. This is in case you want to check out the repository directly into your home directory, however the recommended setup is to checkout somewhere else and provide symlinks from your home directory to each of the files in this repository (except .gitignore and README.md).

## .screenrc
Screen configuration file. Among other things, sets a hard status line along the bottom of the terminal and changes the default Ctrl-a syntax for performing other screen commands to Ctrl-o, as there are a number of programs which you might want to run within screen which use Ctrl-a.

## .vimrc
Standard vim configuration file.

## git-completion.bash
Taken from the git source code, provides tab-completion of local and remote repository names, git subcommands and the like.
