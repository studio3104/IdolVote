package IdolVote::Songs;

use strict;
use warnings;
use utf8;

use Path::Class;
use IdolVote::Config;

my $songs = [
    map {
        my ($song_name, $song_index) = split /\t/, $_;
        $song_name;
    } split /\n/, config->root->file('data/songs.tsv')->slurp
];

my $votes  = {};
my $voters = {};

sub songs {
    return $songs;
}

sub song {
    my ($class, $song) = @_;

    return {
        name => $song,
        vote => $votes->{$song},
    };
}

sub vote {
    my ($class, $song, $serial) = @_;
    return if $voters->{$serial};

    $voters->{$serial}++;
    $votes->{$song}++;
    use Data::Dumper;
    warn Dumper($song);
    warn Dumper($voters);
    warn Dumper($votes);
}

1;
