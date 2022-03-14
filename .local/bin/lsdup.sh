# deduplicate files by comparing size (only for greater than 100MB)
# 
# $1: source (directory with files to keep)
# $2: target (directoryy with files to discard)
# Only the files in target will be returned, which can be piped to xargs rm

# example 
# dedup.sh dir_to_keep/ MEGAsync\ Downloads/ | xargs -d $'\n' rm

du -ab "$1" | awk -F $"\t" '$1 > 10000000 {print;}' | sort > /tmp/keep
du -ab "$2" | awk -F $"\t" '$1 > 10000000 {print;}' | sort > /tmp/dup
join -j 1 -t $'\t' /tmp/keep /tmp/dup | column -t -s $'\t'
