#!/bin/bash

#
# Exporting LaTeX report to README.md
#
cd report && pandoc -s report.tex -o ../README.md && cd ..
