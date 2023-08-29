
# 命令
* 命令列表
  
  命令成功则执行 cmd && cmd2。前一个命令失败则执行 cmd1 || cmd2 ，前一个命令的输出重定向为第二个命令的标准输入 cmd1 | cmd2.
  无条件执行命令 cmd1;cmd2

* 命令替换

 将一个命令的输出做参数。 echo `cmd` 或 echo $(cmd)

 * 进程替换 把一个命令的输出做文件。
  
  cp <(ls -al) bkp_name

* 把命令做字符串传递给shell ,ssh
  
  sudo bash -c 'echo "new log file" > /var/log/custom.log'

  echo "ls -l" | bash

  ssh user@ip ls > outfile

  ssh user@ip "ls > outfile"

  * 通过xarg 执行命令。 xarg接受两个输入，标准输入和不完整的命令行。把标准输入作为命令行的参数执行。
  
  -n 参数说明命令接受一个参数，默认是1。-0 标准输入的分隔符是\0，避免把含空格的文件名作为两个字符。-I  占位符，使用他时限制只能有一个参数。
```shell
  ls |xargs -n2 echo
  ls |xargs -I xyz echo xyz test
  touch "test .txt"
  find -type f -print0 | xargs -0 ls

```
* 后台进程
  
  cmd &

  ctrl-Z 挂起命令 ，jobs 所有后台程序。bg %n 运行挂起程序。fg %n 把后台程序移到前台。kill %n 杀死后台进程


* 显示运行shell
  
启动一个新shell运行命令，命令结束，退出新shell，回到原来的shell。 (cmd)

## 1. wc 计数
``` shell
wc animals.txt
wc -l animals.txt
wc -w animals.txt
wc -c animals.txt
ls -l |wc
wc animals.txt |wc

```
## 2. head tail
head 可以输出前几行参数 -n[number]指定行数
tail 输出倒数几行
```shell
head -n3 animals.txt
ls /bin |head -n5
ls /bin |tail -n5
ls /bin |head 6 |tail 2
```

## 3. cut
cut 可以输出文件的一列或多列
-f使用分隔符分割，默认分割符使用tab，-d 指定分隔符
-c使用字符切割
```shell
cut -f2 animals.txt
cut -f1,3 animals.txt |head -n3
cut -f2-4 animals.txt 
cut -c1-3 animals.txt
cut -f4 animals.txt | cut -d, -f1
```

## 4. grep
输出匹配字符串的行
-v 参数，输出不匹配的行
-w 匹配整个单词
-i 忽略大小写
-l 输出包含匹配文本的文件名
-F 强制忽略正则表达式
-f 与一组字符匹配的行
grep awk sed 正则表达式
|匹配条件|写法|示例
|------------------|-----------------|-------------|
|一行字符的开头|^|^a:以a开头的一行|
|一行结尾的字符|$|!$:以感叹号（！）结尾的一行
|单个字符（换行符除外）|.|...:连续三个任意字符
|特殊字符转义|\c|\\$:一个美元符号
|表达式E出现零次或多次|E*|_*:下划线出现零次或多次
|集合中的任一字符|[字符集合]|[aeiouAEIOU]:任意元音字符
|集合以外的任意一个字符|[^字符集合]|[^aeiouAEIOU]:非元音字符
|指定范围的字符|[c1-c2]|[0-9]:任意数字
|指定范围外的字符|[^c1-c2]|[^0-9]:非数字字符
|表达式E1或E2中的一个| grep和sed: E1\\\|E2 | one\\\|two: one或two
||ask:E1\|E2|one\|two: one或two
|表达式E放到一组|grep或sed: \\(E\\)|\\(one\\\|two\\)*: one或two出现零次或多次
||awk: (E)|(one\|two)*
|||


```shell
grep Nutshell animals.txt
grep -v Nutshell animals.
ls -l /usr/lib/ | cut -c1 |grep d |wc -l
grep  his frost
grep -w his frost
grep -i his frost
grep -l his ./*
grep '^[A-Z]' #所有大写字母开头的行
grep  -v '^$' #多有非空行
grep 'cookie\|cake' myfile
grep '.....' myfile
grep 'w\.' frost
grep -F 'w.' frost
cut -d: -f7 |sort -u |grep -f /etc/shells -F
```

