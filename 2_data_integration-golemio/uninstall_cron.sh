#!/bin/bash
DIR="$(cd "$(dirname "$0")" && pwd)"
CRON_JOB="cd $DIR && ./run_extractor.sh >> $DIR/extractor.log 2>&1"

# Odstránime z crontabu všetky riadky, ktoré obsahujú tento cron job
crontab -l 2>/dev/null | grep -v -F "$CRON_JOB" | crontab -

echo "Cron job bol odstránený, ak existoval."
