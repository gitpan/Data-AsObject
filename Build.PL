use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Data::AsObject',
    license             => 'perl',
    dist_author         => 'Petar Shangov <pshangov@yahoo.com>',
    dist_version_from   => 'lib/Data/AsObject.pm',
    build_requires => {
        'Test::More' => 0,
    },
    add_to_cleanup      => [ 'Data-AsObject-*' ],
    create_makefile_pl => 'traditional',
);

$builder->create_build_script();
