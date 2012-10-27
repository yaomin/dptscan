#!/usr/bin/perl
## bowtie-parser.pl
## By Yaomin Xu
## Jan 2011

## Usage: 
## Bowtie_parser.pl 50 36 120 bowtieInputFile.bow
use File::Basename;
use strict;

if ($#ARGV != 3) {
  print "usage: bowtie-parser.pl winsize readsLength meanExtSize bowtieInputFile.bow\n";
  exit;
}

my $window = $ARGV[0];
my $file = $ARGV[3];
my $filename = basename($file);
my $meanLength = $ARGV[2];
my $readslength = $ARGV[1];

my $n = 0;
my $u = 0;
my %once;
my %genome;
my %end;
my %uniqF;
my %uniqR;

open (IN, "$file");
while (<IN>) {
    chomp;
    my @line = split /\s+/, $_;
    if ($line[3] == 0) {
	my $chr = $line[1];
	my $test = 0;
	$n++;
	if (($line[0] eq "+")&&(!defined $uniqF{$chr}{$line[2]})) {
	    $test = 1;
	    $uniqF{$chr}{$line[2]} = 1;
	}
	elsif (($line[0] eq "-")&&(!defined $uniqR{$chr}{$line[2]})) {
	    $test = 1;
	    $uniqR{$chr}{$line[2]} = 1;
	}	
	if ($test == 1) {
	    $u++;
	    my $beg;
	    if ($line[0] eq "+") {$beg = $line[2]}
	    else {
	      $beg = $line[2] + $readslength - $meanLength;
	      if ($beg < 0) {$beg =0};
	    }
	    
	    my $wstart = int($beg/$window);
	    my $wend=int(($beg+$meanLength)/$window);
        
	    if ( (($wstart+1)*$window - $beg) < int($window/2) ) {$wstart = $wstart + 1}
	    if ( ($beg+$meanLength) - $wend*$window < int($window/2) ) {$wend = $wend -1}
	    
        
	    for (my $w=$wstart; $w < $wend+1; $w++) {
	      if (defined $genome{$chr}) {
                if (defined $genome{$chr}[$w]) {$genome{$chr}[$w] = $genome{$chr}[$w] + 1}
                else {$genome{$chr}[$w] = 1}
                if ($end{$chr} < $w) {$end{$chr} = $w}
	      }
	      else {
                $genome{$chr}[$w] = 1;
                $end{$chr} = $w;
	      }
	    }
	  }
      }
  }
close IN;
print STDERR "done parsing $file\n";
print STDERR "$n sequence uniquely mapped\t$u sequences unique\n";

open (OUT, ">$filename\.${window}bp.txt") || die "Sorry, I couldn't create $file\$window\bp.txt";

my @results;
foreach my $g (keys%genome) {
    for (my $w = 0; $w < (1+ $end{$g}); $w++) {
	my $pos = $w*$window;
	my $end = $pos + $window;
	if ((defined $genome{$g}[$w])&&($genome{$g}[$w] > 0)) {print OUT "$g\t$pos\t$end\t$genome{$g}[$w]\n"}
	if (defined $genome{$g}[$w]) {$results[$genome{$g}[$w]]++}	
    }
}

close OUT;
exit;
		
