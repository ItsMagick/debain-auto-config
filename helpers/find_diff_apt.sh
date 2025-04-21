#!/bin/bash

dpkg-query -Wf '${Package} ${Priority}\n' | grep -E 'required|important' | cut -d' ' -f1 | sort > base-system.txt
comm -23 \
  <(apt-mark showmanual | sort) \
  <(cat base-system.txt)

