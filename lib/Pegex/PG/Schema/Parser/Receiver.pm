use strict; use warnings;
package Pegex::PG::Schema::Parser::Receiver;
use Pegex::Base;
extends 'Pegex::Tree';

sub got_alter_statement {
  my ($self, $got) = @_;
  +{ 'alter-' . lc($got->[0]), $got->[1] };
}

sub got_create_table_statement {
  my ($self, $got) = @_;
  { 'create-table' => $got };
}

sub got_create_view_statement {
  my ($self, $got) = @_;
  { 'create-view' => $got };
}

sub got_create_function_statement {
  my ($self, $got) = @_;
  { 'create-function' => $got };
}

sub got_create_other_statement {
  my ($self, $got) = @_;
  my $creation = lc($got->[0]);
  $creation =~ s/ /-/g;
  +{ "create-$creation", $got->[1] };
}

sub got_other_statement {
  my ($self, $got) = @_;
  +{ lc($got->[0]), $got->[1] };
}

1;
