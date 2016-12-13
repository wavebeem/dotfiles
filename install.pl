#!/usr/bin/perl
use strict;
use warnings;
use File::Path qw(make_path remove_tree);
use File::Basename;

my $HOME = $ENV{HOME};
my $VSCODE = "$HOME/Library/Application Support/Code/User";
my $DOTFILES = "$HOME/dotfiles";

sub install {
  my ($path) = @_;
  my $dest = "$HOME/.$path";
  install_as($path, $dest);
}

sub install_as {
  my ($path, $dest) = @_;
  if (-e $dest) {
    if (-l $dest) {
      unlink($dest);
    } else {
      return unless confirm("Delete $dest? [y/N] ");
      remove_tree($dest);
    }
  }
  my $dir = dirname($dest);
  make_path($dir) unless -d $dir;
  my $src = "$DOTFILES/$path";
  print("$src -> $dest\n");
  symlink($src, $dest);
}

sub confirm {
  my ($message) = @_;
  print($message);
  <STDIN> =~ /^y/i;
}

install($_) for (
  "hushlogin",
  "welcome",
  "ackrc",
  "dircolors",
  "zshenv",
  "vimrc",
  "zshrc",
  "bashrc",
  "tmux.conf",
  "inputrc",
  "gitconfig",
  "config/fish/config.fish",
  "config/fish/functions",
);

install_as("vscode/keybindings.json", "$VSCODE/keybindings.json");
install_as("vscode/settings.json", "$VSCODE/settings.json");
