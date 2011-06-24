=head1 NAME

RefsIndex.pm   - Representation of the refs.index file from lustre

=head1 SYNOPSIS

use VRTrackCrawl::RefsIndex;
my $refs_index = VRTrackCrawl::RefsIndex->new( file_location => 't/data/refs.index');
$refs_index->assembly_ids_to_sequence_files;

=cut

package VRTrackCrawl::RefsIndex;

use strict;
use warnings;
use Moose;

has 'file_location' => ( is => 'rw', isa => 'Str', required => 1 );
has 'assembly_ids_to_sequence_files' => ( is => 'rw', isa => 'ArrayRef', lazy_build => 1 );

sub _build_assembly_ids_to_sequence_files
{
  my $self = shift;
  my @ref_index_split;
  
  open(FILE, $self->file_location) or die "Couldnt open refs.index file";
  while(<FILE>) {
    chomp;
    my @single_row = split("\t");
    push( @ref_index_split, \@single_row );
  }
  
  close(FILE);
  return \@ref_index_split ;
}

1;
