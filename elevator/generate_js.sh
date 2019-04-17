#!/bin/bash
ElevatorAddress=0xefe292bb9344d24e847486b204cbf5555827c969
cat template.js | \
	sed -e "s/%INI%/${ElevatorAddress}/g" | \
	sed -e "s/%ABI%/`cat build/ArichBuilding.abi`/g" | \
	sed -e "s/%DATA%/`cat build/ArichBuilding.bin`/g" > build/ArichBuilding.js

