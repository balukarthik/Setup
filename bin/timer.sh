#!/bin/bash
# Generic timer for CSV trackers
# Usage: timer.sh start <file> [type]  - start timing
#        timer.sh stop [extra_fields]  - stop and log entry
#        timer.sh status               - show elapsed time
#
# Auto-fills: type, duration, end_time/date/datetime
# Extra header columns (steps, angle, etc.) must be passed to stop
#
# Examples:
#   timer.sh start brush.csv        # type defaults to last entry's type
#   timer.sh stop                   # logs: b, <duration>, <end_time>
#
#   timer.sh start shower.csv c
#   timer.sh stop 60               # logs: c, 60, <duration>, <date>
#
#   timer.sh start c_walk.csv e
#   timer.sh stop 5000             # logs: e, 5000, <end_time>, <duration>

NOTES_DIR="$HOME/github/balukarthik/Notes"
TMP_FILE="$HOME/.timer_start"

resolve_file() {
    local f="$1"
    [ -f "$f" ] && echo "$f" && return
    # Check NOTES_DIR and subdirectories
    for dir in "$NOTES_DIR" "$NOTES_DIR"/*/; do
        [ -f "$dir/$f" ] && echo "$dir/$f" && return
    done
    return 1
}

case "$1" in
    start)
        file="$2"
        if [ -z "$file" ]; then
            echo "Usage: timer.sh start <file> [type]"
            exit 1
        fi
        file=$(resolve_file "$file")
        if [ -z "$file" ]; then
            echo "File not found: $2"
            exit 1
        fi
        if [ -n "$3" ]; then
            type="$3"
        else
            # Default type from most recent entry
            header_line=$(grep -n "^[a-z].*," "$file" | head -1 | cut -d: -f1)
            type=$(sed -n "$((header_line + 1))p" "$file" | cut -d, -f1 | xargs)
        fi
        timestamp=$(date "+%m%d%Y %H%M")
        echo "$file $type $timestamp" > "$TMP_FILE"
        echo "Timer started for $(basename "$file") at $timestamp (type=$type)"
        ;;
    stop)
        if [ ! -f "$TMP_FILE" ]; then
            echo "No timer in progress. Run: timer.sh start <file>"
            exit 1
        fi
        read file type start_date start_time < "$TMP_FILE"
        end_time=$(date "+%m%d%Y %H%M")
        end_epoch=$(date +%s)
        start_epoch=$(date -d "$(echo $start_date | sed 's/\(..\)\(..\)\(....\)/\3-\1-\2/') $(echo $start_time | sed 's/\(..\)\(..\)/\1:\2/')" +%s)
        duration=$(awk "BEGIN {printf \"%.2f\", ($end_epoch - $start_epoch) / 60}")

        # Read header to determine format
        header_line=$(grep -n "^[a-z].*," "$file" | head -1 | cut -d: -f1)
        header=$(sed -n "${header_line}p" "$file")

        # Build entry based on header columns
        IFS=',' read -ra cols <<< "$header"
        shift  # remove 'stop'
        extra_idx=0
        entry=""
        for col in "${cols[@]}"; do
            col=$(echo "$col" | xargs)
            [ -n "$entry" ] && entry="$entry, "
            case "$col" in
                type) entry+="$type" ;;
                duration) entry+="$duration" ;;
                end_time|date|datetime) entry+="$end_time" ;;
                *)
                    if [ $extra_idx -lt $# ]; then
                        extra_idx=$((extra_idx + 1))
                        entry+="${!extra_idx}"
                    else
                        echo "Missing value for '$col'. Usage: timer.sh stop <$col> ..."
                        exit 1
                    fi
                    ;;
            esac
        done

        sed -i "${header_line}a $entry" "$file"

        rm "$TMP_FILE"
        echo "Logged: ${duration}min -> $(basename "$file")"
        echo "Entry: $entry"

        # Sync
        cd "$NOTES_DIR" && ../Scripts/sync-one.sh
        ;;
    status)
        if [ -f "$TMP_FILE" ]; then
            read file type start_date start_time < "$TMP_FILE"
            start_epoch=$(date -d "$(echo $start_date | sed 's/\(..\)\(..\)\(....\)/\3-\1-\2/') $(echo $start_time | sed 's/\(..\)\(..\)/\1:\2/')" +%s)
            now_epoch=$(date +%s)
            elapsed=$(( (now_epoch - start_epoch) / 60 ))
            echo "Timer running for $(basename "$file"): ${elapsed}min (type=$type)"
        else
            echo "No timer in progress."
        fi
        ;;
    *)
        echo "Usage: timer.sh {start <file> [type]|stop [extra_fields]|status}"
        ;;
esac
