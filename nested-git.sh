#!/bin/sh

INIT="git submodule init"
UPDATE="git submodule update --remote"

InitAndUpdate() {
  local D="${1}"
  $INIT
  $UPDATE
  if [ "X${D}" != "X1" ]; then
    INIT="git submodule foreach ${INIT}"
    UPDATE="git submodule foreach ${UPDATE}"
    InitAndUpdate `expr $D - 1`
  fi
}

DEPTH="${1}"
if [ "X${DEPTH}" = "X" ]; then
  echo "Usage: ${0} DEPTH"
  exit 1
fi
if [ "X${DEPTH}" = "1" ]; then
  echo "Expected non-zero depth; got: ${DEPTH}"
  exit 1
fi
InitAndUpdate $DEPTH

