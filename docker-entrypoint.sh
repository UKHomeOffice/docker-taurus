#!/bin/bash -x


[[ ${DEBUG} == 'true' ]] && set -x

bzt -l bzt.log *.yml
