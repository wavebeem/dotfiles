#!/usr/bin/perl
use strict;
use warnings;
use File::Path qw(make_path remove_tree);
use File::Basename;

my $HOME = $ENV{HOME};
my $VSCODE = "$HOME/Library/Application Support/Code/User";

sub install {
  my ($file) = @_;
  my $dst = "$HOME/$file";
  install_as($file, $dst);
}

sub install_as {
  my ($file, $dst) = @_;
  my $dotless = $file;
  $dotless =~ s/^\.//;
  my $src = "$HOME/dotfiles/$dotless";
  my $dir = dirname($dst);
  if (-l $dst) {
    unlink($dst);
  }
  elsif (-e $dst) {
    print("Delete $dst? [y/N] ");
    return unless <STDIN> =~ /^y/i;
    remove_tree($dst);
  }
  print("$src -> $dst\n");
  make_path($dir) unless -d $dir;
  symlink($src, $dst);
}

install($_) for (
  ".hushlogin",
  ".welcome",
  ".ackrc",
  ".dircolors",
  ".zshenv",
  ".vimrc",
  ".zshrc",
  ".bashrc",
  ".tmux.conf",
  ".inputrc",
  ".gitconfig",
  ".config/fish/config.fish",
  ".config/fish/functions",
  ".atom/config.cson",
  ".atom/init.coffee",
  ".atom/keymap.cson",
  ".atom/snippets.cson",
  ".atom/styles.less",
);

install_as("vscode/keybindings.json", "$VSCODE/keybindings.json");
install_as("vscode/settings.json", "$VSCODE/settings.json");