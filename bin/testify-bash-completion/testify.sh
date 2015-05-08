TESTIFY_EXEC='testify'
BASE_TEST_PATH='yelp.tests.'

function _findTestCases() {
	python - "$@" <<ENDPYTHON
from testify import test_runner
import sys

if __name__ == '__main__':
	# TODO: include args for include/exclude, use parse_test_runner_command_line_args
	runner = test_runner.TestRunner(module_method_overrides={sys.argv[2]: None})
	runner.discover(sys.argv[1])
	for test in runner.test_case_classes:
		test_instance = test()
		for method in test_instance.runnable_test_methods():
			print method.__name__
ENDPYTHON

}

_testify()
{
	OLDIFS="$IFS"
	IFS=$'\n'
	OLDNULLGLOB="$(shopt -p nullglob)"
	shopt -s nullglob
	local cur prev opts base
	COMPREPLY=()
	cur="${COMP_WORDS[COMP_CWORD]}"
	prev="${COMP_WORDS[COMP_CWORD-1]}"

	# TODO: testify flags
	# TODO: suite name completion

	# If the last word was 'testify', complete filenames.
	if [[ "$prev" == "$TESTIFY_EXEC" ]]; then
		if [[ -z "$cur" ]]; then
			COMPREPLY=( "$BASE_TEST_PATH" )
		else
			PPATH="${cur//.//}"
			# Find directories, and add a / at the end of them.
			DIRS=( $(compgen -d -S '/' -- "$PPATH") )
			DIRS=( "${DIRS[@]//\//.}" )
			# Find files, and add a space at the end of them.

			FILES=()
			for FILE in "$PPATH"*.py
			do
				if [[ -f "$FILE" ]]; then
					PFILE="${FILE//\//.}"
					PFILE="${PFILE%%.py}"
					if [[ "$PFILE" =~ "$cur"* ]]; then
						FILES=( "${FILES[@]}" "${PFILE} " )
					fi
				fi
			done
			COMPREPLY=( "${COMPREPLY[@]}" "${DIRS[@]}" "${FILES[@]}" )
		fi
	fi

	# If prev is a python file, look for TestCases and tests
	PFILE="${prev//.//}".py
	if [[ -a "$PFILE" ]]; then
		P=$(compgen -W "$(_findTestCases "$prev")" -- "$cur")
		COMPREPLY=( ${COMPREPLY[@]} ${P[@]} )
	fi

	# TODO: this should split test case and function by a dot not a space

	# If prev-1 is a file and prev is a test case then looking for test functions
	# TODO: proper check for test case?
	if [[ ${#COMP_WORDS[@]} -gt 2 ]]; then
		prev_prev="${COMP_WORDS[COMP_CWORD-2]}"
		PFILE="${prev_prev//.//}".py
		if [[ -a "$PFILE" ]]; then
			P=$(compgen -W "$(_findTestMethods "$prev_prev" "$prev")" -- "$cur")
			COMPREPLY=( ${COMPREPLY[@]} ${P[@]} )
		fi
	fi
	IFS="$OLDIFS"
	$OLDNULLGLOB
	return 0
}
complete -o nospace -F _testify testify
