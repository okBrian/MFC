#!/bin/bash

log "(venv) Running$MAGENTA pylint$COLOR_RESET on$MAGENTA MFC$COLOR_RESET's $MAGENTA""toolchain$COLOR_RESET."

pylint -d R1722,W0718,C0301,C0116,C0115,C0114,C0410,W0622,W0640,C0103,W1309,C0411,W1514,R0401,W0511,C0321,C3001 "$(pwd)/toolchain/"

exit $?
