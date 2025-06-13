#!/bin/bash
# Get date components for 2 days ago (Latest meter readings are available from 2 days ago)
backdate=2
seconds=86400*backdate 
timestamp=$(( $(date +%s) - seconds ))
year=$(date -d @$timestamp +%Y)
month=$(date -d @$timestamp +%m)
day=$(date -d @$timestamp +%d)
date_str="${day}.${month}.${year} 00:00"

# Function to process usage data
process_usage() {
    local type=$1
    local unit=$2
    local value=$(awk -F';' -v target=$day '$1 == target {print $2}' "/share/dewa/${type}_daily_${year}-${month}.csv" | tr -d '\r\n')
    local last_total=$(tail -n1 "${type}_history.csv" | awk -F',' '{print $5}' | tr -d '\r\n')
    local new_total=$(awk -v last="$last_total" -v current="$value" 'BEGIN {printf "%.2f", last + current}' | tr -d '\r\n')
    echo "sensor:${type}_usage,${unit},${date_str},$value,$new_total" >> "${type}_history.csv"
}

# Process electricity and water usage
process_usage "electricity" "kWh"
process_usage "water" "m³"
