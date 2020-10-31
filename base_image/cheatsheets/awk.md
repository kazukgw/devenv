# 参考

- https://www.gnu.org/software/gawk/manual/gawk.html

# if
``````
$ awk '{
if ($1 > 30) {
  x = $1 * 3
  print x
} else {
  x = $1 / 2
  print x
}
}' testfile
``````

# while loop
``````
$ awk '{
sum = 0
i = 1
while (i < 5) {
  sum += $i
  i++
}
average = sum / 3
print "Average:",average
}' testfile
``````
# for loop

```
$ awk '{
total = 0
for (var = 1; var < 5; var++) {
  total += $var
}

avg = total / 3
print "Average:",avg
}' testfile
``````

#
```
