use strict; use warnings;
package Pegex::PG::Schema::Parser::Receiver;
use Pegex::Base;
extends 'Pegex::Tree';
use boolean;

sub got_create_table_statement {
  my ($self, $got) = @_;
  my ($name, $columns) = @$got;
  {
    type => 'table',
    name => $name,
    cols => $columns,
  };
}

sub got_column_definition {
  my ($self, $got) = @_;
  my ($name, $type) = @{$got->[0]};
  my $col = {
    type => $type,
    name => $name,
  };
  if (grep /^NOT NULL$/, @$got) {
    $col->{'not null'} = 1;
  }
  return $col;
}

sub got_constraint {
  return;
}

sub got_alter_statement {
  return;
  my ($self, $got) = @_;
  +{ 'alter-' . lc($got->[0]), $got->[1] };
}

sub got_create_view_statement {
  return;
  my ($self, $got) = @_;
  { 'create-view' => $got };
}

sub got_create_function_statement {
  return;
  my ($self, $got) = @_;
  { 'create-function' => $got };
}

sub got_create_other_statement {
  return;
  my ($self, $got) = @_;
  my $creation = lc($got->[0]);
  $creation =~ s/ /-/g;
  +{ "create-$creation", $got->[1] };
}

sub got_other_statement {
  return;
  my ($self, $got) = @_;
  +{ lc($got->[0]), $got->[1] };
}

1;
