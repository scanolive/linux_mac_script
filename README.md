# Linux and Macos script

### 以mac开头的脚本只适用于Macos,其他的Linux和Macos通用

### shell
	alter_filename.sh filename
	---- 替换文件名的特殊字符
	
	alter_filename_dir.sh dirname
	---- 替换目录下所有文件名包含的特殊字符
	
	arg.sh arg1 arg2
	---- shell处理参数的示例脚本
	
	check_ssr.sh url
	---- 检查ssr订阅的各节点的可用性的速度,url为订阅地址
	
	copy_bak.sh filename
	---- 以时间戳为名复制备份文件
	
	cut_video.sh start_time seconds VideoFileNmae
	---- 用ffmpeg分割视频文件
	
	mac_cansleep.sh 
	---- 开启macos睡眠
	
	mac_nosleep.sh
	---- 关闭macos睡眠
	
	mac_dns.sh 
	---- 显示和修改macos的DNS配置
	
	mac_ftpd.sh start|stop
	---- 启动或关闭macos的ftp服务
	
	mac_iftraf.sh 
	---- 实时查看macos系统当前流量
	
	mac_image_snap.sh
	---- 开启前置摄像头并拍照,依赖imagesnap
	
	mac_init.sh 
	---- Macos初始化,谨慎使用
	
	mac_lunar.sh 
	---- Macos下命令行显示农历,依赖lunar
	
	mac_now_status.sh 
	---- 远程ssh到Macos,查看系统当前状态,如是否锁屏,是否合盖
	
	mac_screen_capture.sh 
	---- Macos命令行截屏
	
	mac_shadowsocket.sh start|stop
	---- Macos命令行ss客户端脚本,支持模式选择和节点选择
	
	mac_shutdown.sh
	---- 自定义Macos关机脚本,可在关机前执行某此操作,修改后替换/sbin/shutdown 

	mac_sleep_status.sh
	---- 查看Macos现在的是否可睡眠
	
	mac_tftpd.sh start|stop
	---- 启动或关闭macos的tftp服务

	mac_wifi.sh
	---- Macos命令行wifi脚本
	
	mv_back.sh filename
	---- 重命名备份文件
	
	re_extra_name.sh old_type new_type
	---- 批量修改文件的扩展名

	ssh_tun.sh local_port remote_port 
	---- ssh隧道启动和检测脚本,一般用于加入crontab,以保证ssh隧道断开自动重连,需配置远程IP并添加密钥可免密登录
	
	terminal_colors.sh
	---- 输出终端颜色
	
	trim_string.sh
	---- 自定义str函数
	
	url_filename.sh filename
	---- 处理下载文件名乱码文件
	
	
### python
	date_rs.py 
	---- 输出一个时间段的日期
	
	ende_crypt.py key str
	---- python加密解密函数示例
	
	mac_del_chrome_his.py 
	---- 删除chrome浏览器的历史记录
	
	mac_free.py 
	---- 显示macos的内存使用情况
	
	mac_rplist.py
	---- 查看Macos的plist文件,依赖biplist

	mac_searh_history.py
	---- 搜索Safari的历史记录
	
	mac_show_chrome_his.py
	---- 显示Macos下的chrome浏览器历史记录
	
	md5_16.py
	---- 获取字符串或文件的md5值的前16位
	
	random_num.py s_number e_number
	---- 获取某个范围的随机数
	
	send_mail.py
	---- 发送邮件,支持群发,附件,需要配置用于发邮件的邮箱相关信息
	
	send_mail_sig.py
	---- 发送邮件,支持群发,附件,需要配置用于发邮件的邮箱相关信息,额外 支持html签名
	
	simple_web.py
	---- 简单的web服务器,支持自定义目录和端口
	
	txt2img.py
	---- 文本转换成图片
	
	txt_to_exel.py
	---- txt文本转excel文件
	
	url2qrcode.py
	---- url转二维码
	
	wechat_getvoice.py
	---- 批量下载微信音频

	
### other
	line2row.awk filename 
	---- 行转列