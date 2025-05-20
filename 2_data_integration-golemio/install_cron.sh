#!/bin/bash
DIR="$(cd "$(dirname "$0")" && pwd)"
CRON_JOB="0 7 * * * cd $DIR && ./run_extractor.sh >> $DIR/extractor.log 2>&1"

# Pridaj cron job len ak tam už nie je
(crontab -l 2>/dev/null | grep -F "$CRON_JOB") || (crontab -l 2>/dev/null; echo "$CRON_JOB") | crontab -

echo "Cron job bol nainštalovaný alebo už existoval."