## 5. sort
sort 默认使用升序排列输出结果
-r 降序 -k 排序key
-n 数字排序
-u 去除重复
```shell
sort animals.txt
cut -f3 animals.txt | sort -n
```

## 6. uniq
检查文件中相邻且重复的行，默认行为去除相邻的重复行
```shell
uniq letterts
uniq -d letterts
uniq -c letterts
```

## 7. tr,rev
字符转换或者删除命令
-d 删除字符
-s 去除重复字符
rev反转字符串
```shell
echo $PATH | tr : "\n"
echo "a   b    c" |tr -s " "
echo {A..Z} | tr A-Z a-z
```

## 8. which和type
which查找程序位置，type还可以查找内置命令和别名
```shell
which ls
type source
type ll
```
## 9. shell 模式匹配
*匹配任意字符
？匹配一个任意字符
[12345]匹配指定字符
```shell
ls /etc/*.conf
```

## 10. date
可以按照各种格式输出日期时间
```shell
date
date +%Y-%m-%d
date _%H:%M:%S
```

## 11. seq
输出某范围的序列
默认分隔符是换行符，可以通过-s指定
-w 通过前导0统一宽度
```shell
seq 1 5
seq 1 2 10
seq 3 -1 0
seq 1.1 0.1 2
seq -s/ 1 5

```
## 12. 大括号扩展
{x..y..z} x到y增幅为z的序列
```shell
echo {1..10}
echo {1..10..2}
echo {A..Z}
alias nth="echo {A..Z} | tr -d " " |cut -c"
nth 10
```
## 13. find
-type f或者-type d。匹配文件或目录
-name "*.*"
-iname 忽略大小写
-exec 对每行执行shell命令，表达式{}表示文件路径 以";" 或者\;结尾
```shell
find /etc -print
find /etc -exec echo @ {} @ ";"
find /etc -type f -name "*.conf" -exec ls -al {} \;
```
## 14. yes
重复输入相同的字符串直到被终止，用于shell交互。类似expect?
```shell
yes
yes woof!
yee "Efficient Linux" |head -n3
```

## 15. nl
对每行增加行号
-v设置起始行号
```shell
ls -l |nl -v0
```

## 16. awk {print} 与sed
《sed & awk》
awk 程序 输入文件
awk -f 程序文件 -f 程序文件2 输入文件

程序包括一个或多个动作，当模式匹配时就会执行动作。如果没有模式，匹配所有的行，如果没有动作，输出输入。

模式 {动作}

常见的模式包括
* BEGIN
  
  在awk处理输入之前执行一次动作。
* END
  
  在awk处理完所有的输入之后执行一次动作
* 正则表达式
  
  用斜杠包围,例如/^[A-Z]/匹配大写字母开头的行

* awk特有的模式

	例如$3~/^[A-Z]匹配第三个字段是大写字母起始的行。例如FNR>5。行号大于5的行。
awk默认的列分割符是空格，参数-F指定分隔符。
awk 可以指定列号 $n，$7是第7列。大于10的列号需要小括号，$(25)。总列数$NF
awk print默认没有空格，需要空格可以使用，分割
```shell
echo Efficient fun Linux | awk '{print $1 $3}'
echo Efficient fun Linux | awk '{print $1,$3}'
ls -al /bin/ | head -n7 |nl -v0 |awk 'FNR>1 {print $1,$(10)}'
# 把python\tprogramming Python\t2010\tLutz,Mark转换为Lutz，Mark (2010). "Programming Python"
awk -F '\t' '{print $4 ,"("$3")"".", "\""$2"\""}' animals.txt
# 仅处理包含horse的行
 awk -F '\t' '/^horse/{print $4 ,"("$3")"".", "\""$2"\""}' animals.txt
# 仅处理2010年以后的书，即$3是否匹配^201
awk -F '\t' '$3~/^201/{print $4 ,"("$3")"".", "\""$2"\""}' animals.txt
# 输出标题和结尾
 awk -F '\t' 'BEGIN {print "Recent boiks:"} $3~/^201/{print "-",$4 ,"("$3")"".", "\""$2"\""} END {print "For more books, search the web"}' animals.txt 
# 设置变量并计算
 seq 1 100 |awk '{s+=$1} END {print s}'
# 设置map变量 key:value v[key], for (key in v) 遍历map
md5sum ./* | awk '{hash[$1]++} END {for (key in hash) print key,hash[key]}'
md5sum ./* | awk '{hash[$1]++;name[$1]=name[$1] " " $2}  END {for (key in hash) print key,hash[key] ,name[key]}'
#输出前10行
ls -l /bin/ |sed 10q 
ls -l /bin/ |awk 'FNR<=10'
#替换
echo image.jpg | sed 's/\.jpg/\.png/'
```
sed 通过sed脚本指令序列编辑文件。使用-e指定多个脚本。sed -e 脚本1 -e 脚本2 file
或者-f指定脚本文件。sed -f 脚本文件1 -f 脚本文件2 file.
典型的脚本是替换文件s/regexp/replacement/。删除第4行 sed 4d file。模式匹配删除 sed /regex/d file。行头添加字符串
sed 's/^/str/' file
可以在最后一个/后指定选项。g全局 ，i忽略大小写

