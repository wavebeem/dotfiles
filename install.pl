#!/usr/bin/perl
use strict;
use warnings;
use File::Path qw(make_path remove_tree);
use File::Basename;

sub install {
    my ($f) = @_;
    my $HOME = $ENV{HOME};
    my $src = "$HOME/dotfiles/$f";
    my $dst = "$HOME/.$f";
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
    "ackrc",
    "dircolors",
    "zshenv",
    "vim",
    "vimrc",
    "zshrc",
    "bashrc",
    "bash_profile",
    "tmux.conf",
    "inputrc",
    "gitconfig",
    "config/fish/config.fish",
    "config/fish/functions",
    "Library/Application Support/Sublime Text 3/Packages/User",
);
