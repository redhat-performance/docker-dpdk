#!/bin/sh

echo "Moving all rcuo threads to core 0"
for i in `pgrep rcuo`
  do taskset -pc 0 $i
done
echo "Done"
