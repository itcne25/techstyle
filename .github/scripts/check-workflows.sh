#!/bin/bash

echo "lint=$( [ -f .github/workflows/lint.yml ] && echo true || echo false )" >> $GITHUB_OUTPUT
echo "test=$( [ -f .github/workflows/test.yml ] && echo true || echo false )" >> $GITHUB_OUTPUT
echo "build=$( [ -f .github/workflows/build.yml ] && echo true || echo false )" >> $GITHUB_OUTPUT
echo "deploy=$( [ -f .github/workflows/deploy.yml ] && echo true || echo false )" >> $GITHUB_OUTPUT
