#!/bin/bash

source ./pantheon/env.sh > /dev/null 2>&1

echo "----------------------------------------------------------------------"
echo "PTN: validating" 

OUTPUT=$PANTHEON_RUN_DIR/cinema_databases/$PANTHEON_CDB
GOLD=validate/data/log_sampling.cdb

echo "     $OUTPUT"

dirs="0.0 1.0 2.0"
img="36.0_45.0_pantheon.cdb.png"

PASS=true
if [ -d $OUTPUT ]; then
    for val in $dirs; do
        if cmp "$OUTPUT/$val/$img" "$GOLD/$val/$img"; then
            echo "     Comparing images $GOLD/$val/$img"
        else
            echo "FILES differ:"
            echo "    $OUTPUT"
            echo "    $GOLD"
            PASS=false
        fi
    done
else
    echo "Cinema Database: $OUTPUT does not exist"
    PASS=false
fi

if $PASS; then
    echo "PTN: PASS"
    echo "----------------------------------------------------------------------"
else
    echo "PTN: FAIL"
    echo "----------------------------------------------------------------------"
    exit 1
fi