* 匹配字表达式
  
  sed可以通过字表达式拆分行。通过\(regex\)定义字表达式，通过\n引用字表达式。最多可定义9个表达式
```shell
echo -e image.jpg.{1..3} | tr ' ' '\n' |sed 's/image\.jpg\.\([1-3]\)/image\1\.jpg/'
# 三个字表达式，\1 一个或更多字母组成的文件名。\2 三个字母组成的文件扩展名。\3 一个数字
echo -e 'apple.img.1\nbanana.png.2\ncarrot.jpg.3' | sed 's/\([a-z][a-z]*\)\.\([a-z][a-z][a-z]\)\.\([0-9]\)/\1\3\.\2/'
# 删除脚本
seq 10 14 |sed 4d
seq 101 200 | sed /[13579]$/d

```




## 17. cat tac 
cat可以将多个文件写入标准输出。他可以将多个文件首尾相连，cat就是concatenate连接
tac 反向组合文件
```shell
cat poem1 poem2 poem3 |tac
tac poem1 poem2 poem3
```

## 18. paste
把每个文件以列对列的方式结合起来,并以制表符分割开来。可以用-d指定分隔符。-s转置，把行做列
```shell
echo {1..10}.jpg |sed 's/ /\n/g'
echo {A..J}.jpg | sed 's/ /\n/g'
paste <(echo {1..10}.jpg |sed 's/ /\n/g') <(echo {A..J}.jpg |sed 's/ /\n/g') | sed 's/^/mv /'
# 输出文件名的长度。wc 统计字符串长度 echo "str" |wc -c
paste <(ls) <(ls | awk '{print "echo ", $0, "|wc -c"}' | bash)
paste <(seq -w 10 -1 3 |sed 's/\(.*\)/ch\1.jpg/') <(seq -w 11 -1 4 |sed 's/\(.*\)/ch\1.jpg/') |sed 's/^/mv /' |cat
```
## 19. diff
逐行对比差异。
1c1是说第一个文件的第一行和第二个文件的第一行有差异。2a3是说第2个文件添加了第三行。和quilt配合生成补丁。

## 20. shuf
按行洗牌文件,-n输出行数。$RANDOM是bash内置变量，随机值。pwgen 生成随机的字符串做文件名。
```shell
# 生成1000个文件，文件名随机。内容随机从words中抽取随机行
mkdir temp2 && cd temp2
yes 'shuf -n $RANDOM -o $(pwgen -N1 10).txt /usr/share/dict/words' |head -n1000 |bash
```

## 21. convert
convert生成随机图片。
```shell
mkdir image
yes 'convert -size 8x8 xc: +noise Random -scale 200x200 $(pwgen -N1 10).png' |head -n 100 |bash
```
## 22. crontab ,at
crontab -e 编辑crontab文件，配置重复任务。
at设置一次任务。
at 22:00 tomorrow
at> echo brush your teeth |mail $USER
at> ^D
atq 查看所有任务。
at -c 指定作业号

## 23. rsync
cp -a dir1 dir2 完全复制。rsync 可以只复制修改的。[linux的rsync示例](https://oreil.ly/7gHCi)

-a 归档 -v 详细输出 -n 模拟复制。-X 不会跨文件系统

## 24. xclip
x剪切板和主选则。ctrl-c 复制选中的文件到剪切板。ctrl-v 粘贴剪切板。选中自动复制到主选则，鼠标中键粘贴主选则
```shell
echo "hello" | xclip
echo "hello" | xclip -selection clipboard
echo "hello" | xclip -sel c
xclip -o 
```
