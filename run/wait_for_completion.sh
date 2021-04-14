#!/bin/bash

source pantheon/env.sh > /dev/null 2>&1

time=-$(date +%s); 
while [ "$(bjobs 2>&1 | grep "$PANTHEON_WORKFLOW_JID")" ]; do 
  clear; 
  echo ===========================================; 
  echo ">>>  Job(s) running ($(( $(date +%s) + ${time} )) seconds elapsed)";
  echo ===========================================; bjobs; 
  sleep 5; 
done;
echo "Jobs have finished running."
