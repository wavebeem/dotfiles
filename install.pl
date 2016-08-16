#!/usr/bin/perl
use strict;
use warnings;
use File::Path qw(make_path remove_tree);
use File::Basename;

my $HOME = $ENV{HOME};

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

my $normals = [
  ".hushlogin",
  ".jscsrc",
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
];

my $specials = [
  [
    "_sublime",
    "$HOME/Library/Application Support/Sublime Text 3/Packages/User"
  ]
];

install($_) for @$normals;
install_as(@$_) for @$specials;
