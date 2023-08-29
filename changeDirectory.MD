## 利用别名或变量
```shell
alias work="cd $HONME/Work/Projects/Web/src/include
work
workspace=$HOME/Work/Projects/Web/src/include
cd $workspace
```
## 定义shell函数
```shell
# add in .bashrc
#define the qcd function
qcd () {
	# Accept 1 argument that's a string key,and perform a different
	case $1 in
		work)
			cd $HOME/Work/Projects/Web/src/include
			;;
		recipes)
			cd $HOME/Family/Cooking/Recipes
			;;
		video)
			cd /data/Arts/Video/Collection
			;;
		beatles)
			cd $HOME/Music/mp3/Artists/B/Beatles
			;;
		*)
			# The supplied argument was not one of the supported keys
			echo "qck: unknown key '$1'"
			return 1
			;;
		esac
		pwd
}
# Set up tab completion
complete -W "work recipes video beatles" qcd
```
## 利用CDPATH快速浏览文件系统
shell变量CDPATH设置cd的搜索目录
```shell
cd ~
CDPATH=$CDPATH:/usr
cd bin
```

## 通过pushd和popd在多个目录之间切换
pushd [dirname],添加目录到目录栈中,并跳转到目录。pushd不加参数，互相切换顶级的2个目录。
```shell
pushd .
dirs
dirs -p
dirs -p |nl -v0
dirs -v
cd errorpath
pushd -;pushd

```