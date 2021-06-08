#!/bin/bash
# update git submodule
git submodule update --remote --merge
git add src/utils
git commit -m 'Update utils.'

echo '.renku/cache/' > .gitignore