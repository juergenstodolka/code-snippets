
use strict;

sub system_call_catch_stdout {
		my ($cmd, $log_file_stdout, $log_file_stderr) = @_;

		my $fh;
		open ($fh, '>', $log_file_stdout) or die "Could not open $fh: $!";
		die "$!" if $?;
		my $output = `$cmd 2>$log_file_stderr`;
		print $fh $output;
		close $fh;

		my $cmd_exit_code = $? >> 8;
		
		return $cmd_exit_code;
	}
