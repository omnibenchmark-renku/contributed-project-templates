#!/bin/bash
# install utils
if [ -d "src/utils" ]; then
  # update git submodule
	git submodule update --remote --merge
	git add src/utils
	git commit -m 'Update utils.'

	echo '.renku/cache/' > .gitignore
	git add .gitignore
	git commit -m 'add gitignore'
else
	git submodule add https://renkulab.io/gitlab/omnibenchmark/utils src/utils/
	git submodule update --init --recursive
	git commit -am 'Add utils submodule.'
	git push
fi


