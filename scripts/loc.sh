#!/usr/bin/env bash

scc --exclude-dir scripts --exclude-ext md,txt,.gitignore --no-cocomo --no-complexity -d
