#!/bin/bash

WATCH="$HOME/.config/hypr"
TARGET="$HOME/.hyprdots/Configs/.config/hypr"
REPO="$HOME/.hyprdots"

while true; do 
	inotifywait -r -e modify,create,delete,move "$WATCH" 
	sleep 5	

	rsync -a --delete "$WATCH/" "$TARGET/"
	
	cd "$REPO" || exit
	
	git add .

	if ! git diff --cached --quiet; then git commit -m "[ changed_on: $(date '+%Y-%m-%d %H:%M:%S') ]"
		git push
	fi
done
