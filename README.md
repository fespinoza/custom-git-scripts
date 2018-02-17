# Custom Git Scripts

A collection of custom git commands to speed up my git workflow. This add some
extra useful git commands.

## Installation

First download the repo

```
git clone https://github.com/fespinoza/custom-git-scripts
```

Then make sure you add the directory to your `$PATH` in the terminal, for
example for zsh, adding to the `.zshrc`

```
export PATH="<YOUR_CLONED_DIRECTORY>/bin:$PATH"
```

## Usage

The commands added are:

- `git alias`: adds a new global alias

	Example: `git alias cdbrm 'clean-development-branches master'`

- `git changelog-from-parent`: returns a formatted list of commits of changes
	not present in the parent branch

- `git clean-development-branches`: given a base branch, it will remove all the
	branches that were merged to the base branch. Useful to clean all the branches
	of merged pull requests.

	Example: `git clean-development-branches master`

- `git not-released`: given a `base-ref` and a `current-ref` returns a formatted
	list of pull request merged into `current-ref` that are not present in
	`base-ref`. Useful to list all the pull request merged since a tag, etc.

	Example: `git not-released builds/beta/81 master`

- `git open-in-github`: opens the origin repository in the browser for the
  public github or the enterprise version.

## Aliases

The new git commands are supposed to be descriptive, now for convenience you
can add some aliases, (with the `git alias` command for example). This are some
that i recommend:

```bash
git cdbrm # clean development branches from master
git cl    # change list from parent branch
git clp	  # change list from parent branch and copy it to clipboard
git nr	  # not released changes
```

A full list of my personal aliases can be found in [my dotfiles][dotfiles-git]

[dotfiles-git]: https://github.com/fespinoza/dotfiles/blob/master/gitconfig#L7
