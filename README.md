# [gd-utils](https://github.com/iwestlin/gd-utils)的[Docker版](https://hub.docker.com/r/gdtool/gd-utils-docker),快速搭建google drive 转存工具

# fork from https://github.com/gdtool/gd-utils-docker
删除了网页版shell和文件管理器，增加了rclone，方便自动转存到其他网盘，压缩镜像大小到147M

**docker内包含:**
~~- **网页版shell**:方便执行git pull等命令~~
~~- **文件管理器**,方便上传sa文件以及编辑配置文件和备份数据库~~
- **gd-utils机器人**
- **rclone**
> 具体gd-utils教程请移步官网: [gd-utils](https://github.com/iwestlin/gd-utils)


# 注意:

为方便持久化,源代码的`/gd-utils/config.js` 和 ` /gd-utils/gdurl.sqlite` 已经软链接到目录`/gd-utils/sa/`

# 简单使用方法:
 1. 启动容器,假设挂载目录为`/root/gd-utils/sa`以及rclone配置文件目录`/gd-utils/rclone`
 ```
docker run --restart=always  -d \
-e USERPWD="pwd123456" \
-p 23333:23333 \
--name gd-utils-rclone \
-v /root/gd-utils/sa:/gd-utils/sa \
-v /root/gd-utils/rclone:/root/.config/rclone \
x2009again/gd-utils-rclone
```
  2. 修改配置文件`/root/gd-utils/sa/config.js`
  3. 上传sa文件到`/root/gd-utils/sa/`
  4. 上传rclone.conf到`/gd-utils/rclone`,rclone.conf需要gd和其他网盘配置，如果config.js中没有配置GD_root_Path或者OneDrive_Path，可以跳过此步，不转存到其他网盘
  4. 重启容器
  
~~> 如果使用云容器,可以打开`localhost:80`进入容器文件管理器(账号密码`admin`),修改、上传配置文件~~

# 其他说明爱看就看,不看也没事儿:

~~**4200端口:** webshell,账号:`gd`,密码:`pwd123456`~~

**23333端口:** gd-utils机器人

~~**80端口:** 文件管理默认启动,**注意安全**~~
~~**默认不启动**  **默认不启动**   **默认不启动**~~
~~> 启动方法:登录webshell;`su root` 然后执行`cd / && filebrowser &`,~~
~~账号密码:admin~~

**持久化目录:** 

/gd-utils/sa/
为方便持久化,源代码的`/gd-utils/config.js` 和 ` /gd-utils/gdurl.sqlite` 已经软链接到目录`/gd-utils/sa/`  
/gd-utils/rclone/为rclone配置目录，里面会有转存错误的任务id，文件过大时会中途产生progress<taskid>.log文件方便查看日志


## 原项目
[gd-utils](https://github.com/iwestlin/gd-utils)

## 相关项目(感谢这些开源项目)

[gd-utils](https://github.com/iwestlin/gd-utils)

[shellinabox](https://github.com/shellinabox/shellinabox)

[filebrowser](https://github.com/filebrowser/filebrowser/)

## 脚本参考

[iouAkira](https://github.com/iouAkira/someDockerfile)

[mics8128](https://github.com/mics8128/gd-utilds-docker)
