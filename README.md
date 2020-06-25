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

```
$ cd ~
$ git clone --depth 1 https://github.com/wavebeem/dotfiles.git
$ cd dotfiles
$ rm -rf .git
$ git init
$ git add -A
$ git commit -m "Initial commit"
```

Then create a new repo on GitHub and follow the instructions for pushing an
existing Git repo to GitHub.

If you based your dotfiles on mine, please consider putting a link to my
dotfiles repo in your README :)

Now copy over files you'd like to keep, like:

```
$ cp ~/.zshrc zshrc
```

Note the dot in front of `zshrc` is missing on the second instance.

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
