#!/usr/bin/env perl
use strict;
use warnings;
use v5.10;
use POSIX qw(uname);
use File::Path qw(make_path remove_tree);
use File::Basename qw(dirname);

my $home = $ENV{HOME};
my $dotfiles = "$home/dotfiles";

sub install {
  my ($path) = @_;
  my $dest = "$home/.$path";
  install_as($path, $dest);
}

sub install_as {
  my ($path, $dest) = @_;
  if (-l $dest) {
    unlink($dest);
  } elsif (-e $dest) {
    if (!confirm("Delete $dest?")) {
      return;
    }
    remove_tree($dest);
  }
  my $dir = dirname($dest);
  if (!-d $dir) {
    make_path($dir);
  }
  my $src = "$dotfiles/$path";
  say($dest);
  symlink($src, $dest);
}

sub confirm {
  my ($message) = @_;
  print($message, " [Y/n] ");
  <STDIN> !~ /^n/i;
}

for my $file (
  "hushlogin",
  "welcome",
  "ackrc",
  "dircolors",
  "zshenv",
  "zshrc",
  "vimrc",
  "bashrc",
  "tmux.conf",
  "inputrc",
  "gitignore",
) {
  install($file);
};

my ($os) = uname();

if ($os eq "Darwin") {
  my $app_support = "$home/Library/Application Support";
  my $vscode = "$app_support/Code/User";
  my $aseprite = "$app_support/Aseprite";
  install("hammerspoon");
  install_as("vscode/keybindings.json", "$vscode/keybindings.json");
  install_as("vscode/settings.json", "$vscode/settings.json");
  install_as("vscode/snippets", "$vscode/snippets");
  install_as("aseprite-scripts", "$aseprite/scripts");
}
