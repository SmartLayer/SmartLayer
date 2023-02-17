# deduplicate files by comparing size (only for greater than 100MB)
# 
# $1: source (directory with files to keep)
# $2: target (directoryy with files to discard)
# Only the files in target will be returned, which can be piped to xargs rm

# example 
# dedup.sh dir_to_keep/ MEGAsync\ Downloads/ | xargs -d $'\n' rm

# dedup.sh -s


du -ab "$1" | awk -F $"\t" '$1 > 10485760 {print;}' | sort -k1,1 -t $'\t'   > /tmp/keep
du -ab "$2" | awk -F $"\t" '$1 > 10485760 {print;}' | sort -k1,1 -t $'\t'   > /tmp/dup
# show only the duplicates with same filename
#join -j 1 -t $'\t' /tmp/keep /tmp/dup | awk -F $"\t" '{fn1 = $2; fn2 = $3; sub(/.*\//, "", fn1);sub(/.*\//, "", fn2); if (fn1 == fn2) print $3;}' 
join -j 1 -t $'\t' /tmp/keep /tmp/dup | awk -F $"\t" '{print $3;}' 
