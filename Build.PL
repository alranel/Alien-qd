use strict;
use warnings;

use Alien::Base::ModuleBuild;

my $alien_provides_cflags = '';
my $alien_provides_libs   = '-lqd';

if(`qd-config --version`) {
  $alien_provides_cflags = `qd-config --cflags`;
  $alien_provides_libs   = `qd-config --libs`;
  chomp $alien_provides_cflags;
  chomp $alien_provides_libs;
}

my $builder = Alien::Base::ModuleBuild->new(
  module_name => 'Alien::qd',
  dist_abstract => 'Build and install libqd',
  license => 'perl',
  configure_requires => {
    'Module::Build' => 0.42,
    'Alien::Base::ModuleBuild' => 0.021,
  },
  requires => {
    'perl' => '5.8.1',
    'Alien::Base' => 0.021,
  },
  dist_author => 'Alessandro Ranellucci <aar@cpan.org>',
  alien_name => 'qd',
  alien_repository => {
    protocol => 'local',
    pattern  => qr/qd-([\d.]+)\.tar\.gz$/,
  },
  alien_build_commands => [
    '%c --prefix=%s --enable-shared', 
    'make',
  ],
  alien_install_commands => [
    'make install',
  ],
  alien_isolate_dynamic => 0,
  alien_version_check => 'qd-config --version',
  alien_provides_cflags => $alien_provides_cflags,
  alien_provides_libs => $alien_provides_libs,
  meta_merge => {
    'meta-spec' => {
      version => '2',
      url     => 'http://search.cpan.org/perldoc?CPAN::Meta::Spec',
    },
    resources => {
      bugtracker => {
        web => 'http://github.com/alexrj/Alien-qd/issues',
        mailto => 'aar@cpan.org',
      },
      repository  => {
        url  => 'git://github.com/alexrj/Alien-qd.git',
        web  => 'http://github.com/alexrj/Alien-qd',
        type => 'git',
      },
    },
  },
);
$builder->create_build_script;
