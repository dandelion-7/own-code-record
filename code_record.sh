# common code record

## Bash commands

### scp transfering files
```bash
# scp transfering from local to remote clusters
scp -P 20606 uhgp.faa xiangyujia@166.111.153.65:/home/xiangyujia
```

### us `ls` to list all files and use comma to separate
```bash
ls ${subject}_*_dehosted.2.fastq | xargs | sed 's/ /,/g  
```
#`ls` would directly set new lines in the output, while `sed` takes each line to replace syntax, so the "\n" can't be replace directly with `sed`. `xargs` can represent the previous output and convert it to a thorough line for `sed`
