#!/usr/bin/perl
use strict;
use warnings;
use File::Path qw(make_path remove_tree);
use File::Basename;

my @files = qw(
    ackrc
    dircolors
    zshenv
    vim
    vimrc
    zshrc
    bashrc
    bash_profile
    tmux.conf
    inputrc
);

sub process {
    my ($f) = @_;
    my $HOME = $ENV{HOME};
    my $src = "$HOME/dotfiles/$f";
    my $dst = "$HOME/.$f";
    my $dir = dirname($dst);
    if (-l $dst) {
        unlink($dst);
    }
    elsif (-e $dst) {
        print("Delete $dst? [y/N]\n");
        return unless <STDIN> =~ /^y/i;
        remove_tree($dst);
    }
    print("$src -> $dst\n");
    make_path($dir) unless -d $dir;
    symlink($src, $dst);
}

process($_) for @files;
