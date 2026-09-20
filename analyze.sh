#!/usr/bin/env bash

# Task 07: complete this script.
# Usage: ./scripts/analyze.sh FILE

# 1. 校验参数数量
if [[ $# -ne 1 ]]; then
    echo "Usage: $0 FILE"
    exit 1
fi

file="$1"

# 2. 校验文件是否存在
if [[ ! -f "$file" ]]; then
    echo "Error: file not found: $file"
    exit 1
fi

# 3. 统计 ERROR 总数
total_error=$(grep -c "ERROR" "$file")

# 4. 找出出现次数最多的 Code
top_code=$(awk '/ERROR/ {
        for (i = 1; i <= NF; i++) {
            if ($i ~ /^code=/) {
                split($i, a, "=")
                print a[2]
            }
        }
    }' "$file" \
    | sort \
    | uniq -c \
    | sort -rn \
    | head -n 1 \
    | awk '{print $2}')

# 5. 输出结果
echo "Total ERROR: $total_error"
echo "Top Code: $top_code"

exit 0
