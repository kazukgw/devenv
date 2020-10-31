# 拡張子変換

``````
$ for filename in *.txt; do mv $filename ${filename%.txt}.txt.old; done
``````


