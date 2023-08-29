## history
history输出shell历史命令，shell遍历HISTSIZE设置了历史记录的最大长度，-1是无限长。

## 重复调用历史记录的命令
* 通过方向键
* 历史记录展开
  
  通过特殊的表达式展开访问历史命令，表达式以!开始
  如果想要引用最近的，以某个特定字符串开始的命令，在特定字符串前加！
  如果想引用最近的，包含某个特定字符串的命令，在特定字符串前后加？
  可以通过命令在history中的id执行。可以指定负数，表示倒数第n个命令。
  !!前一条命令
  在命令后输入:p,输出命令，把命令添加到history到历史记录，但不执行命令。之后使用!!执行。
  !表达式不是命令，是shell字符串表达式
  ```shell
	echo "hello"
	!!
	cat /etc/passwd
	!echo
	!cat
	!?hello?
	history |grep hostname | head -n1
	!588
	！-1
	!rm:p
	echo "!!"
  ```
  前一个命令的最后一个字符串历史!$，前一个命令的全部参数!*
  删除之前先观察表达式展开，避免误删。
  ```shell
	ls *.txt
	rm !$
	ls *.txt *.log
	rm !*

  ```
* 增量搜索
  
  ctrl-R 进入增量搜索模式，两次ctrl-R 调出最近搜索并执行过的命令。esc、ctrl-j退出增量搜索，继续当前命令。ctrl-G,ctrl-C退出并清空命令行

## 命令行编辑
* 移动光标

	最慢、最弱的一种方法，但是简单。
	左右方向键移动一个字符。ctrl+方向键移动一个单词。home,end,退格，删除。
* 脱字符表示法
  
  这是历史记录展开的一种方式
  ```shell
	echo jg jg jg
	^jg^jpg		#只会替换第一个字符串
	!echo:s/jg/jpg/
	!echo:s/jg/jpg/g
  ```
* emacs或vim风格的按键

 	set -o vim