# b_filechecker

Project testing program for 42 boost projects.

## Running the tests

To test your projects navigate to the root of b_filechecker's directory and run:

./run.sh [the test you want to run] [the path of your projects directory]

	[first param]			[second param]			[third param]
	b_libft				../b_libft
	b_printf			/tmp/b_printf
	b_ls				etc...

Debugging options:

	[first param]							[third param]
	cleanup				../path/
	diff				../path/
	project name			../path/			offline

			cleanup: removes "logs" folder from project directory.
			diff: compares the last saved outputs with diff and displays them
			offline: add this flag to supress auto updating


### What I evalue:

The existence and proper formatting of your "author" file.

The basic functionality of your Makefile.

The functionality of your programs/functions compared to the functionality of the programs/functions they are imitating.

## Author

* **Cameron Lambert**

