# dotfiles

## Installation (Mac/Linux)

```
$ ./install.pl
```

## Installation (Windows)

```
$ cd windows
$ .\install.ps1
```

## Making Your Own Dotfiles

First, make a copy of my repo but remove the history and make it your own:

```
$ cd ~
$ git clone --depth 1 https://github.com/wavebeem/dotfiles.git
$ cd dotfiles
$ rm -rf .git
```

This is a great point to delete any files you don't want (e.g. `tmux.conf` if
you never use tmux).

```
$ git init
$ git add -A
$ git commit -m "Initial commit"
```

Then create a new repo on GitHub and follow the instructions for pushing an
existing Git repo to GitHub.

If you based your dotfiles on mine, please consider putting a link to my
dotfiles repo in your README :)

Now copy over files you'd like to keep, like:

```sh
# Copy zsh config
$ cp ~/.zshrc zshrc

# Copy bash config
$ cp ~/.bashrc bashrc

# Copy VS Code settings, keybindings, and snippets
$ cp ~/Library/Application\ Support/Code/User/settings.json vscode/settings.json
$ cp ~/Library/Application\ Support/Code/User/keybindings.json vscode/keybindings.json
$ rm -rf vscode/snippets && cp -r ~/Library/Application\ Support/Code/User/snippsets vscode/snippets
```

Note the dot in front of `zshrc` is missing on the second instance.

Edit the `Main` function in `install.sh` to install only the files you actually
have.

When you've copied over all the dotfiles from your home directory into your own
dotfiles repo, run the following commands:

```
$ git add -A
$ git commit -m "Customized dotfiles"
$ ./install.sh
```

You will be prompted to delete files that already exist. Say yes (`y`) to each
one. Now that file will be replaced with a symbolic link (symlink) to the file
inside your dotfiles repo.

From now on, you should periodically open your dotfiles repo, commit, and push
your changes to GitHub. If you are using multiple computesr, you can pull your
changes from GitHub when things get out of date. And since you're using Git, you
can even resolve merge conflicts and push up your fix when that happens.
