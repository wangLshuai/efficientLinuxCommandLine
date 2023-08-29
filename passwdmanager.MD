```shell
cat >vault <<EOF
sall  fake1  google google.com account
ssmith  fake2 dropbox dropbox.com account for word
s999  fake3 bank Bank of America account, bankofamerica.com
smith2  fake4 blog  My blog at wordpress.org
birdy  fake5 dropbox2 dropbox.com account for home
EOF

# 生成秘钥对
gpg --quick-generate-key wangshuai@qq.com default default never
# 用公钥加密数据
gpg -e -r wang.lin.shuai@qq.com vault
ls vault.*
# 解密文件
gpg -d -q vault.gpg

# vim要直接编辑加密文件 可以安装vim-gnupg插件

```

pman.sh 脚本
```shell
./pman.sh google
xclip -o
xclip -o -sel c
./pman.sh account
./pman.sh nomatch

```