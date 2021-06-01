#!/bin/bash
# update git submodule
git submodule update --remote --merge
git add src/utils
git commit -m 'Update utils.'



cat >> Dockerfile <<EOF
# setup OMNIBENCHMARK environment variables
ENV OMNI_DATA_RAW "${OMNI_DATA_RAW}"
ENV OMNI_DATA_PROCESSED "${OMNI_DATA_PROCESSED}"
ENV OMNI_DATA_NAMESPACE "${OMNI_DATA_NAMESPACE}"
EOF
git add Dockerfile
git commit -m 'Add omnidata env to dockerfile.'
