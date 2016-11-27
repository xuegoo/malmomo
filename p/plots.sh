#!/usr/bin/env bash
if [[ $# -ne 1 ]]; then
  echo "usage: $0 glob_to_run_outs"
  exit 1
fi

set -ex

./p/emit_stats.py --emit=losses --max-episode=5000 $1 > /tmp/l.tsv &
./p/emit_stats.py --emit=rewards --max-episode=5000 $1 > /tmp/r.tsv &
./p/emit_stats.py --emit=turn_moves --max-episode=5000 $1 > /tmp/mt.tsv &
wait

Rscript --vanilla ./p/emit_plots.R
eog /tmp/plots.png
