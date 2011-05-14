use 5.008005;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME              => 'Linux::Prctl',
    VERSION_FROM      => 'lib/Linux/Prctl.pm',
    PREREQ_PM         => {},
    ($] >= 5.005 ?
      (ABSTRACT_FROM  => 'lib/Linux/Prctl.pm',
       AUTHOR         => 'Dennis Kaarsemaker <dennis@kaarsemaker.net>') : ()),
    LIBS              => [''],
    DEFINE            => '',
    INC               => '',
);
