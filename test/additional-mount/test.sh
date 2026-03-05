#!/bin/bash

set -e

source dev-container-features-test-lib

TARGET_PATH="/tmp/additional-mount-2"

check "target path exists" test -e "${TARGET_PATH}"
check "target path is mounted" bash -c "grep -q \" ${TARGET_PATH} \" /proc/self/mountinfo"

reportResults
