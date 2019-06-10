#!/bin/bash

set -eu

PROJECT_ROOT=`dirname ${0}`/..
pushd ${PROJECT_ROOT} &>/dev/null

GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

echo ""
echo -e "${CYAN}Loading packages${NC}:"
echo ""
yarn --silent --check-files
echo -e "${GREEN}Done${NC}"

echo ""
echo -e "${CYAN}Checking for circular dependencies${NC}:"
echo ""
yarn --silent run madge -c --extensions ts,tsx src/

echo ""
echo -e "Running ${CYAN}TSC${NC}:"
echo -e "${GREEN}"
yarn run tsc

echo ""
echo -e "${NC}"
echo -e "Running ${CYAN}eslint${NC}:"
yarn --silent run eslint
echo ""
echo -e "${GREEN}No errors!${NC}"

echo ""
echo ""
echo -e "Running ${CYAN}tests${NC}:"
echo ""
CI=true yarn --silent run test --coverage

popd &>/dev/null
