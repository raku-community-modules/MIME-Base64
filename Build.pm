use Panda::Common;
use Panda::Builder;
use Shell::Command;

class Build is Panda::Builder {
    method build($workdir) {
        if $*VM<name> eq 'parrot' {
            cp("$workdir/lib/MIME/Base64.pm6.parrot", "$workdir/lib/MIME/Base64.pm6");
        } else {
            cp("$workdir/lib/MIME/Base64.pm6.perl", "$workdir/lib/MIME/Base64.pm6");
        }
    }
}